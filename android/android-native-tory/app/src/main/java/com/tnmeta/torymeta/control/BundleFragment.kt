package com.tnmeta.torymeta.control

import android.os.Bundle
import androidx.annotation.IdRes
import androidx.fragment.app.Fragment
import androidx.navigation.NavDirections
import androidx.navigation.NavOptions
import androidx.navigation.Navigator
import androidx.navigation.fragment.findNavController
import com.tnmeta.torymeta.common.Constants

abstract class BundleFragment : Fragment() {

    var pendingRequest: Int = -1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        pendingRequest = savedInstanceState?.getInt(PENDING_REQUEST, -1) ?: -1
    }

    open fun onFragmentResult(requestCode: Int, bundle: Bundle) {}

    fun navigate(navDirection: NavDirections, requestCode: Int = -1) {
        navigate(navDirection.actionId, navDirection.arguments, requestCode)
    }

    fun navigate(
        navDirection: NavDirections,
        navOptions: NavOptions?,
        requestCode: Int = -1
    ) {
        navigate(navDirection.actionId, navDirection.arguments, navOptions, null, requestCode)
    }

    fun navigate(
        navDirection: NavDirections,
        navigatorExtras: Navigator.Extras?,
        requestCode: Int = -1
    ) {
        navigate(navDirection.actionId, navDirection.arguments, null, navigatorExtras, requestCode)
    }

    fun navigate(@IdRes navDirection: Int, requestCode: Int) {
        navigate(navDirection, null, requestCode)
    }

    fun navigate(@IdRes navDirection: Int, bundle: Bundle?, requestCode: Int) {
        navigate(navDirection, bundle, null, requestCode)
    }

    fun navigate(
        @IdRes navDirection: Int,
        bundle: Bundle?,
        navOptions: NavOptions?,
        requestCode: Int
    ) {
        navigate(navDirection, bundle, navOptions, null, requestCode)
    }

    fun navigate(
        @IdRes navDirection: Int,
        bundle: Bundle?,
        navOptions: NavOptions?,
        navigatorExtras: Navigator.Extras?,
        requestCode: Int
    ) {
        val theActualBundle = bundle ?: Bundle()
        extractPendingRequest(theActualBundle, requestCode)
        findNavController().navigate(navDirection, theActualBundle, navOptions, navigatorExtras)
    }

    private fun extractPendingRequest(bundle: Bundle, requestCode: Int) {
        pendingRequest = if (requestCode > -1) {
            bundle.putInt(Constants.FRAGMENT_REQUEST_CODE, requestCode)
            requestCode
        } else {
            bundle.getInt(Constants.FRAGMENT_REQUEST_CODE, -1)
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putInt(PENDING_REQUEST, pendingRequest)
    }

    companion object {
        private const val PENDING_REQUEST = "pending_request"
    }

}