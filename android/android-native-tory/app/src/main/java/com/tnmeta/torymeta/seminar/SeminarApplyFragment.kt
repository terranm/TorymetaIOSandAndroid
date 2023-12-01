package com.tnmeta.torymeta.seminar

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.databinding.FragmentSeminarApplyBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.meta.Member
import com.tnmeta.torymeta.model.meta.MetaVerseDto
import com.tnmeta.torymeta.model.meta.Options
import com.tnmeta.torymeta.model.param.SeminarEnterParam
import com.tnmeta.torymeta.model.result.ApiResponse
import com.tnmeta.torymeta.seminar.dialog.SeminarAlertDialog
import com.tnmeta.torymeta.seminar.dialog.SeminarPasswordBottomDialogFragment
import com.tnmeta.torymeta.seminar.model.SeminarEnterInfo
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.model.detail.SeminarDetailDto
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class SeminarApplyFragment : BaseFragment(), View.OnClickListener {
    companion object {
        val TAG : String = SeminarApplyFragment::class.java.simpleName
    }

    private var _viewBinding: FragmentSeminarApplyBinding? = null
    private val viewBinding get() = _viewBinding!!

    private var dataInfo : SeminarDto? = null
    private var detailInfo : SeminarDetailDto? = null

    private val args by navArgs<SeminarApplyFragmentArgs>()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentSeminarApplyBinding.inflate(inflater, container, false)
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {
            if(args.param != null) {
                dataInfo = args.param
            }

            Timber.tag(TAG).d("SeminarApplyFragment $dataInfo")

            /*
            cancel.setOnClickListener(this@SeminarApplyFragment)
            apply.setOnClickListener(this@SeminarApplyFragment)
            */

            arrayOf(cancel, apply).forEach {
                it.setOnClickListener(this@SeminarApplyFragment)
            }

            CoroutineScope(Dispatchers.Main).launch {
                if(dataInfo != null)
                    getSeminarDetailInfo(dataInfo!!)
            }

            ivBack.setOnClickListener {
                findNavController().popBackStack()
            }
        }
    }

    private fun getSeminarDetailInfo(dataInfo : SeminarDto) = try {
        Timber.tag(TAG).d("getSeminarDetailInfo $dataInfo.id ")
        repository.getSeminarDetail(dataInfo.id).apply {
            subscribeBy(onNext = {
                viewBinding.apply {
                    if(it != null) {
                        detailInfo = it
                        it.apply {
                            seminarTitle.text = title
                            seminarDesc.text = description
                            seminarTeacher.text = teacherName

                            val start = DateFormatter.instance.dateBarTimeFormatter().parse(startAt)
                            val end = DateFormatter.instance.dateBarTimeFormatter().parse(endAt)

                            val startDate = DateFormatter.instance.simpleDotted().format(start)
                            val endDate = DateFormatter.instance.simpleDotted().format(end)

                            seminarDay.text = if(startDate == endDate) String.format("%s", startDate)
                                                    else String.format("%s ~ %s", startDate, endDate)

                            seminarTime.text = String.format("%s - %s", DateFormatter.instance.dateTimeFormatter().format(start),
                                                    DateFormatter.instance.dateTimeFormatter().format(end))

                            seminarPersonnel.text = String.format("%d / %d", participationCount, maxEnterCount)

                            txtApply.text = if(args.param.secretYn == Constants.YesValue) requireContext().getString(R.string.seminar_apply)
                                                else requireContext().getString(R.string.seminar_participate)

                            iconLock.visibility = if(secretYn == Constants.YesValue) View.VISIBLE
                                                    else View.GONE

                            seminarMyCreateLayout.visibility = if(it.teacherId == repository.member.value!!.memberId) View.VISIBLE
                                                                else View.GONE

                            when (status) {
                                SeminarStatus.START -> {
                                    if(dataInfo.teacherId == repository.member.value!!.memberId) {
                                        apply.setBackgroundResource(R.drawable.round_apply_purple)
                                        txtApply.text = resources.getString(R.string.enter_comment)
                                    }else {
                                        if(dataInfo.secretYn == Constants.YesValue) {
                                            if(participateYn == Constants.YesValue){
                                                apply.setBackgroundResource(R.drawable.round_apply_purple)
                                                txtApply.text = resources.getString(R.string.seminar_participate)
                                            }else {
                                                apply.setBackgroundResource(R.drawable.round_apply_grey)
                                                txtApply.text = resources.getString(R.string.seminar_apply)
                                            }
                                        }else {
                                            apply.setBackgroundResource(R.drawable.round_apply_purple)
                                            txtApply.text = resources.getString(R.string.seminar_participate)
                                        }
                                    }
                                }
                                SeminarStatus.END -> {
                                    apply.setBackgroundResource(R.drawable.round_apply_grey)

                                    if(dataInfo.teacherId == repository.member.value!!.memberId) {
                                        txtApply.text = resources.getString(R.string.enter_comment)
                                    }else {
                                        if(dataInfo.secretYn == Constants.YesValue) {
                                            if(participateYn == Constants.YesValue){
                                                txtApply.text = resources.getString(R.string.seminar_participate)
                                            }else {
                                                txtApply.text = resources.getString(R.string.seminar_apply)
                                            }
                                        }else {
                                            txtApply.text = resources.getString(R.string.seminar_participate)
                                        }
                                    }

                                }
                                SeminarStatus.BEFORE_START -> {
                                    apply.setBackgroundResource(R.drawable.round_apply_purple)
                                    if(dataInfo.teacherId == repository.member.value!!.memberId) {
                                        txtApply.text = resources.getString(R.string.enter_comment)
                                    }else {
                                        if(dataInfo.secretYn == Constants.YesValue) {
                                            if(participateYn == Constants.YesValue){
                                                txtApply.text = resources.getString(R.string.seminar_participate)
                                                apply.setBackgroundResource(R.drawable.round_apply_grey)
                                            }else {
                                                txtApply.text = resources.getString(R.string.seminar_apply)
                                            }
                                        }else {
                                            txtApply.text = resources.getString(R.string.seminar_participate)
                                            apply.setBackgroundResource(R.drawable.round_apply_grey)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            }, onError = {}, onComplete = {})
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    override fun onClick(view: View) {
        when(view.id) {
            R.id.cancel -> {
                SeminarAlertDialog.Builder(requireContext())
                    .setCancelable(false)
                    .setTitle(R.string.seminar_cancel_message)
                    .setMessage(R.string.seminar_cancel_detail_message)
                    .setNegativeButton(R.string.seminar_apply_cancel) {}
                    .setPositiveButton(R.string.seminar_cancel_yes) {
                        findNavController().popBackStack()
                    }
                    .show()
            }

            R.id.apply -> {
                try {
                    detailInfo!!.apply {
                        when(status) {
                            SeminarStatus.END -> {
                                CommonAlertDialog.Builder(requireContext())
                                    .setMessage(R.string.seminar_end_message)
                                    .setPositiveButton(R.string.system_alert_btn_ok) {}
                                    .show()
                                return
                            }

                            SeminarStatus.START -> {
                                if (teacherId == repository.member.value!!.memberId) {
                                    myCreateEnterSeminarRoom(dataInfo!!)
                                } else {
                                    if(secretYn == Constants.YesValue) {
                                        if(participateYn == Constants.YesValue) {
                                            SeminarPasswordBottomDialogFragment(requireContext(), false).apply {
                                                setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                                                onClickListener = { data ->
                                                    if (data.toString().isEmpty()) {
                                                        CommonAlertDialog.Builder(requireContext())
                                                            .setMessage(R.string.password_input_hint)
                                                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                                                            .show()
                                                    } else {
                                                        val params = BaseParam(SeminarEnterParam(data.toString())).parameter
                                                        repository.apply {
                                                            setSeminarEnter(dataInfo!!.id, params).subscribeBy(onNext = { it ->
                                                                if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                                                                    enterSeminarRoom(detailInfo!!, it.result!!)
                                                                } else {
                                                                    CommonAlertDialog.Builder(this@SeminarApplyFragment.requireContext())
                                                                        .setMessage(it.resultMessage.toString())
                                                                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                                                                        .show()
                                                                }

                                                            }, onError = {
                                                                Timber.d("" + it.message)
                                                            }, onComplete = {
                                                                Timber.d("onComplete")
                                                            })
                                                        }
                                                    }
                                                }
                                                show(this@SeminarApplyFragment.childFragmentManager, Constants.SeminarPasswordBottomDialogFragmentTag)
                                            }
                                        }else {
                                            CommonAlertDialog.Builder(requireContext())
                                                .setMessage(R.string.seminar_live_not_allow)
                                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                                .show()
                                        }

                                    }else {
                                        val params = BaseParam(SeminarEnterParam("")).parameter
                                        repository.apply {
                                            setSeminarEnter(dataInfo!!.id, params).subscribeBy(onNext = { it ->
                                                if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                                                    enterSeminarRoom(detailInfo!!, it.result!!)
                                                } else {
                                                    CommonAlertDialog.Builder(requireContext())
                                                        .setMessage(it.resultMessage.toString())
                                                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                                                        .show()
                                                }
                                            }, onError = {
                                                Timber.d("" + it.message)
                                            }, onComplete = {
                                                Timber.d("onComplete")
                                            })
                                        }
                                    }
                                }

                            }

                            SeminarStatus.BEFORE_START -> {
                                if(secretYn == Constants.YesValue) {
                                    if(participateYn == Constants.YesValue) {
                                        CommonAlertDialog.Builder(requireContext())
                                            .setMessage(R.string.seminar_secret_before_message)
                                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                                            .show()
                                    }else {
                                        CommonAlertDialog.Builder(requireContext())
                                            .setMessage(R.string.seminar_participate_message)
                                            .setPositiveButton(R.string.system_alert_btn_ok) {
                                                repository.setParticipate(dataInfo!!.id)
                                                    .subscribeBy(onNext = {
                                                        if (it.result!!.isSucceed) {
                                                            SeminarAlertDialog.Builder(this@SeminarApplyFragment.requireContext())
                                                                .setCancelable(false)
                                                                .setTitle(R.string.secret_seminar_apply_success_message)
                                                                .setMessage(R.string.secret_seminar_apply_success_message_detail)
                                                                .setPositiveButton(R.string.system_alert_btn_ok) {
                                                                    findNavController().popBackStack()
                                                                }
                                                                .show()
                                                        }else {
                                                            CommonAlertDialog.Builder(this@SeminarApplyFragment.requireContext())
                                                                .setMessage(it.resultMessage.toString())
                                                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                                                .show()
                                                        }

                                                    }, onError = {

                                                    })
                                            }.show()
                                    }
                                }else {
                                    CommonAlertDialog.Builder(requireContext())
                                        .setMessage(R.string.seminar_secret_before_message)
                                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                                        .show()
                                }
                            }
                        }
                    }
                }catch (e : Exception){
                    Timber.d(e.message)
                }
            }
        }
    }

    private fun myCreateEnterSeminarRoom(item: SeminarDto) = try {
        repository.apply {
            getRoomPassword(item.id).subscribeBy(onNext = { passwordResult ->
                Timber.tag(MainFragment.TAG).d("myCreateEnterSeminarRoom ${passwordResult.result!!.password}")

                if(passwordResult.resultCode == ApiResponse.RESULT_CODE_OK) {
                    val params = BaseParam(SeminarEnterParam(passwordResult.result!!.password)).parameter
                    setSeminarEnter(item.id, params).subscribeBy (onNext = {it ->
                        if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                            enterSeminarRoom(detailInfo!!, it.result!!)
                        } else {
                            CommonAlertDialog.Builder(this@SeminarApplyFragment.requireContext())
                                .setMessage(it.resultMessage.toString())
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                        }
                    })
                }else {
                    CommonAlertDialog.Builder(this@SeminarApplyFragment.requireContext())
                        .setMessage(passwordResult.resultMessage.toString())
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }
            })
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }



    private fun enterSeminarRoom(item: SeminarDetailDto, result : SeminarEnterResult) {
        try {
            //if (repository.myAvatar.value!!.id == 0) {
            if(repository.hasAvatarAttrYn == Constants.NoValue){
                CommonAlertDialog.Builder(requireContext())
                    .setCancelable(false)
                    .setMessage(R.string.avatar_make_message)
                    .setPositiveButton {}
                    .show()
                return
            }

            CoroutineScope(Dispatchers.Main).launch {
                val infoData = enterSeminarRoom(
                    item = SeminarEnterInfo(teacherName = item.teacherName, title = item.title, item.startAt),
                    result = result
                )

                val action = SeminarApplyFragmentDirections.actionSeminarApplyToTorymetaWorld(infoData)
                findNavController().navigate(action)
            }
        } catch (e: Exception) {
            Timber.d(e.message)
        }
    }


}