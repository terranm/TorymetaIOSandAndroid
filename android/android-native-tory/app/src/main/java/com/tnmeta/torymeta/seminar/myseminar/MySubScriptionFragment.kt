package com.tnmeta.torymeta.seminar.myseminar

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.databinding.FragmentMySubScriptionBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.param.SeminarEnterParam
import com.tnmeta.torymeta.model.result.ApiResponse
import com.tnmeta.torymeta.seminar.adapter.MySubScriptionAdapter
import com.tnmeta.torymeta.seminar.dialog.SeminarPasswordBottomDialogFragment
import com.tnmeta.torymeta.seminar.model.SeminarEnterInfo
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.model.SeminarInfo
import com.tnmeta.torymeta.seminar.viewmodel.MySubScriptionViewModel
import com.tnmeta.torymeta.seminar.model.seminar.Content
import com.tnmeta.torymeta.ui.CommonAlertDialog
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.DecimalFormat


class MySubScriptionFragment : BaseFragment() {
    companion object {
        val TAG : String = MySubScriptionFragment::class.java.simpleName
    }

    private var _viewBinding: FragmentMySubScriptionBinding? = null
    private val viewBinding get() = _viewBinding!!

    private lateinit var mAdapter : MySubScriptionAdapter
    private lateinit var viewModel: MySubScriptionViewModel
    private val mSeminarArrayList = ArrayList<Content>()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentMySubScriptionBinding.inflate(inflater, container, false)
        viewBinding.apply {
            viewModel = ViewModelProvider(this@MySubScriptionFragment)[MySubScriptionViewModel::class.java]
        }
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {
            initList()

            viewModel.apply {
                getParticipationSeminar()
            }

            actionUpMove.setOnClickListener {
                actionUpMove.visibility = View.INVISIBLE
                CoroutineScope(Dispatchers.Main).launch {
                    seminarListView.smoothScrollToPosition(0)
                }
            }
        }

        if(Constants.is_FirebaseAnalytics) {
            CoroutineScope(Dispatchers.Main).launch {
                firebaseAnalyticsMember(FirebaseParam.mobile_mysemina_apply)
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }

    override fun onResume() {
        super.onResume()
    }


    private fun initList() = viewBinding.apply {
        mAdapter = MySubScriptionAdapter(
            items = mSeminarArrayList,
            onItemClick = {},
            onItemButtonClick = { view, item ->
                when(view.id) {
                    R.id.detailView -> {
                        item.apply {
                            try {
                                val infoData = SeminarInfo(id, room.roomImageUrl)

                                Timber.tag(TAG).d("onItemButtonClick %s", infoData)

                                val action = MySubScriptionFragmentDirections.actionMySeminarToDetailSeminar(infoData)
                                findNavController().navigate(action)
                            } catch (e: Exception) {
                                Timber.d(e.message)
                            }
                        }
                    }

                    R.id.seminar_enter -> {
                        item.apply {
                            if(status == SeminarStatus.END) {
                                CommonAlertDialog.Builder(requireContext())
                                    .setMessage(R.string.seminar_end_message)
                                    .setPositiveButton(R.string.system_alert_btn_ok) {}
                                    .show()

                                return@apply
                            }

                            when(status) {
                                SeminarStatus.START -> isCheckSeminarRoom(item)
                                SeminarStatus.BEFORE_START -> seminarBeforeStart(item)
                            }
                        }
                    }
                }
            }
        )
        seminarListView.apply {
            layoutManager = LinearLayoutManager(requireContext())
            adapter = mAdapter
        }

        seminarListView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                super.onScrollStateChanged(recyclerView, newState)
                viewBinding.apply {
                    if(mSeminarArrayList.size >= 2) {
                        if (!seminarListView.canScrollVertically(-1) && newState == RecyclerView.SCROLL_STATE_IDLE) {
                            actionUpMove.visibility = View.INVISIBLE
                        } else {
                            actionUpMove.visibility = View.VISIBLE
                        }
                    }
                }
            }
        })

        seminarListView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                super.onScrolled(recyclerView, dx, dy)

                val lastVisibleItemPosition = (recyclerView.layoutManager as LinearLayoutManager?)!!.findLastCompletelyVisibleItemPosition()
                val itemTotalCount = recyclerView.adapter!!.itemCount-1
                if(lastVisibleItemPosition == itemTotalCount ) {
                    CoroutineScope(Dispatchers.Main).launch {
                        val lastIndex = mSeminarArrayList.lastIndex
                        viewModel.apply {
                            getParticipationSeminar(mSeminarArrayList[lastIndex].id)
                        }
                    }
                }
            }
        })

        viewModel.seminarList.observe(viewLifecycleOwner) { list ->
            mSeminarArrayList.apply {
                addAll(list.content)
            }
            if(mSeminarArrayList.isEmpty()) {
                emptyView.visibility = View.VISIBLE
                seminarListView.visibility = View.GONE
            }else {
                emptyView.visibility = View.GONE
                seminarListView.visibility = View.VISIBLE
            }

            viewBinding.apply {

                mySubscritpCount.text = requireContext().getString(R.string.total_count_text, "${DecimalFormat("#,###").format(mSeminarArrayList.size)}")
            }
            mAdapter.notifyDataSetChanged()
        }
    }


    private fun isCheckSeminarRoom(item: Content) = try {
        if(item.secretYn == Constants.YesValue) {
            CommonAlertDialog.Builder(requireContext())
                .setMessage(R.string.seminar_enter_ask_message)
                .setNegativeButton(R.string.seminar_apply_cancel) {}
                .setPositiveButton(R.string.seminar_cancel_yes) {
                    SeminarPasswordBottomDialogFragment(this@MySubScriptionFragment.requireContext(), false).apply {
                        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                        onClickListener = { data ->
                            if (data.toString().isEmpty()) {
                                CommonAlertDialog.Builder(this@MySubScriptionFragment.requireContext())
                                    .setMessage(R.string.password_input_hint)
                                    .setPositiveButton(R.string.system_alert_btn_ok) {}
                                    .show()
                            } else {
                                val params = BaseParam(SeminarEnterParam(data.toString())).parameter
                                repository.apply {
                                    setSeminarEnter(item.id, params).subscribeBy(onNext = {it->
                                        if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                                            enterSeminarRoom(item, it.result!!)
                                        } else {
                                            CommonAlertDialog.Builder(this@MySubScriptionFragment.requireContext())
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
                        show(this@MySubScriptionFragment.childFragmentManager, Constants.SeminarPasswordBottomDialogFragmentTag)
                    }
                }
                .show()

        }else {
            val params = BaseParam(SeminarEnterParam("")).parameter
            repository.apply {
                setSeminarEnter(item.id, params).subscribeBy(onNext = { it->
                    if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                        enterSeminarRoom(item, it.result!!)
                    } else {
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

    private fun seminarBeforeStart(item: Content) = try {
        if(item.secretYn == Constants.YesValue) {
            CommonAlertDialog.Builder(requireContext())
                .setMessage(R.string.seminar_secret_before_message)
                .setPositiveButton(R.string.system_alert_btn_ok) {}
                .show()
        }else {
            CommonAlertDialog.Builder(requireContext())
                .setMessage(R.string.seminar_secret_before_message)
                .setPositiveButton(R.string.system_alert_btn_ok) {}
                .show()
        }

    }catch (e : Exception){
        Timber.tag(MainFragment.TAG).d(e.message)
    }



    private fun enterSeminarRoom(item : Content , result : SeminarEnterResult) {
        try {
            //if(repository.myAvatar.value!!.id == 0) {
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

                val action = MySubScriptionFragmentDirections.actionMySubscriptionToTorymetaWorld(infoData)
                findNavController().navigate(action)
            }

        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }
}