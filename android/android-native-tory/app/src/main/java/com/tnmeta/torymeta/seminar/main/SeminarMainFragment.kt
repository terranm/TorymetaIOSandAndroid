package com.tnmeta.torymeta.seminar.main


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.databinding.FragmentSeminarMainBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.param.SeminarEnterParam
import com.tnmeta.torymeta.model.result.ApiResponse
import com.tnmeta.torymeta.model.unity.VideoUrl
import com.tnmeta.torymeta.seminar.CreateSeminarActivity
import com.tnmeta.torymeta.seminar.adapter.SeminarMainRecyclerViewAdapter
import com.tnmeta.torymeta.seminar.dialog.SeminarAlertDialog
import com.tnmeta.torymeta.seminar.dialog.SeminarPasswordBottomDialogFragment
import com.tnmeta.torymeta.seminar.model.SeminarEnterInfo
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.model.SeminarInfo
import com.tnmeta.torymeta.seminar.model.SortType
import com.tnmeta.torymeta.seminar.model.ToryLoungeInfo
import com.tnmeta.torymeta.seminar.viewmodel.MainSeminarViewModel
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.unity.UnityUtils
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import timber.log.Timber
import java.util.Calendar


class SeminarMainFragment : BaseFragment(), View.OnClickListener {
    companion object {
        val TAG : String = SeminarMainFragment::class.java.simpleName

        fun newInstance() = SeminarMainFragment().apply {}
        const val SPAN_COUNT = 2
    }


    private var _viewBinding: FragmentSeminarMainBinding? = null
    private val viewBinding get() = _viewBinding!!

    private lateinit var viewModel: MainSeminarViewModel
    private val mSeminarArrayList = ArrayList<SeminarDto>()
    private lateinit var mSeminarAdapter : SeminarMainRecyclerViewAdapter

    private var sortType = SortType.All
    private var isRefresh = false

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentSeminarMainBinding.inflate(inflater, container, false)
        viewBinding.apply {
            viewModel = ViewModelProvider(this@SeminarMainFragment)[MainSeminarViewModel::class.java]

        }
        return viewBinding.root
    }



    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {

            arrayOf(ivBack, calendarBtn, mySeminar, toryLounge,
                    filterAllLayout, filterStartLayout, filterBeforeLayout, filterEndLayout,
                    editBoxDeleteBtn, actionCreate, actionUpMove).forEach {
                it.setOnClickListener(this@SeminarMainFragment)
            }

            editBox.setOnFocusChangeListener { _, hasFocus ->
                if(hasFocus) {
                    findNavController().navigate(R.id.action_seminar_main_to_search_seminar)
                }
            }

            mSeminarAdapter = SeminarMainRecyclerViewAdapter(
                repository = repository,
                itemViewClick = { dataInfo ->
                    val infoData = SeminarInfo(dataInfo.id, dataInfo.roomImageUrl)
                    val action  = SeminarMainFragmentDirections.actionSeminarMainToDetailSeminar(infoData)
                    findNavController().navigate(action)
                },
                itemButtonClick = { item, position ->
                    if(repository.hasAvatarAttrYn == Constants.NoValue){
                        CommonAlertDialog.Builder(requireContext())
                            .setCancelable(false)
                            .setMessage(R.string.avatar_make_message)
                            .setPositiveButton {}
                            .show()
                        return@SeminarMainRecyclerViewAdapter
                    }

                    if(item.teacherId == repository.member.value!!.memberId) {
                        myCreateEnterSeminarRoom(item)
                    }else {
                        onJoinClickEvent(item, position)
                    }
                }
            )

            seminarListView.apply {
                layoutManager = GridLayoutManager(requireContext(), SPAN_COUNT)
                adapter = mSeminarAdapter
            }

            initData()
            initSortButton(SortType.All)

            refreshLayout.setOnRefreshListener {
                CoroutineScope(Dispatchers.Main).launch {
                    viewModel.apply {

                        val day = Calendar.getInstance()
                        day.add(Calendar.DATE, 0)
                        val searchDate = DateFormatter.instance.dateFormatter().format(day.time)
                        isRefresh = true
                        getDateSeminar(searchDate)
                    }
                }
                refreshLayout.isRefreshing = false
            }
        }
    }

    override fun onResume() {
        super.onResume()
        try {
            UnityUtils.resume()

            CoroutineScope(Dispatchers.IO).launch {
                viewModel.apply {
                    delay(400)
                    val day = Calendar.getInstance()
                    day.add(Calendar.DATE, 0)
                    val searchDate = DateFormatter.instance.dateFormatter().format(day.time)
                    getDateSeminar(searchDate)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onPause() {
        super.onPause()
        try {
            UnityUtils.pause()
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }

    override fun onClick(view: View) {
        when(view.id){

            R.id.ivBack -> findNavController().popBackStack()

            R.id.calendarBtn -> findNavController().navigate(R.id.action_seminar_main_to_seminar_schedule)

            R.id.my_seminar -> findNavController().navigate(R.id.action_seminar_main_to_my_seminar)

            R.id.tory_lounge -> {
                //if(repository.myAvatar.value!!.id == 0){
                if(repository.hasAvatarAttrYn == Constants.NoValue){
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(R.string.avatar_make_message)
                        .setPositiveButton {}
                        .show()
                    return
                }

                repository.apply {
                    val params = BaseParam(
                        VideoUrl(
                            loungeType = "LOUNGE",
                            mediaType = "mp4"
                        )).parameter

                    getVideoUrl(json = params).subscribeBy(onNext = {
                        CoroutineScope(Dispatchers.Main).launch {
                            val infoData = enterToryLounge(ToryLoungeInfo(videoUrl = it.videoUrl))
                            val action = SeminarMainFragmentDirections.actionSeminarMainToTorymetaWorld(infoData)
                            findNavController().navigate(action)
                        }
                    }, onError = {})

                }
            }
            R.id.filter_all_layout -> initSortButton(SortType.All)
            R.id.filter_start_layout -> initSortButton(SortType.Start)
            R.id.filter_before_layout -> initSortButton(SortType.Before)
            R.id.filter_end_layout -> initSortButton(SortType.End)

            R.id.editBoxDeleteBtn ->  findNavController().navigate(R.id.action_seminar_main_to_search_seminar)

            R.id.actionCreate -> {
                CreateSeminarActivity.createIntent(requireContext()).run {
                    startActivity(this)
                }
            }

            R.id.actionUpMove -> {
                viewBinding.apply {
                    actionUpMove.visibility = View.INVISIBLE
                    CoroutineScope(Dispatchers.Main).launch {
                        seminarListView.smoothScrollToPosition(0)
                    }
                }
            }
        }
    }

    private fun initData() = viewBinding.apply {
        try {
            mSeminarArrayList.clear()
            viewModel.seminarArray.observe(viewLifecycleOwner) { list ->

                loadingProgress.visibility = View.GONE
                if (isRefresh) {
                    isRefresh = false
                    mSeminarArrayList.clear()
                    mSeminarAdapter.arrayReset()
                }
                mSeminarArrayList.apply {
                    clear()
                    addAll(list)
                }

                if (mSeminarArrayList.isEmpty()) {
                    seminarListView.visibility = View.GONE
                    emptyView.visibility = View.VISIBLE
                } else {
                    emptyView.visibility = View.GONE
                    seminarListView.visibility = View.VISIBLE
                }

                mSeminarAdapter.apply {
                    arrayReset()
                    replaceItems(mSeminarArrayList)
                    notifyDataSetChanged()
                }
            }

            seminarListView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
                override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                    super.onScrollStateChanged(recyclerView, newState)
                    viewBinding.apply {
                        if (mSeminarArrayList.size >= 2) {
                            actionUpMove.visibility = if (!seminarListView.canScrollVertically(-1) && newState == RecyclerView.SCROLL_STATE_IDLE) {
                                View.INVISIBLE
                            } else {
                                View.VISIBLE
                            }
                        }
                    }
                }

                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                    super.onScrolled(recyclerView, dx, dy)
                    val lastVisibleItemPosition = (recyclerView.layoutManager as LinearLayoutManager?)!!.findLastCompletelyVisibleItemPosition()
                    val itemTotalCount = recyclerView.adapter!!.itemCount - 1

                    if (lastVisibleItemPosition == itemTotalCount) {
                        CoroutineScope(Dispatchers.Main).launch {
                            val lastIndex = mSeminarArrayList.lastIndex
                            viewModel.apply {
                                getSeminar(mSeminarArrayList[lastIndex].id)
                            }
                        }
                    }
                }
            })

        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
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
                            enterSeminarRoom(item!!, it.result!!)
                        } else {
                            CommonAlertDialog.Builder(this@SeminarMainFragment.requireContext())
                                .setMessage(it.resultMessage.toString())
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                        }
                    })
                }else {
                    SeminarMessage.instance.showAlertMessage(this@SeminarMainFragment.requireContext(),
                                                                    passwordResult.resultMessage.toString())
                }
            })
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    
    private fun onJoinClickEvent(item : SeminarDto, position: Int) = try {
        when(item.status) {
            SeminarStatus.END -> {
                SeminarMessage.instance.showAlertMessage(this@SeminarMainFragment.requireContext(),
                                                               R.string.seminar_end_message)
            }

            SeminarStatus.START -> {
                if(item.secretYn == Constants.YesValue && item.participationYn == Constants.YesValue) {
                    CommonAlertDialog.Builder(requireContext())
                        .setMessage(R.string.seminar_enter_ask_message)
                        .setNegativeButton(R.string.seminar_apply_cancel) {}
                        .setPositiveButton(R.string.seminar_cancel_yes) {
                            SeminarPasswordBottomDialogFragment(this@SeminarMainFragment.requireContext(), false).apply {
                                setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                                onClickListener = { data ->

                                    if (data.toString().isEmpty()) {
                                        CommonAlertDialog.Builder(this@SeminarMainFragment.requireContext())
                                            .setMessage(R.string.password_input_hint)
                                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                                            .show()
                                    } else {
                                        val params = BaseParam(SeminarEnterParam(data.toString())).parameter
                                        Timber.tag(TAG).d("param $params")
                                        Timber.tag(TAG).d("param ${item.id}")

                                        repository.apply {
                                            setSeminarEnter(item.id, params).subscribeBy(onNext = {it->
                                                if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                                                    enterSeminarRoom(item, it.result!!)
                                                } else {
                                                    CommonAlertDialog.Builder(this@SeminarMainFragment.requireContext())
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
                                show(this@SeminarMainFragment.childFragmentManager, Constants.SeminarPasswordBottomDialogFragmentTag)
                            }
                        }
                        .show()
                }else {
                    if(item.secretYn == Constants.YesValue && item.participationYn == Constants.NoValue) {

                        SeminarMessage.instance.showAlertMessage(this@SeminarMainFragment.requireContext(),
                                                                    R.string.seminar_live_not_allow)

                    }else {
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(R.string.seminar_enter_ask_message)
                            .setNegativeButton(R.string.seminar_apply_cancel) {}
                            .setPositiveButton(R.string.seminar_cancel_yes) {
                                Timber.tag(TAG).d("id  = $item.id")
                                val params = BaseParam(SeminarEnterParam("")).parameter
                                repository.apply {
                                    setSeminarEnter(item.id, params).subscribeBy(onNext = { it ->
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
                                        Timber.d("onComplete")
                                    })
                                }
                            }
                            .show()
                    }
                }
            }

            SeminarStatus.BEFORE_START -> {
                if(item.secretYn == Constants.YesValue) {
                    if(item.participationYn == Constants.YesValue) {
                        SeminarMessage.instance.showAlertMessage(this@SeminarMainFragment.requireContext(),
                                                                    R.string.seminar_secret_before_message)
                    }else {
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(R.string.seminar_participate_message)
                            .setNegativeButton(R.string.seminar_apply_cancel) {}
                            .setPositiveButton(R.string.seminar_cancel_yes) {
                                repository.setParticipate(item.id)
                                    .subscribeBy(onNext = {
                                        if (it.result!!.isSucceed) {
                                            SeminarAlertDialog.Builder(this@SeminarMainFragment.requireContext())
                                                .setCancelable(false)
                                                .setTitle(R.string.secret_seminar_apply_success_message)
                                                .setMessage(R.string.secret_seminar_apply_success_message_detail)
                                                .setPositiveButton(R.string.system_alert_btn_ok) {
                                                    item.participationYn = "Y"
                                                    mSeminarArrayList[position] = item
                                                    mSeminarAdapter.notifyItemChanged(position, item)
                                                }
                                                .show()
                                        }else {
                                            CommonAlertDialog.Builder(requireContext())
                                                .setMessage(it.resultMessage.toString())
                                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                                .show()
                                        }

                                    }, onError = {

                                    })
                            }.show()
                    }
                }else {
                    SeminarMessage.instance.showAlertMessage(this@SeminarMainFragment.requireContext(),
                                                                    R.string.seminar_secret_before_message)
                }
            }
            else -> {}
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }



    private fun enterSeminarRoom(item : SeminarDto, result : SeminarEnterResult) {
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

                Timber.tag(TAG).d("enterSeminar $infoData")

                val action = SeminarMainFragmentDirections.actionSeminarMainToTorymetaWorld(infoData)
                findNavController().navigate(action)
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    private fun initSortButton(type : SortType) = try {
        sortType = type

        viewBinding.apply {
            val layoutArray = arrayOf(filterAllLayout, filterStartLayout, filterBeforeLayout, filterEndLayout)
            layoutArray.forEach {
                it.setBackgroundResource(R.drawable.common_corner_circle_stroke_gray_04)
            }

            val textArray = arrayOf(filterAll, filterStart, filterBefore, filterEnd)
            textArray.forEach {
                it.setTextColor(ContextCompat.getColor(requireContext(),  R.color.tory_gray_04))
            }

            layoutArray[type.ordinal].setBackgroundResource(R.drawable.common_corner_round_stroke_purple_02)
            textArray[type.ordinal].setTextColor(ContextCompat.getColor(requireContext(),  R.color.tory_purple))

            if(mSeminarArrayList.isNotEmpty()) {
                mSeminarAdapter.apply {
                    setSortType(type)
                    notifyDataSetChanged()
                }
            }
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

}