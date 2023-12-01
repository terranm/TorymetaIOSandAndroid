package com.tnmeta.torymeta.chattinglounge

import android.os.Bundle
import android.view.View
import androidx.lifecycle.ViewModelProvider
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.chattinglounge.viewmodel.ChattingReportViewModel
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityChattingLoungeReportBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.chatting.report.Report
import com.tnmeta.torymeta.ui.CommonAlertDialog
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber


/**
 * ChattingLoungeReportActivity
 */
class ChattingLoungeReportActivity : BaseActivity(), View.OnClickListener {

    companion object {
        val TAG: String = ChattingLoungeReportActivity::class.java.simpleName
        const val ReportRoomIDParam  = "ReportRoomIDParam"
        const val ReportMemberIDParam = "ReportMemberIDParam"
    }

    private val viewBinding by viewBinding(ActivityChattingLoungeReportBinding::inflate)

    private var checkReportArray : Array<Boolean> = Array(4) { false }
    private lateinit var viewModel: ChattingReportViewModel

    private var reportID : String = ""
    private var reportIndex = -1

    /**
     * onCreate
     * @param savedInstanceState
     */
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {
                setContentView(root)

                if(intent.hasExtra(ReportRoomIDParam)) {
                    reportID = intent.getStringExtra(ReportRoomIDParam)!!
                    reportIndex = 0
                    reportMessage.text = String.format("현재 채팅방을 신고하시겠습니까?\n자동으로 관리자에게 전송됩니다.")

                }else if(intent.hasExtra(ReportMemberIDParam)){
                    reportID = intent.getStringExtra(ReportMemberIDParam)!!
                    reportIndex = 1
                    reportMessage.text = String.format("%s 님을\n아래 사항에 위배되어 신고합니다.", reportID)
                }

                viewModel = ViewModelProvider(this@ChattingLoungeReportActivity)[ChattingReportViewModel::class.java]

                reportLayout.apply {
                    isEnabled = false
                    setOnClickListener(this@ChattingLoungeReportActivity)
                }

                arrayOf(checkReport1, checkReport2, checkReport3, checkReport4).forEach {
                    it.setOnClickListener(this@ChattingLoungeReportActivity)
                }
            }

        }catch (e : Exception){
            Timber.tag(TAG).d("onCrate " + e.message)
        }
    }

    override fun onResume() {
        super.onResume()
        setFullScreen()
    }


    override fun onBackPressed() {
        //super.onBackPressed()
    }


    /**
     * onClick
     * @param view
     */
    override fun onClick(view: View) {
        viewBinding.apply {
            when(view.id) {
                R.id.close -> finish()
                R.id.check_report1 ->  {
                    checkReportArray[0] = checkReport1.isChecked
                    isCheck()
                }

                R.id.check_report2 -> {
                    checkReportArray[1] = checkReport2.isChecked
                    isCheck()
                }

                R.id.check_report3-> {
                    checkReportArray[2] = checkReport3.isChecked
                    isCheck()
                }


                R.id.check_report4 -> {
                    checkReportArray[3] = checkReport4.isChecked
                    isCheck()
                }

                R.id.report_layout -> {
                    when(reportIndex) {
                        0 -> reportChattingRoom(roomID = reportID)
                        1 -> reportChattingPerson(memberID = reportID)
                    }
                }
            }
        }
    }

    /**
     * isCheck
     */
    private fun isCheck() = try {
        viewBinding.apply {
            val checkCount = checkReportArray.count {
                it
            }
            reportLayout.isEnabled = checkCount > 0
        }
    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


    private fun reportChattingRoom(roomID : String) {
        try {
            if(roomID.isEmpty())
                return

            val arrayList = ArrayList<Int>()
            checkReportArray.forEachIndexed{ index, isValue ->
                if(isValue) arrayList.add(index)
            }

            val reportValue = Report(
                memberId = 0,
                chatRoomId = roomID.toInt(),
                reportMainType = 1,
                reportSubType = arrayList.toList()
            )

            val params = BaseParam(reportValue).parameter

            viewModel.apply {

                reportChattingRoom(params).subscribeBy(onNext = {
                    if(it.result!!.isSucceed) {
                        val message = String.format("%s방에 대한\n신고가 접수되었습니다.", roomID)
                        CommonAlertDialog.Builder(this@ChattingLoungeReportActivity)
                            .setMessage(message)
                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                            .show()
                    }else {
                        CommonAlertDialog.Builder(this@ChattingLoungeReportActivity)
                            .setMessage(it.resultMessage.toString())
                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                            .show()
                    }
                }, onError = {})
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    private fun reportChattingPerson(memberID : String) {
        try {
            if(memberID.isEmpty())
                return

            val arrayList = ArrayList<Int>()
            checkReportArray.forEachIndexed{ index, isValue ->
                if(isValue) arrayList.add(index)
            }

            val reportValue = Report(
                memberId = memberID.toInt(),
                chatRoomId = 0,
                reportMainType = 0,
                reportSubType = arrayList.toList()
            )

            val params = BaseParam(reportValue).parameter

            viewModel.apply {

                reportChattingRoom(params).subscribeBy(onNext = {
                    if(it.result!!.isSucceed) {
                        val message = String.format("%s에 대한\n신고가 접수되었습니다.",  memberID)
                        CommonAlertDialog.Builder(this@ChattingLoungeReportActivity)
                            .setMessage(message)
                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                            .show()
                    }else {
                        CommonAlertDialog.Builder(this@ChattingLoungeReportActivity)
                            .setMessage(it.resultMessage.toString())
                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                            .show()
                    }
                }, onError = {})
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


}