package com.tnmeta.torymeta.push

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import com.tnmeta.torymeta.MainBaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityPushInfoBinding
import com.tnmeta.torymeta.intro.SplashActivity
import com.tnmeta.torymeta.model.push.PushMessageInfo
import com.tnmeta.torymeta.ui.CommonAlertDialog
import timber.log.Timber


class PushInfoActivity : BaseActivity() {
    companion object {
        private const val TAG = "PushInfoActivity"
    }

    private val viewBinding by viewBinding(ActivityPushInfoBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.apply {
            setContentView(root)
            processExtrasData()

            val pushInfo = if(processExtrasData()) {
                val bundle = intent.extras
                val title = bundle!!.getString("title")!!
                val content = bundle!!.getString("content")!!
                val actionUrl = bundle!!.getString("action_url")!!

                PushMessageInfo(title, content, actionUrl)

            }else {
                if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(Params.PUSH_DATA_PARAM, PushMessageInfo::class.java)
                } else {
                    intent.getParcelableExtra(Params.PUSH_DATA_PARAM) as? PushMessageInfo
                }
            }


            Timber.tag(TAG).d("onCreate $pushInfo" )

            if(toryApplication.isinitUnity) {
                Intent(this@PushInfoActivity, MainBaseActivity::class.java).run {
                    putExtra(Params.PUSH_DATA_PARAM, pushInfo)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_NEW_TASK)
                    startActivity(this)
                }
            }else {
                Timber.d("onCreate - 2")
                Intent(this@PushInfoActivity, SplashActivity::class.java).run {
                    putExtra(Params.PUSH_DATA_PARAM, pushInfo)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_NEW_TASK)
                    startActivity(this)
                }
            }

            finish()

        }

    }

    override fun onResume() {
        super.onResume()


    }


    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)

        Timber.d("push onNewIntent 1")

        if(intent.hasExtra(Params.PUSH_DATA_PARAM)) {
            val pushInfo = if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                intent.getParcelableExtra(Params.PUSH_DATA_PARAM, PushMessageInfo::class.java)
            } else {
                intent.getParcelableExtra(Params.PUSH_DATA_PARAM) as? PushMessageInfo
            }

            Intent(this@PushInfoActivity, MainBaseActivity::class.java).run {
                putExtra(Params.PUSH_DATA_PARAM, pushInfo)
                addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(this)
            }
            finish()
        }
    }

    private fun processExtrasData() : Boolean{
        val bundle = intent.extras

        if(bundle != null) {
            val data = bundle.getString("action_url")
            if(data != null) {
                return true
            }
        }
        return false
    }

}