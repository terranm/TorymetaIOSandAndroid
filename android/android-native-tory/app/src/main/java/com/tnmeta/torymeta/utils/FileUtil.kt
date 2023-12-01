package com.tnmeta.torymeta.utils

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.ImageDecoder
import android.graphics.Matrix
import android.media.ExifInterface
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.util.Log
import android.util.Size
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import java.io.BufferedInputStream
import java.io.File
import java.io.FileOutputStream
import java.text.SimpleDateFormat
import java.util.*

object FileUtil {
    fun saveBitmapToJpeg(context: Context, bitmap: Bitmap): String {
        try {
            val storage = context.cacheDir
            val now = SimpleDateFormat("yyMMdd_HHmmss").format(Date())
            val fileName = "img_$now.jpg"

            val tempFile = File(storage, fileName)
            tempFile.createNewFile()

            val fos = FileOutputStream(tempFile)
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos)

            fos.flush()
            fos.close()

            return tempFile.absolutePath

        } catch (e:Exception) {
            e.printStackTrace()
            return ""
        }
    }

    fun getBitmap(context: Context, uri: Uri): Bitmap? {
        return try {
            if( Build.VERSION.SDK_INT >= Build.VERSION_CODES.P ) {
                ImageDecoder.decodeBitmap(ImageDecoder.createSource(context.contentResolver, uri))
            } else {
                MediaStore.Images.Media.getBitmap(context.contentResolver, uri)
            }
        } catch (e:Exception) {
            e.printStackTrace()
            null
        }
    }

    fun resizeBitmap(context: Context, uri: Uri, width: Int, height: Int): Bitmap {
//        val origin = getBitmap(context, uri)!!
//        Log.i("d1", "origin size: ${origin.width}, ${origin.height}, ${origin.allocationByteCount}")

        // 1. 리사이징 - inSampleSize
        val metaData = getBitmapMetaData(context, uri)
        val options = BitmapFactory.Options().apply {
            inSampleSize = calculateInSampleSize(metaData, width, height)
        }
        var bitmap = BitmapFactory.decodeStream(context.contentResolver.openInputStream(uri)!!, null, options)!!

        // 2. 회전 복원
        val exif = ExifInterface(context.contentResolver.openInputStream(uri)!!)
        bitmap = fixBitmapOrientation(bitmap, exif)
        // bitmap = fixBitmapOrientation(bitmap, ExifInterface(uri.path!!))

        // 3. 리사이징 - ScaledBitmap
        return resizeBitmap(bitmap, width, height)
    }

    private fun resizeBitmap(bitmap: Bitmap, width: Int, height: Int): Bitmap {
        if( bitmap.width <= width && bitmap.height <= height ) {
            return bitmap
        }

        // ScaledBitmap
        val newSize: Size = run {
            val ratio: Float = bitmap.height.toFloat() / bitmap.width

            if( bitmap.width > bitmap.height ) {
                Size(width, (width * ratio).toInt())
            } else {
                Size((height / ratio).toInt(), height)
            }
        }

        val resizedBitmap = Bitmap.createScaledBitmap(bitmap, newSize.width, newSize.height, true)
        bitmap.recycle()

        return resizedBitmap
    }

    private fun fixBitmapOrientation(bitmap: Bitmap, exif: ExifInterface): Bitmap {
        val rotate: (Int) -> Bitmap = { degree ->
            val matrix = Matrix().apply {
                postRotate(degree.toFloat())
            }
            val rotateBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.width, bitmap.height, matrix, true)
            bitmap.recycle()

            rotateBitmap
        }

        val orientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL)

        return when( orientation ) {
            ExifInterface.ORIENTATION_ROTATE_90 -> rotate(90)
            ExifInterface.ORIENTATION_ROTATE_180 -> rotate(180)
            ExifInterface.ORIENTATION_ROTATE_270 -> rotate(270)
            else -> bitmap
        }
    }

    private fun getBitmapMetaData(context: Context, uri: Uri): BitmapFactory.Options {
        val options = BitmapFactory.Options().apply {
            inJustDecodeBounds = true
        }

        val input = context.contentResolver.openInputStream(uri)
        BitmapFactory.decodeStream(input, null, options)

        return options
    }

    private fun calculateInSampleSize(options: BitmapFactory.Options, reqWidth: Int, reqHeight: Int): Int {
        // Raw height and width of image
        val (height: Int, width: Int) = options.run { outHeight to outWidth }
        var inSampleSize = 1

        if( height > reqHeight || width > reqWidth ) {
            val halfHeight: Int = height / 2
            val halfWidth: Int = width / 2

            // Calculate the largest inSampleSize value that is a power of 2 and keeps both
            // height and width larger than the requested height and width.
            while( halfHeight / inSampleSize >= reqHeight && halfWidth / inSampleSize >= reqWidth ) {
                inSampleSize *= 2
            }
        }

        return inSampleSize
    }
}