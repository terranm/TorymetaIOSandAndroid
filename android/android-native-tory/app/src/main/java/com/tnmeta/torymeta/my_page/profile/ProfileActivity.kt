package com.tnmeta.torymeta.my_page.profile

import android.Manifest
import android.content.ContentValues
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.MediaStore
import androidx.activity.result.ActivityResult
import androidx.activity.result.ActivityResultCallback
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import com.bumptech.glide.Glide
import com.bumptech.glide.load.DataSource
import com.bumptech.glide.load.engine.GlideException
import com.bumptech.glide.request.RequestListener
import com.bumptech.glide.request.target.Target
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityProfileBinding
import com.tnmeta.torymeta.model.ButtonData
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.ui.CommonBottomButtonListSheet
import com.tnmeta.torymeta.utils.FileUtil
import com.tnmeta.torymeta.utils.PermissionHelper
import com.tnmeta.torymeta.utils.PermissionHelper.requestPermission
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setImageUrl
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import java.io.File
import java.text.SimpleDateFormat
import java.util.*

/**
 * 프로필 화면
 */
class ProfileActivity: BaseActivity(TransitionModeType.SLIDE_IN_RIGTH) {
    companion object {
        val TAG: String = ProfileActivity::class.java.simpleName
    }

    private enum class SourceType {
        CAMERA, ALBUM, NFT, DEFAULT, CANCEL
    }

    private val viewBinding by viewBinding(ActivityProfileBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.run {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, R.string.profile_title)
            setTopBarBackButtonEnabled(viewBinding.topBar, true) {
                finish()
            }

            repository.member.observe(this@ProfileActivity) {
                profileImg.setImageUrl(it.imgUrl)
            }

            changeBtn.setOnClickListener {
                val buttons = listOf(
                    ButtonData(
                        SourceType.CAMERA,
                        R.drawable.common_corner_medium_white,
                        R.string.profile_change_sheet_btn_camera,
                        R.color.tory_red
                    ),
                    ButtonData(
                        SourceType.ALBUM,
                        R.drawable.common_corner_medium_white,
                        R.string.profile_change_sheet_btn_album,
                        R.color.tory_red
                    ),
                    ButtonData(
                        SourceType.NFT,
                        R.drawable.common_corner_medium_white,
                        R.string.profile_change_sheet_btn_nft,
                        R.color.tory_black
                    ),
                    ButtonData(
                        SourceType.DEFAULT,
                        R.drawable.common_corner_medium_white,
                        R.string.profile_change_sheet_btn_default,
                        R.color.tory_black
                    ),
                    ButtonData(
                        SourceType.CANCEL,
                        R.drawable.common_corner_medium_purple,
                        R.string.profile_change_sheet_btn_cancel,
                        R.color.tory_white
                    ),
                )

                CommonBottomButtonListSheet(this@ProfileActivity, buttons).apply {
                    onClickListener = onClickListener@ {
                        val type = it as SourceType
                        if( type == SourceType.CANCEL ) {
                            return@onClickListener
                        }

                        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            if( !PermissionHelper.isPermissionGranted(this@ProfileActivity, permissionsSDK33) ) {
                                requestPermission()
                                return@onClickListener
                            }
                        }else {
                            if( !PermissionHelper.isPermissionGranted(this@ProfileActivity, permissionsSDK32) ) {
                                requestPermission()
                                return@onClickListener
                            }
                        }

                        when( type ) {
                            SourceType.CAMERA  -> getImageFromCamera()
                            SourceType.ALBUM   -> getImageFromAlbum()
                            SourceType.NFT     -> getImageFromNFT()
                            SourceType.DEFAULT -> getImageFromDefault()
                            else -> {}
                        }
                    }

                }.show()
            }
        }
    }

    /**
     * 프로필 이미지를 업로드합니다
     */
    private fun uploadProfileImage(bitmap: Bitmap) {
        fun createMultipartBody(path: String, name: String): MultipartBody.Part {
            val file = File(path)
            val requestBody = file.asRequestBody("image/jpeg".toMediaTypeOrNull())
            return MultipartBody.Part.createFormData(name, file.name, requestBody)
        }
        val path = FileUtil.saveBitmapToJpeg(this, bitmap)
        val body = createMultipartBody(path, Api.PROFILE_UPLOAD_CONTENT_DISPOSITION_NAME)
        repository.updateProfileImage(body)
    }

    /**
     * 카메라로 이미지를 가져옵니다
     */
    private var cameraImageUri: Uri? = null
    private val cameraLauncher = registerForActivityResult(ActivityResultContracts.TakePicture()) { result ->
        if( !result ) {
            return@registerForActivityResult
        }

        val bitmap = FileUtil.resizeBitmap(this, cameraImageUri!!, Constants.PROFILE_IMAGE_MAX_WIDTH, Constants.PROFILE_IMAGE_MAX_HEIGHT)
        uploadProfileImage(bitmap)
    }

    private fun getImageFromCamera() {
        fun createImageFile(): Uri? {
            val now = SimpleDateFormat("yyMMdd_HHmmss").format(Date())
            val content = ContentValues().apply {
                put(MediaStore.Images.Media.DISPLAY_NAME, "img_$now.jpg")
                put(MediaStore.Images.Media.MIME_TYPE, "image/jpg")
            }
            return contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, content)
        }

        cameraImageUri = createImageFile()
        cameraLauncher.launch(cameraImageUri)
    }

    /**
     * 앨범에서 이미지를 가져옵니다
     */
    private val albumLauncer = registerForActivityResult(ActivityResultContracts.GetContent()) { uri ->
        if( uri == null ) {
            return@registerForActivityResult
        }

        val bitmap = FileUtil.resizeBitmap(this, uri!!, Constants.PROFILE_IMAGE_MAX_WIDTH, Constants.PROFILE_IMAGE_MAX_HEIGHT)
        uploadProfileImage(bitmap)
    }

    private fun getImageFromAlbum() {
        albumLauncer.launch("image/*")
    }

    /**
     * NFT에서 이미지를 가져옵니다
     */
    private val collectionCallback = ActivityResultCallback<ActivityResult> { result ->
        if( result.resultCode != RESULT_OK || result.data == null ) {
            return@ActivityResultCallback
        }

        val url = result.data!!.getStringExtra(NFTCollectionActivity.PARAM_URL)!!
        // profileImg.setImageUrl(url)

        // 1. 이미지 로딩
        Glide.with(this)
            .asBitmap()
            .addListener(object: RequestListener<Bitmap> {
                override fun onResourceReady(resource: Bitmap?, model: Any?, target: Target<Bitmap>?, dataSource: DataSource?, isFirstResource: Boolean): Boolean {
                    if( resource == null ) {
                        return true
                    }

                    // 2. 이미지를 파일로 저장
                    val path = FileUtil.saveBitmapToJpeg(this@ProfileActivity, resource!!)
                    val bitmap = FileUtil.resizeBitmap(this@ProfileActivity, Uri.fromFile(File(path)),Constants.PROFILE_IMAGE_MAX_WIDTH, Constants.PROFILE_IMAGE_MAX_HEIGHT)

                    CoroutineScope(Dispatchers.Main).launch {
                        uploadProfileImage(bitmap)
                    }

                    return true
                }

                override fun onLoadFailed(e: GlideException?, model: Any?, target: Target<Bitmap>?, isFirstResource: Boolean): Boolean {
                    return false
                }
            })
            .load(url)
            .submit()
    }

    private val nftCollectionLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult(), collectionCallback)
    private fun getImageFromNFT() {
        val intent = Intent(this, NFTCollectionActivity::class.java).apply {
            putExtra(ImageCollectionActivity.PARAM_TITLE, getString(R.string.profile_change_sheet_btn_nft))
        }
        nftCollectionLauncher.launch(intent)
    }

    /**
     * 기본 프로필에서 이미지를 가져옵니다
     */
    private val defaultCollectionLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult(), collectionCallback)
    private fun getImageFromDefault() {
        val intent = Intent(this, DefaultCollectionActivity::class.java).apply {
            putExtra(ImageCollectionActivity.PARAM_TITLE, getString(R.string.profile_change_sheet_btn_default))
        }
        defaultCollectionLauncher.launch(intent)
    }

    /**
     *  카메라, 앨범 권한을 요청합니다
     */
    private val permissionsSDK32 = arrayOf(
        Manifest.permission.CAMERA,
        Manifest.permission.WRITE_EXTERNAL_STORAGE,
        Manifest.permission.READ_EXTERNAL_STORAGE,
    )

    private val permissionsSDK33 = arrayOf(
        Manifest.permission.CAMERA,
        Manifest.permission.READ_MEDIA_IMAGES
    )


    private val permissionLauncher: ActivityResultLauncher<Array<String>> =
        registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                if (PermissionHelper.isPermissionGranted(this, permissionsSDK33)) {
                }
            }else {
                // 권한 허용
                if (PermissionHelper.isPermissionGranted(this, permissionsSDK32)) {
                }
            }
        }


    private fun requestPermission() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (PermissionHelper.isPermissionGranted(this, permissionsSDK33)) {
                return
            }
        }else {
            if (PermissionHelper.isPermissionGranted(this, permissionsSDK32)) {
                return
            }
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if( PermissionHelper.shouldShowRequestPermissionRationale(this, permissionsSDK33) ) {
                CommonAlertDialog.Builder(this)
                    .setCancelable(false)
                    .setMessage(R.string.system_alert_permission_denied)
                    .setPositiveButton {  }
                    .show()
            }
            // 권한 요청
            else {
                permissionLauncher.launch(permissionsSDK33)
            }
        }else {
            if( PermissionHelper.shouldShowRequestPermissionRationale(this, permissionsSDK32) ) {
                CommonAlertDialog.Builder(this)
                    .setCancelable(false)
                    .setMessage(R.string.system_alert_permission_denied)
                    .setPositiveButton {  }
                    .show()
            }
            // 권한 요청
            else {
                permissionLauncher.launch(permissionsSDK32)
            }
        }
    }

}