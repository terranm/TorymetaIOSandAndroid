package com.tnmeta.torymeta.utils

import android.app.Activity
import android.app.ProgressDialog
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.res.Resources
import android.graphics.Bitmap
import android.graphics.Point
import android.graphics.Rect
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.NetworkInfo
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Base64
import android.util.DisplayMetrics
import android.view.*
import java.io.ByteArrayOutputStream
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.*
import javax.crypto.Cipher
import javax.crypto.SecretKey
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec


class Utilts : Any() {
    fun View.setAllParentsClip() {
        var parent = parent
        while (parent is ViewGroup) {
            parent.clipChildren = false
            parent.clipToPadding = false
            parent = parent.parent
        }
    }

    fun recursiveRefresh(parent: ViewGroup) {

        parent.requestLayout()
        parent.invalidate()

        for( i in 0 until parent.childCount ) {
            val child = parent.getChildAt(i)
            if( child is ViewGroup ) {
                recursiveRefresh(child)
            } else {
                child.requestLayout()
                child.invalidate()
            }
        }
    }


    fun isAppInstalled(context: Context, packageName: String): Boolean {

        try {
            var pi = context.packageManager.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES);
        } catch(e: PackageManager.NameNotFoundException) {
            return false
        }

        return true
    }

    fun runMarket(activity: Activity, uri: Uri) {
        var intent = Intent(Intent.ACTION_VIEW, uri)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        activity.startActivity(intent)
    }

    fun runMarket(activity: Activity, packageName: String) {
        runMarket(activity, Uri.parse("market://details?id=$packageName"))
    }

    fun runBrowser(activity: Activity, url: String) {
        try {
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
            activity.startActivity(intent)
        } catch(e: Exception) {
            e.printStackTrace()
        }
    }

    fun runAppSetting(activity: Activity) {
        try {
            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
            intent.data = Uri.parse("package:${activity.packageName}")
            activity.startActivity(intent)
        } catch(e: ActivityNotFoundException) {
            e.printStackTrace()

            try {
                val intent = Intent(Settings.ACTION_MANAGE_APPLICATIONS_SETTINGS)
                activity.startActivity(intent)
            } catch(e: Exception) {
                e.printStackTrace()
            }
        }
    }


    @Throws(IOException::class)
    fun readTextFromAssets(context: Context, file: String): String {
        val inputStream = context.assets.open(file)
        val size = inputStream.available()
        val buffer = ByteArray(size)

        inputStream.read(buffer)
        inputStream.close()

        return String(buffer)
    }


    fun dpToPx(dp: Int): Int {
        return (dp * Resources.getSystem().displayMetrics.density).toInt()
    }


    fun pxToDp(px: Int): Int {
        return (px / Resources.getSystem().displayMetrics.density).toInt()
    }


    fun dpToPx(dp: Float): Float {
        return dp * Resources.getSystem().displayMetrics.density
    }


    fun pxToDp(px: Float): Float {
        return px / Resources.getSystem().displayMetrics.density
    }

    /**
     * 기기의 실제 해상도를 반환합니다
     */
    fun getRealScreenSize(activity: Activity): Point {
        val metrics = DisplayMetrics()
        activity.windowManager.defaultDisplay.getRealMetrics(metrics)
        return Point(metrics.widthPixels, metrics.heightPixels)
    }

    /**
     * 기기의 실제 해상도에서 상태바, 네비게이션바 크기를 제외한 사이즈를 반환합니다
     */
    fun getScreenSize(activity: Activity): Point {
        val metrics = DisplayMetrics()
        activity.windowManager.defaultDisplay.getMetrics(metrics)
        return Point(metrics.widthPixels, metrics.heightPixels)
    }

    fun getDPI(): Int {
        return Resources.getSystem().displayMetrics.densityDpi
    }

    fun getDpiDump(activity: Activity): String {
        val sizeInPx = getRealScreenSize(activity)
        val sizeInDp = Point(pxToDp(sizeInPx.x), pxToDp(sizeInPx.y))

        var str = "DPI : ${getDPI()}" + "\n"
        str += "screenSizeInPx : ${sizeInPx.x},${sizeInPx.y}" + "\n"
        str += "screenSizeInDp : ${sizeInDp.x},${sizeInDp.y}"
        return str
    }

    fun isOnline(ctx: Context): Boolean {
        val connMgr = ctx.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val networkInfo: NetworkInfo? = connMgr.activeNetworkInfo
        return networkInfo?.isConnected == true
    }

    fun getCurrentTime(format: String): String {
        return SimpleDateFormat(format).format(Date())
    }

    fun bitmapToBytes(bitmap: Bitmap, quality: Int): ByteArray {
        val stream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.JPEG, quality, stream)
        return stream.toByteArray()
    }

    /*
     * View Utils
     */
    fun View.isTouchInside(e: MotionEvent): Boolean {
        val p = IntArray(2)
        getLocationOnScreen(p)

        val boundingBox = Rect(p[0], p[1], p[0] + width, p[1] + height)
        return boundingBox.contains(e.rawX.toInt(), e.rawY.toInt())
    }


    fun netWorkCheck(context: Context): Boolean {

        try {
            val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

            if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val n = cm.activeNetwork
                if (n != null) {
                    val nc = cm.getNetworkCapabilities(n)
                    return nc!!.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) || nc.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)
                }
                return false
            }else {
                val activeNetwork = cm.activeNetworkInfo
                return activeNetwork != null && activeNetwork.isConnectedOrConnecting
            }

        } catch (e: Exception) {
            e.printStackTrace()
        }

        return false
    }

    fun getCurrentWeek(): Int {
        val currentDate = Date()
        val calendar = Calendar.getInstance()
        calendar.time = currentDate
        return calendar[Calendar.DAY_OF_WEEK]
    }

    fun doDayOfWeek(): String? {
        val cal: Calendar = Calendar.getInstance()
        var strWeek: String? = null
        val nWeek: Int = cal.get(Calendar.DAY_OF_WEEK)

        when (nWeek) {
            1 -> strWeek = "일요일"
            2 -> strWeek = "월요일"
            3 -> strWeek = "화요일"
            4 -> strWeek = "수요일"
            5 -> strWeek = "목요일"
            6 -> strWeek = "금요일"
            7 -> strWeek = "토요일"
        }
        return strWeek
    }

    fun showProgressDialog(context: Context): ProgressDialog? {
        val pDialog = ProgressDialog(context)
        pDialog.setMessage("Please wait...")
        pDialog.setCancelable(false)
        pDialog.show()
        return pDialog
    }

    fun hideProgressDialog(pDialog: ProgressDialog) {
        if (pDialog.isShowing) pDialog.dismiss()
    }


    fun px2dp(px: Int, context: Context): Float {
        return px / ((context.resources.displayMetrics.densityDpi.toFloat()) / DisplayMetrics.DENSITY_DEFAULT)
    }


    private val secretKey = "b0b5a4b9a31e5ba2aee85ff1d6c255gg"
    fun encryptCBC(strValue: String): String {
        val keyData = secretKey.toByteArray(charset = Charsets.UTF_8)
        val secureKey: SecretKey = SecretKeySpec(keyData, "AES")
        val cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
        cipher.init(Cipher.ENCRYPT_MODE, secureKey, IvParameterSpec(secretKey.substring(0, 16).toByteArray()))
        val encrypted = cipher.doFinal(strValue.toByteArray(Charsets.UTF_8))
        return String(Base64.encode(encrypted, Base64.NO_WRAP))
    }


    fun decryptCBC(strValue: String): String {
        var decodedByte: ByteArray = Base64.decode(strValue, Base64.NO_WRAP)
        val keySpec = SecretKeySpec(secretKey.toByteArray(), "AES")
        val cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING")
        cipher.init(Cipher.DECRYPT_MODE, keySpec, IvParameterSpec(secretKey.substring(0, 16).toByteArray()))
        val output = cipher.doFinal(decodedByte)

        return String(output)
    }


    companion object {
        @JvmStatic
        val instance by lazy { Utilts() }
    }

}