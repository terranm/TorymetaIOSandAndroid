package com.tnmeta.torymeta.utils

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

object PermissionHelper {
    private const val TAG = "PermissionHelper"

    /**
     * 권한을 요청합니다
     */
    fun requestPermission(context: Activity, permissions: Array<String>, requestCode: Int) {

        val deniedPermissions = getDeniedPermission(context, permissions)
        if( deniedPermissions.isNotEmpty() ) {
            ActivityCompat.requestPermissions(context, deniedPermissions, requestCode)
        }
    }

    fun requestPermission(context: Activity, permission: String, requestCode: Int) {

        if( !isPermissionGranted(context, permission) ) {
            ActivityCompat.requestPermissions(context, arrayOf(permission), requestCode)
        }
    }

    /**
     * 허용된 권한인지 확인합니다
     */
    fun isPermissionGranted(context: Context, permissions: Array<String>): Boolean {
        for( permission in permissions ) {
            if( !isPermissionGranted(context, permission) ) {
                return false
            }
        }

        return true
    }

    fun isPermissionGranted(context: Context, permission: String): Boolean {
        return ContextCompat.checkSelfPermission(context, permission) == PackageManager.PERMISSION_GRANTED
    }

    /**
     * 거부된 권한을 반환합니다
     */
    private fun getDeniedPermission(context: Context, permissions: Array<String>): Array<String> {
        return permissions.filter {
            !isPermissionGranted(context, it)
        }.toTypedArray()
    }

    /**
     * 명시적으로 권한을 거부했는지 확인합니다
     */
    fun shouldShowRequestPermissionRationale(context: Activity, permissions: Array<String>): Boolean {
        for( permission in permissions ) {
            if( shouldShowRequestPermissionRationale(context, permission) ) {
                return true
            }
        }

        return false
    }

    private fun shouldShowRequestPermissionRationale(context: Activity, permission: String): Boolean {
        return ActivityCompat.shouldShowRequestPermissionRationale(context, permission)
    }
}