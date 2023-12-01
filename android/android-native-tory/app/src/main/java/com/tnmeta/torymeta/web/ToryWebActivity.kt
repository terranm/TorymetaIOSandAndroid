package com.tnmeta.torymeta.web

import android.content.Context
import android.content.Intent
import android.os.Bundle
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.ToryApplication.Companion.activity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityWebBinding
import com.tnmeta.torymeta.databinding.NetworkErrorFragmentDialogBinding
import com.tnmeta.torymeta.dialog.CommonDialogInterface
import com.tnmeta.torymeta.dialog.NetworkErrorDialogFragment
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.utils.Utilts
import timber.log.Timber

/**
 * 공통 웹뷰 Activity
 */
class ToryWebActivity: BaseActivity(TransitionModeType.SLIDE_IN_LEFT) {
    companion object {
        const val PARAM_URL      = "url"
        const val BACK_KEY       = "back_key"

        fun createIntent(context: Context, url: String): Intent {
            return Intent(context, ToryWebActivity::class.java).apply {
                putExtra(PARAM_URL, url)
                //putExtra(BACK_KEY, true)
            }
        }
    }

    private val viewBinding by viewBinding(ActivityWebBinding::inflate)

    private var isBack : Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.run {
            setContentView(root)

            if(Utilts.instance.netWorkCheck(this@ToryWebActivity)) {
                if(intent.hasExtra(PARAM_URL)) {
                    val url = intent.getStringExtra(PARAM_URL)
                    Timber.d("url $url")

                    //val isBack = intent.getBooleanExtra(BACK_KEY, true)
                    url?.let {
                        supportFragmentManager.beginTransaction()
                            .replace(R.id.fragment_layout, ToryWebFragment.newInstance(url, true))
                            .commit()
                    }
                }

            }else {

                NetworkErrorDialogFragment.NetworkErrorDialogBuilder(supportFragmentManager).apply {
                    setClickListener(object : CommonDialogInterface.OnClickListener {
                        override fun onClick(i: Int) {
                            when(i) {
                                R.id.backBtn -> {
                                    activity?.finish()
                                }
                                R.id.refresh -> {
                                    val url = intent.getStringExtra(PARAM_URL)
                                    url?.let {
                                        supportFragmentManager.beginTransaction()
                                            .replace(R.id.fragment_layout, ToryWebFragment.newInstance(url, true))
                                            .commit()
                                    }
                                }
                            }
                        }
                    })
                }.show()
            }
        }
    }

    override fun onBackPressed() {
        super.onBackPressed()

        /*
        if( webView.canGoBack() ) {
            webView.goBack()
        }
        else {
            super.onBackPressed()
        }
        */
    }
}