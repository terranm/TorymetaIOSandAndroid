package com.tnmeta.torymeta.intro

import android.content.Intent
import android.os.Bundle
import androidx.activity.OnBackPressedCallback
import androidx.lifecycle.MutableLiveData
import com.google.firebase.analytics.FirebaseAnalytics
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.ApiMode
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityUniversitySelectBinding
import com.tnmeta.torymeta.model.event.EventType
import com.tnmeta.torymeta.model.event.EventTypeBus
import com.tnmeta.torymeta.model.dto.UniversityDTO
import com.tnmeta.torymeta.web.ToryWebActivity
import com.tnmeta.torymeta.web.Web
import io.reactivex.rxjava3.kotlin.subscribeBy
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode
import timber.log.Timber

/**
 * 학교 선택 화면
 */
class UniversitySelectActivity: BaseActivity() {
    companion object {
        val TAG : String = UniversitySelectActivity::class.java.simpleName
    }

    private val selectedUniv = MutableLiveData<UniversityDTO>()
    private val viewBinding by viewBinding(ActivityUniversitySelectBinding::inflate)

    private lateinit var mSelectUnivertyInfo : UniversityDTO

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {

                setContentView(root)
                setTopBarTitle(viewBinding.topBar, R.string.university_select_title)

                if (repository.member.value!!.certUniYn == 0) {
                    setTopBarBackButtonEnabled(viewBinding.topBar, false)
                } else {
                    setTopBarBackButtonEnabled(viewBinding.topBar, true) {
                        finish()
                    }

                    mSelectUnivertyInfo = repository.getMyCampus()
                    univName.text = mSelectUnivertyInfo.universityName

                    selectedUniv.value = mSelectUnivertyInfo
                    completeBtn.setBackgroundResource(R.drawable.common_corner_circle_purple)
                }


                // 드랍다운 클릭
                dropdownBtn.setOnClickListener {
                    /*
                    val sheet = UniversitySelectSheet(this@UniversitySelectActivity, repository.universityList)
                    sheet.show()

                    // 대학교 변경
                    sheet.onClickListener = { data ->
                        selectedUniv.value = data
                    }
                     */

                    if(!repository.universityList.isNullOrEmpty()) {
                        UniversitySelectSheet(this@UniversitySelectActivity, repository.universityList).apply {
                            onClickListener = { data ->
                                selectedUniv.value = data
                            }
                        }.show()
                    }
                }

                // 완료 버튼 클릭
                completeBtn.setOnClickListener {
                    if (selectedUniv.value == null) {
                        return@setOnClickListener
                    }

                    val isModify = repository.member.value!!.certUniYn == 1

                    if (repository.member.value!!.certUniYn == 0) {

                        repository.updateCampus(selectedUniv.value!!.universityCode, ApiMode.UIMode.ALERT_RESTART)
                            .subscribeBy(onNext = {

                                Intent(this@UniversitySelectActivity, ToryWebActivity::class.java).run {
                                    putExtra(ToryWebActivity.PARAM_URL, Web.Url.getUniversityAuth(mSelectUnivertyInfo, isModify))
                                    startActivity(this)
                                }

                            }, onError = {})

                    } else {
                        Intent(this@UniversitySelectActivity, ToryWebActivity::class.java).run {
                            putExtra(ToryWebActivity.PARAM_URL, Web.Url.getUniversityAuth(mSelectUnivertyInfo, isModify))
                            startActivity(this)
                        }
                    }

                }

                // 대학교 업데이트 구독
                selectedUniv.observe(this@UniversitySelectActivity) { data ->
                    mSelectUnivertyInfo = data
                    univName.text = data.universityName
                    completeBtn.setBackgroundResource(R.drawable.common_corner_circle_purple)
                }

                if (repository.member.value!!.certUniYn == 1) {
                    completeText.text = resources.getString(R.string.next)
                }

                if(!EventBus.getDefault().isRegistered(this@UniversitySelectActivity))
                    EventBus.getDefault().register(this@UniversitySelectActivity)

                if (Constants.is_FirebaseAnalytics) {
                    val analytics = FirebaseAnalytics.getInstance(this@UniversitySelectActivity)
                    val bundle = Bundle().apply {
                        putString(FirebaseParam.type, FirebaseParam.type_value)
                    }

                    analytics.logEvent(FirebaseParam.mobile_universitySelect, bundle)
                }

                close.setOnClickListener {
                    finish()
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        try {
            if (EventBus.getDefault().isRegistered(this))
                EventBus.getDefault().unregister(this)
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


    override fun onBackPressed() {
        try {
            if (repository.member.value!!.certUniYn == 1) {
                //super.onBackPressed()
                onBackPressedDispatcher.onBackPressed()
            }
        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }


    @Subscribe(threadMode = ThreadMode.MAIN)
    fun eventUpdate(eventBus: EventTypeBus) {
        try {
            when(eventBus.type) {
                EventType.CLOSE -> finish()
                EventType.COMFIRE_CERTUNITYN -> {
                    setResult(RESULT_OK)
                    finish()
                }
                else -> {}
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }
}