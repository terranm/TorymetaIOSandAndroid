package com.tnmeta.torymeta.my_page

import android.os.Bundle
import android.view.View
import android.widget.Toast
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityNotificationSettingBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.param.AgreeParam
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber

/**
 * 로그인/알림 설정 화면
 */
class NotificationSettingActivity: BaseActivity(TransitionModeType.SLIDE_IN_RIGTH), View.OnClickListener {
    companion object {
        val TAG : String         = NotificationSettingActivity::class.java.simpleName
    }

    enum class AgreeType(val origin: Int) {
        PUSH(1),
        EMAIL_SMS (2)
    }

    enum class AgreeOnOff(val origin: Int) {
        OFF(0),
        ON(1)
    }

    private val viewBinding by viewBinding(ActivityNotificationSettingBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.apply {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, R.string.notification_setting_title)
            setTopBarBackButtonEnabled(viewBinding.topBar, true) {
                finish()
            }


            autoLoginSwitch.isChecked = repository.isAutoLogin()

            autoLoginSwitch.setOnClickListener(this@NotificationSettingActivity)
            pushSwitch.setOnClickListener(this@NotificationSettingActivity)
            emailSwitch.setOnClickListener(this@NotificationSettingActivity)

            repository.getAlaramAgree().subscribeBy(onNext = { data ->

                if(!data.agreementList.isNullOrEmpty()) {
                    data.agreementList.forEach {
                        when(it.agreementCd) {
                            AgreeType.PUSH.origin -> pushSwitch.isChecked = it.agreementStatus == AgreeOnOff.ON.origin
                            AgreeType.EMAIL_SMS.origin -> emailSwitch.isChecked = it.agreementStatus == AgreeOnOff.ON.origin
                        }
                    }
                }
            }, onError = {})

        }
    }

    override fun onClick(view: View) {
        viewBinding.apply {
            when (view.id) {
                R.id.autoLoginSwitch -> {
                    val messageID = if (autoLoginSwitch.isChecked) {
                        repository.setAutoLogin(true)
                        R.string.auto_login_on
                    } else {
                        repository.setAutoLogin(false)
                        R.string.auto_login_off
                    }

                    Toast.makeText(this@NotificationSettingActivity, messageID, Toast.LENGTH_SHORT).show()
                }

                R.id.pushSwitch -> {
                    val agreeValue = if (pushSwitch.isChecked) AgreeOnOff.ON.origin else AgreeOnOff.OFF.origin
                    updateAgree(AgreeType.PUSH.origin, agreeValue)
                }

                R.id.emailSwitch -> {
                    val agreeValue = if (emailSwitch.isChecked) AgreeOnOff.ON.origin else AgreeOnOff.OFF.origin
                    updateAgree(AgreeType.EMAIL_SMS.origin, agreeValue)
                }
            }
        }
    }

    private fun updateAgree(index : Int, agreeValue : Int)  = try {

        val param = BaseParam(AgreeParam(index, agreeValue)).parameter
        repository.setAlarmAgree(param).subscribeBy(onNext = { data ->

            if(data.isSucceed && data.processYn == "Y") {
                when(index) {
                    AgreeType.PUSH.origin -> {
                        val messageID = if(agreeValue == AgreeOnOff.ON.origin) {
                            R.string.push_receive_on
                        }else {
                            R.string.push_receive_off
                        }

                        Toast.makeText(this, messageID, Toast.LENGTH_SHORT).show()
                    }
                    AgreeType.EMAIL_SMS.origin -> {
                        val messageID = if(agreeValue == AgreeOnOff.ON.origin) {
                            R.string.email_receive_on
                        }else {
                            R.string.email_receive_off
                        }

                        Toast.makeText(this, messageID, Toast.LENGTH_SHORT).show()
                    }
                }
            }

        }, onError = {})

    }catch (e : Exception){
        Timber.d(e.message)
    }


}