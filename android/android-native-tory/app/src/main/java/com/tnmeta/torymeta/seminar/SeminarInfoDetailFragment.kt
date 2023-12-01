package com.tnmeta.torymeta.seminar


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.databinding.FragmentSeminarInfoDetailBinding
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
import com.tnmeta.torymeta.seminar.viewmodel.SeminarInfoDetailViewModel
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class SeminarInfoDetailFragment : BaseFragment() {
    companion object {
        val TAG : String = SeminarInfoDetailFragment::class.java.simpleName
    }

    private var _viewBinding: FragmentSeminarInfoDetailBinding? = null
    private val viewBinding get() = _viewBinding!!
    private lateinit var viewModel: SeminarInfoDetailViewModel

    private val args by navArgs<SeminarInfoDetailFragmentArgs>()
    private lateinit var seminarDetailDto : SeminarDetailDto

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentSeminarInfoDetailBinding.inflate(inflater, container, false)
        viewBinding.apply {
            viewModel = ViewModelProvider(this@SeminarInfoDetailFragment)[SeminarInfoDetailViewModel::class.java]
        }
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {
            close.setOnClickListener {
                findNavController().popBackStack()
            }

            viewModel.seminarInfo.observe(viewLifecycleOwner) {
                seminarDetailDto = it
                Timber.tag(TAG).d("onViewCreated $seminarDetailDto")
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
                    seminarEnter.setBackgroundResource(R.drawable.common_round_enter_purple)

                    seminarMyCreateLayout.visibility = if(it.teacherId == repository.member.value!!.memberId) View.VISIBLE else View.GONE

                    when (status) {
                        SeminarStatus.END -> {
                            seminarSituation.text = resources.getString(R.string.seminar_end)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_end)
                            seminarEnter.setBackgroundResource(R.drawable.common_round_enter_grey)
                            txtEnter.text = resources.getString(R.string.seminar_participate)
                        }

                        SeminarStatus.START -> {
                            seminarSituation.text = resources.getString(R.string.seminar_now)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_now)

                            if(teacherId == repository.member.value!!.memberId) {
                                txtEnter.text = resources.getString(R.string.enter_comment)
                                seminarEnter.setBackgroundResource(R.drawable.common_round_enter_purple)
                            }else {
                                if(secretYn == Constants.YesValue) {
                                    if (participateYn == Constants.YesValue) {
                                        txtEnter.text = resources.getString(R.string.seminar_participate)
                                        seminarEnter.setBackgroundResource(R.drawable.common_round_enter_purple)
                                    } else {
                                        txtEnter.text = resources.getString(R.string.seminar_apply)
                                        seminarEnter.setBackgroundResource(R.drawable.common_round_enter_grey)
                                    }
                                }else {
                                    txtEnter.text = resources.getString(R.string.seminar_participate)
                                    seminarEnter.setBackgroundResource(R.drawable.common_round_enter_purple)
                                }
                            }

                        }

                        SeminarStatus.BEFORE_START -> {
                            seminarSituation.text = resources.getString(R.string.seminar_before)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_before)

                            if(teacherId == repository.member.value!!.memberId) {
                                txtEnter.text = resources.getString(R.string.enter_comment)
                            }else {
                                if(secretYn == Constants.YesValue){
                                    if(participateYn == Constants.YesValue) {
                                        txtEnter.text = resources.getString(R.string.seminar_participate)
                                        seminarEnter.setBackgroundResource(R.drawable.common_round_enter_grey)
                                    }else {
                                        txtEnter.text = resources.getString(R.string.seminar_apply)
                                        seminarEnter.setBackgroundResource(R.drawable.common_round_enter_purple)
                                    }
                                }else {
                                    txtEnter.text = resources.getString(R.string.seminar_participate)
                                    seminarEnter.setBackgroundResource(R.drawable.common_round_enter_purple)
                                }
                            }
                        }
                    }

                    iconLock.visibility = if(secretYn == Constants.YesValue) View.VISIBLE else View.GONE
                    Glide.with(requireContext())
                            .load(roomImageUrl)
                            .into(imgSeminarRoom)
                }
            }

            actionUpMove.setOnClickListener {
                actionUpMove.visibility = View.INVISIBLE
                CoroutineScope(Dispatchers.Main).launch {
                    mainScrollview.fullScroll(View.FOCUS_UP)
                    mainScrollview.smoothScrollTo(0, 0)
                }
            }

            seminarEnter.setOnClickListener {
                //if (repository.myAvatar.value!!.id == 0) {
                if(repository.hasAvatarAttrYn == Constants.NoValue){
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(R.string.avatar_make_message)
                        .setPositiveButton {}
                        .show()
                    return@setOnClickListener
                }

                seminarDetailDto.apply {
                    when(status) {
                        SeminarStatus.END -> {
                            CommonAlertDialog.Builder(requireContext())
                                .setMessage(R.string.seminar_end_message)
                                .setPositiveButton(R.string.system_alert_btn_ok) {
                                }
                                .show()
                        }
                        SeminarStatus.START -> {
                            if(secretYn == Constants.YesValue && participateYn == Constants.NoValue) {
                                CommonAlertDialog.Builder(requireContext())
                                    .setMessage(R.string.seminar_live_not_allow)
                                    .setPositiveButton(R.string.system_alert_btn_ok) {}
                                    .show()
                            }else {
                                CommonAlertDialog.Builder(requireContext())
                                    .setMessage(R.string.seminar_enter_ask_message)
                                    .setNegativeButton(R.string.seminar_apply_cancel) {}
                                    .setPositiveButton(R.string.seminar_cancel_yes) {
                                        clickEnter(seminarDetailDto)
                                    }
                                    .show()
                            }
                        }

                        SeminarStatus.BEFORE_START -> {
                            if(secretYn == Constants.YesValue && participateYn == Constants.NoValue) {
                                CommonAlertDialog.Builder(requireContext())
                                    .setMessage(R.string.seminar_participate_message)
                                    .setPositiveButton(R.string.system_alert_btn_ok) {
                                        repository.setParticipate(args.param.id).subscribeBy(onNext = {
                                                if (it.result!!.isSucceed) {
                                                    SeminarAlertDialog.Builder(requireContext())
                                                        .setCancelable(false)
                                                        .setTitle(R.string.secret_seminar_apply_success_message)
                                                        .setMessage(R.string.secret_seminar_apply_success_message_detail)
                                                        .setPositiveButton(R.string.system_alert_btn_ok) {
                                                            findNavController().popBackStack()
                                                        }
                                                        .show()
                                                }else {
                                                    CommonAlertDialog.Builder(this@SeminarInfoDetailFragment.requireContext())
                                                        .setMessage(it.resultMessage.toString())
                                                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                                                        .show()
                                                }

                                            }, onError = {

                                            })
                                    }.show()
                            }else {
                                CommonAlertDialog.Builder(requireContext())
                                    .setMessage(R.string.seminar_secret_before_message)
                                    .setPositiveButton(R.string.system_alert_btn_ok) {}
                                    .show()
                            }

                        }
                    }
                }
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }

    override fun onResume() {
        super.onResume()
        viewModel.apply {
            Timber.tag(TAG).d("onResume " + args.param.id)
            getSeminarDetailInfo(args.param.id)
        }
    }

    private fun clickEnter(item : SeminarDetailDto) = try {

        if(item.secretYn == Constants.YesValue && item.participateYn == Constants.YesValue) {
            SeminarPasswordBottomDialogFragment(requireContext(), false).apply {
                setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                onClickListener = { data ->
                    if(data.toString().isEmpty()) {
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(R.string.password_input_hint)
                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                            .show()
                    }else {
                        val params = BaseParam(SeminarEnterParam(password = data.toString())).parameter
                        repository.apply {
                            setSeminarEnter(args.param.id, params).subscribeBy(onNext = {
                                if(it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                                    enterSeminarRoom(item , it.result!!)
                                }else {
                                    CommonAlertDialog.Builder(this@SeminarInfoDetailFragment.requireContext())
                                        .setMessage(it.resultMessage.toString())
                                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                                        .show()
                                }
                            }, onError = {
                                Timber.d("" + it.message)
                            }, onComplete = {
                                Timber.d("onComplete" )
                            })
                        }
                    }
                }
                show(this@SeminarInfoDetailFragment.childFragmentManager, Constants.SeminarPasswordBottomDialogFragmentTag)
            }

        }else {
            val params = BaseParam(SeminarEnterParam(password = "")).parameter
            repository.apply {
                setSeminarEnter(args.param.id, params).subscribeBy(onNext = {
                    if(it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue ) {
                        enterSeminarRoom(item , it.result!!)
                    }else {
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(it.resultMessage.toString())
                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                            .show()
                    }
                }, onError = {
                    Timber.d("" + it.message)
                }, onComplete = {
                    Timber.d("onComplete" )
                })
            }
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }



    private fun enterSeminarRoom(item: SeminarDetailDto , result : SeminarEnterResult) {
        try {
            Timber.tag(TAG).d("enterSeminarRoom ")

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
                /*
                val infoData = enterMetaSeminarRoom(
                    item = SeminarEnterInfo(teacherName = item.teacherName, title = item.title, startAt = item.startAt),
                    result = result
                )
                */

                val infoData = enterSeminarRoom(
                    item = SeminarEnterInfo(teacherName = item.teacherName, title = item.title, item.startAt),
                    result = result
                )

                val action = SeminarInfoDetailFragmentDirections.actionSeminarDetailToTorymetaWorld(infoData)
                findNavController().navigate(action)
            }

        } catch (e: Exception) {
            Timber.d(e.message)
        }
    }

}