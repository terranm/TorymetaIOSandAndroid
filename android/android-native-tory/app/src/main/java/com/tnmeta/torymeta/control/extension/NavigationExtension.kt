package com.tnmeta.torymeta.control.extension

import android.os.Bundle
import androidx.annotation.IdRes
import androidx.fragment.app.Fragment
import androidx.navigation.NavController
import androidx.navigation.NavOptions
import androidx.navigation.Navigator
import androidx.navigation.fragment.findNavController
import com.tnmeta.torymeta.control.FragmentResultActivity


fun <T> Fragment.getNavigationResult(key: String = "result") =
    findNavController().currentBackStackEntry?.savedStateHandle?.get<T>(key)

fun <T> Fragment.getNavigationResultLiveData(key: String = "result") =
    findNavController().currentBackStackEntry?.savedStateHandle?.getLiveData<T>(key)

fun <T> Fragment.setNavigationResult(result: T, key: String = "result") {
    findNavController().previousBackStackEntry?.savedStateHandle?.set(key, result)
}


fun Fragment.navigateUp(requestCode: Int, bundle: Bundle) {
    (activity as? FragmentResultActivity)?.setBundle(requestCode, bundle)
        ?: throw IllegalStateException("You need to extend your activity from FragmentResultActivity")
    findNavController().navigateUp()
}