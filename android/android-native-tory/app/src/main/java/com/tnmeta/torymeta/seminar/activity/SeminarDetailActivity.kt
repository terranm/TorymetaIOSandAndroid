package com.tnmeta.torymeta.seminar.activity

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivitySeminarDetailBinding
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.seminar.dialog.SeminarAlertDialog
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber

class SeminarDetailActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH), View.OnClickListener {

    companion object {
        fun createIntent(context: Context): Intent {
            return Intent(context, SeminarDetailActivity::class.java)
        }
    }

    private val viewBinding by viewBinding(ActivitySeminarDetailBinding::inflate)
    private var dataInfo : SeminarDto? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

            if(intent.hasExtra(Params.SEMINAR_DETAIL_INFO)) {
                dataInfo  = intent.getParcelableExtra(Params.SEMINAR_DETAIL_INFO)!!

                CoroutineScope(Dispatchers.Main).launch {
                    getSeminarDetailInfo(dataInfo!!)
                }
            }

            cancel.setOnClickListener(this@SeminarDetailActivity)
            apply.setOnClickListener(this@SeminarDetailActivity)
            apply.isEnabled = false
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.cancel -> {
                SeminarAlertDialog.Builder(this)
                    .setCancelable(false)
                    .setTitle(R.string.seminar_cancel_message)
                    .setMessage(R.string.seminar_cancel_detail_message)
                    .setPositiveButton(R.string.seminar_apply_cancel) {
                        finish()
                    }
                    .setNegativeButton(R.string.seminar_cancel_yes) {}
                    .show()
            }

            R.id.apply -> {
                try {
                    repository.setParticipate(dataInfo!!.id)
                        .subscribeBy(onNext = {
                            /*
                            if(it.isSucceed) {
                                //finish()
                            }

                             */
                        }, onError = {})

                }catch (e : Exception){
                    Timber.d(e.message)
                }
            }
        }
    }

    private fun getSeminarDetailInfo(dataInfo : SeminarDto) = try {
        repository.getSeminarDetail(dataInfo.id).apply {
            subscribeBy(onNext = {
                viewBinding.apply {
                    if(it != null) {
                        seminarTitle.text = it.title
                        seminarDesc.text = it.description
                        seminarTeacher.text = it.teacherName

                        val start = DateFormatter.instance.dateBarTimeFormatter().parse(it.startAt)
                        val end = DateFormatter.instance.dateBarTimeFormatter().parse(it.endAt)

                        seminarDay.text = String.format(
                            "%s - %s", DateFormatter.instance.dateDayFormatter().format(start),
                            DateFormatter.instance.dateDayFormatter().format(end)
                        )

                        seminarPersonnel.text = String.format("%d / %d", it.participationCount, it.maxEnterCount)

                        apply.isEnabled = it.status != "END"
                    }
                }

            }, onError = {}, onComplete = {})
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

}