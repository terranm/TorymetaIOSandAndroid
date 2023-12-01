package com.tnmeta.torymeta.intro


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.fragment.findNavController
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.control.extension.navigateUp
import com.tnmeta.torymeta.control.extension.setNavigationResult
import com.tnmeta.torymeta.databinding.ActivityPermissionInfoBinding

class PermissionInfoFragment : BaseFragment() {

    private lateinit var viewBinding: ActivityPermissionInfoBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewBinding = ActivityPermissionInfoBinding.inflate(inflater, container, false)
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {
            btnOK.setOnClickListener {

                repository.setPermissionInfo(true)
                findNavController().navigateUp()
            }
        }
    }

}