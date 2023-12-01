package com.tnmeta.torymeta.web

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityToryWebViewBinding
import com.tnmeta.torymeta.databinding.ActivityWebBinding
import com.tnmeta.torymeta.dialog.CommonDialogInterface
import com.tnmeta.torymeta.dialog.NetworkErrorDialogFragment
import com.tnmeta.torymeta.utils.Utilts

class ToryWebViewActivity : BaseActivity() {

    companion object {
        const val PARAM_URL      = "url"
        const val BACK_KEY       = "back_key"

        fun createIntent(context: Context, url: String): Intent {
            return Intent(context, ToryWebViewActivity::class.java).apply {
                putExtra(PARAM_URL, url)
                //putExtra(BACK_KEY, )
            }
        }
    }

    private val viewBinding by viewBinding(ActivityToryWebViewBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

            if(Utilts.instance.netWorkCheck(this@ToryWebViewActivity)) {

                if(intent.hasExtra(ToryWebActivity.PARAM_URL)) {
                    val url = intent.getStringExtra(ToryWebActivity.PARAM_URL)
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
                                    ToryApplication.activity?.finish()
                                }
                                R.id.refresh -> {
                                    val url = intent.getStringExtra(ToryWebActivity.PARAM_URL)
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

    }
}