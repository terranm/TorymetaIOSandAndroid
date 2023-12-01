package com.tnmeta.torymeta.videoplayer

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.lifecycle.ViewModelProvider
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityLectureLoginBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.videoplayer.model.param.LectureLoginParam
import com.tnmeta.torymeta.videoplayer.viewmodel.LectureLoginViewModel
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber


/**
 * LectureLoginActivity
 */
class LectureLoginActivity : BaseActivity(), View.OnClickListener {

    companion object {
        val TAG: String = LectureLoginActivity::class.java.simpleName
        fun createIntent(context: Context): Intent {
            return Intent(context, LectureLoginActivity::class.java)
        }
    }

    private val viewBinding by viewBinding(ActivityLectureLoginBinding::inflate)
    private lateinit var viewModel: LectureLoginViewModel


    /**
     *  onCreate
     * @param savedInstanceState
     */
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {
                setContentView(root)
                viewModel = ViewModelProvider(this@LectureLoginActivity)[LectureLoginViewModel::class.java]

                /*
                repository.apply {
                    if(!universityList.isNullOrEmpty()) {

                        val university = universityList.first {
                            it.universityCode == member.value!!.universityCode
                        }

                        if(university != null) {
                            Glide.with(this@LectureLoginActivity)
                                .load(university.imgUrl)
                                .into(imgUnivertyLogo)

                            txtSchool.text = university.universityName
                            txtLectureInfo.text = university.logoName
                        }
                    }
                }
                */

                editId.run {
                    addTextChangedListener(object : TextWatcher {
                        override fun beforeTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {}
                        override fun onTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {
                            if (editId.text.toString().isNotEmpty()) {
                                isEnableCheck()
                            }
                        }

                        override fun afterTextChanged(editable: Editable?) {}
                    })
                }

                editPassword.run {
                    addTextChangedListener(object : TextWatcher {
                        override fun beforeTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {}
                        override fun onTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {
                            if (editPassword.text.toString().isNotEmpty()) {
                                isEnableCheck()
                            }
                        }

                        override fun afterTextChanged(editable: Editable?) {}
                    })
                }

                login.isEnabled = false
                login.setOnClickListener(this@LectureLoginActivity)
            }

        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }


    /**
     * onClick
     * @param view
     */
    override fun onClick(view: View) {
        when(view.id){
            R.id.ivBack -> finish()
            R.id.login -> {
                viewBinding.apply {
                    val param = BaseParam(LectureLoginParam(mbId = editId.text.toString().trim(),
                                                            passwd = editPassword.text.toString().trim())).parameter
                    viewModel.apply {
                        ttcLogin(param).subscribeBy(onNext = {
                            try {
                                if (it.result!!.isSucceed) {
                                    repository.ttcStatus = "LOGIN"
                                    MyLectureRoomActivity.createIntent(this@LectureLoginActivity).apply {
                                        startActivity(this)
                                        finish()
                                    }
                                } else {
                                    CommonAlertDialog.Builder(this@LectureLoginActivity)
                                        .setMessage(it.resultMessage.toString())
                                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                                        .show()
                                }
                            }catch (e : Exception){
                                Timber.tag(TAG).d(e.message)
                            }
                        })
                    }
                }
            }
        }
    }

    /**
     * isEnableCheck
     */
    private fun isEnableCheck() = viewBinding.apply {
        if(!Constants.IS_PRODUCTION_SERVER) {
            login.isEnabled = editId.text.toString().isNotEmpty() &&
                    editPassword.text.toString().isNotEmpty()
        }else {
            login.isEnabled = editId.text.toString().isNotEmpty() &&
                    editPassword.text.toString().isNotEmpty()
                    //editPassword.text.toString().length >= 8
        }
    }


}