package com.tnmeta.torymeta.seminar

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityCreateSeminarBinding
import com.tnmeta.torymeta.databinding.ActivitySeminarRoomViewBinding
import com.tnmeta.torymeta.model.TransitionModeType

class SeminarRoomViewActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH), View.OnClickListener {

    companion object {
        fun createIntent(context: Context): Intent {
            return Intent(context, SeminarRoomViewActivity::class.java)
        }
    }

    private val viewBinding by viewBinding(ActivitySeminarRoomViewBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)
        }
    }

    override fun onClick(view: View) {

    }
}