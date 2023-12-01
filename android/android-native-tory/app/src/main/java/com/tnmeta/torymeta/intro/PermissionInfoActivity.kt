package com.tnmeta.torymeta.intro

import android.app.Activity
import android.os.Bundle
import android.view.View
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityPermissionInfoBinding
import com.tnmeta.torymeta.model.TransitionModeType


class PermissionInfoActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH) {

    private val viewBinding by viewBinding(ActivityPermissionInfoBinding::inflate)


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

        }
    }

    fun onClick(view: View) {
        setResult(Activity.RESULT_OK)
        finish()
    }
}