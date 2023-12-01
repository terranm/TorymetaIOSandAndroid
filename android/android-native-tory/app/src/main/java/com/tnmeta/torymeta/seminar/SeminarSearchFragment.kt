package com.tnmeta.torymeta.seminar

import android.annotation.SuppressLint
import android.app.Service
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.KeyEvent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.GranularRoundedCorners
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.databinding.FragmentSeminarSearchBinding
import com.tnmeta.torymeta.databinding.SeminarSearchListItemBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.param.SeminarEnterParam
import com.tnmeta.torymeta.model.result.ApiResponse
import com.tnmeta.torymeta.seminar.adapter.SeminarSearchAdapter
import com.tnmeta.torymeta.seminar.dialog.SeminarAlertDialog
import com.tnmeta.torymeta.seminar.dialog.SeminarPasswordBottomDialogFragment
import com.tnmeta.torymeta.seminar.main.SeminarMainFragment
import com.tnmeta.torymeta.seminar.model.SeminarEnterInfo
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.model.SeminarInfo
import com.tnmeta.torymeta.seminar.model.seminar.Content
import com.tnmeta.torymeta.seminar.viewmodel.SeminarSearchViewModel
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class SeminarSearchFragment : BaseFragment(), View.OnClickListener {
    companion object {
        val TAG : String = SeminarSearchFragment::class.java.simpleName

        fun newInstance() =
            SeminarSearchFragment().apply {}
    }

    private var _viewBinding: FragmentSeminarSearchBinding? = null
    private val viewBinding get() = _viewBinding!!

    private lateinit var viewModel: SeminarSearchViewModel
    private val mSeminarArrayList = ArrayList<Content>()

    private lateinit var mAdapter : SeminarSearchAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentSeminarSearchBinding.inflate(inflater, container, false)
        viewBinding.apply {
            viewModel = ViewModelProvider(this@SeminarSearchFragment)[SeminarSearchViewModel::class.java]
        }
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
         viewBinding.apply {
             close.setOnClickListener {
                 findNavController().popBackStack()
             }

             CoroutineScope(Dispatchers.Main).launch {
                 editSearch.requestFocus()
                 val imm: InputMethodManager = requireContext().getSystemService(Service.INPUT_METHOD_SERVICE) as InputMethodManager
                 imm.showSoftInput(editSearch, 0)
             }
             editBoxDeleteBtn.setOnClickListener(this@SeminarSearchFragment)
             searchResult.text = resources.getString(R.string.search_result_count, 0)

             mAdapter = SeminarSearchAdapter(
                 repository = repository,
                 items = mSeminarArrayList,
                 onItemClick = { item ->
                     val seminarInfo = SeminarInfo(item.id, item.room.roomImageUrl)

                     val action = SeminarSearchFragmentDirections.actionSeminarSearchToDetailSeminar(seminarInfo)
                     findNavController().navigate(action)

                 },
                 onItemButtonClick = {item ->
                     //if (repository.myAvatar.value!!.id == 0) {
                     if(repository.hasAvatarAttrYn == Constants.NoValue){
                         CommonAlertDialog.Builder(requireContext())
                             .setCancelable(false)
                             .setMessage(R.string.avatar_make_message)
                             .setPositiveButton {}
                             .show()
                         return@SeminarSearchAdapter
                     }

                     repository.apply {
                         if(item.teacherId == repository.member.value!!.memberId) {
                             myCreateEnterSeminarRoom(item)
                         }else {
                             onJoinClick(item)
                         }
                     }
                 }
             )
             resultRecycle.apply {
                 layoutManager = LinearLayoutManager(requireContext(), RecyclerView.VERTICAL, false)
                 adapter = mAdapter
             }

             mSeminarArrayList.clear()
             initData()

             emptyView.apply {
                 visibility = View.VISIBLE
                 text = resources.getString(R.string.seminar_search_init_message)
             }

             editSearch.setOnEditorActionListener(object : TextView.OnEditorActionListener {
                 override fun onEditorAction(v: TextView?, actionId: Int, event: KeyEvent?): Boolean {

                     if(actionId == EditorInfo.IME_ACTION_SEARCH) {
                         if(editSearch.text!!.isEmpty()) {
                             Toast.makeText(requireContext(), resources.getText(R.string.search_hint_message), Toast.LENGTH_SHORT).show()
                             return false
                         }

                         CoroutineScope(Dispatchers.Main).launch {
                             editSearch.clearFocus()
                             (requireContext().getSystemService(Service.INPUT_METHOD_SERVICE) as InputMethodManager).hideSoftInputFromWindow(editSearch.windowToken, 0)
                             onSearch(editSearch.text.toString())
                         }
                         return true
                     }
                     return false
                 }
             })

             editSearch.addTextChangedListener(object: TextWatcher {
                 override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                     val inputStr = p0 ?: return

                     if(inputStr.isNotEmpty()) {
                         editBoxDeleteBtn.setBackgroundResource(R.drawable.friend_search_edit_box_btn_delete)
                     }else {
                         editBoxDeleteBtn.setBackgroundResource(R.drawable.icon_search)
                     }
                 }
                 override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
                 override fun afterTextChanged(p0: Editable?) {}

             })

             actionUpMove.setOnClickListener {
                 actionUpMove.visibility = View.INVISIBLE
                 CoroutineScope(Dispatchers.Main).launch {
                     resultRecycle.smoothScrollToPosition(0)
                 }
             }

             if(Constants.is_FirebaseAnalytics) {
                 CoroutineScope(Dispatchers.Main).launch {
                     firebaseAnalyticsMember(FirebaseParam.mobile_seminasearch)
                 }
             }
         }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }

    private fun initData() = viewBinding.apply {

        viewModel.seminarList.observe(viewLifecycleOwner) { list ->

            mSeminarArrayList.apply {
                addAll(list.content)
            }

            if(mSeminarArrayList.isEmpty())  {
                resultRecycle.visibility = View.GONE
                emptyView.apply {
                    text = resources.getText(R.string.seminar_search_empty_message)
                    visibility = View.VISIBLE
                }
            }else {
                resultRecycle.visibility = View.VISIBLE

                emptyView.apply {
                    text = ""
                    visibility = View.GONE
                }
            }

            searchResult.text = resources.getString(R.string.search_result_count, mSeminarArrayList.size)
            mAdapter.notifyDataSetChanged()
        }

        resultRecycle.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                super.onScrollStateChanged(recyclerView, newState)
                viewBinding.apply {
                    if(!resultRecycle.canScrollVertically(-1) && newState == RecyclerView.SCROLL_STATE_IDLE) {
                        actionUpMove.visibility = View.INVISIBLE
                    }else {
                        actionUpMove.visibility = View.VISIBLE
                    }
                }
            }

            override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                super.onScrolled(recyclerView, dx, dy)
                val lastVisibleItemPosition = (recyclerView.layoutManager as LinearLayoutManager?)!!.findLastCompletelyVisibleItemPosition()
                val itemTotalCount = recyclerView.adapter!!.itemCount-1

                if(lastVisibleItemPosition == itemTotalCount ) {
                    CoroutineScope(Dispatchers.Main).launch {
                        val lastIndex = mSeminarArrayList.lastIndex
                        viewModel.apply {
                            seminarSearch(editSearch.text.toString(), lastIndex)
                        }
                    }
                }
            }

        })
    }


    override fun onClick(view: View) {
        when(view.id) {
            R.id.editBoxDeleteBtn -> {
                viewBinding.apply {
                    editSearch.setText("")
                }
            }
        }
    }


    private fun onSearch(searchWord: String) = try {
        viewModel.apply {
            mSeminarArrayList.clear()
            seminarSearch(searchWord)
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    /*
    inner class RecyclerViewAdapter : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = mSeminarArrayList.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = SeminarSearchListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val dataInfo = mSeminarArrayList!![position]
                holder.run {
                    bind(dataInfo)

                    itemView.setOnClickListener {
                        val seminarInfo = SeminarInfo(dataInfo.id, dataInfo.room.roomImageUrl)

                        val action = SeminarSearchFragmentDirections.actionSeminarSearchToDetailSeminar(seminarInfo)
                        findNavController().navigate(action)
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: SeminarSearchListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: Content) {
                with(viewBinding) {
                    Glide.with(root.context)
                            .load(item.room.roomImageUrl)
                            .transform(GranularRoundedCorners(32.0f, 32.0f, 32.0f, 32.0f))
                            .into(seminarImage)

                    Glide.with(root.context)
                            .load(item.teacherImageUrl)
                            .transform(CenterCrop(), RoundedCorners(16))
                            .into(imgTeacher)


                    seminarTitle.text   = item.title
                    seminarDesc.text    = item.description

                    seminarMaxCount.text = String.format("%d", item.maxEnterCount)
                    seminarCount.text = String.format("%d", item.currentParticipation)

                    when (item.status) {

                        SeminarStatus.CONFIRM -> {
                            seminarSituation.text = resources.getString(R.string.seminar_approve)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_appy_approve)
                        }

                        SeminarStatus.REJECT -> {
                            seminarSituation.text = resources.getString(R.string.seminar_reject)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_apply_reject)
                        }

                        SeminarStatus.START -> {
                            seminarSituation.text = resources.getString(R.string.status_now)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_now)

                            if(item.teacherId == repository.member.value!!.memberId) {
                                join.text = resources.getString(R.string.enter_comment)
                                join.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                            }else {
                                if (item.secretYn == "N") {
                                    join.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                } else {
                                    if (item.participationYn == "Y") {
                                        join.text = resources.getString(R.string.seminar_participate)
                                        join.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                    } else {
                                        join.text = resources.getString(R.string.seminar_apply)
                                        join.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                    }
                                }
                            }
                        }
                        SeminarStatus.END -> {
                            seminarSituation.text = resources.getString(R.string.status_end)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_end)

                            join.setBackgroundResource(R.drawable.common_corner_round_gray_02)

                        }

                        SeminarStatus.BEFORE_START -> {
                            seminarSituation.text = resources.getString(R.string.status_before)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_before)

                            join.apply {
                                setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                if(item.teacherId == repository.member.value!!.memberId) {
                                    join.text = resources.getString(R.string.enter_comment)
                                }else if(item.secretYn == Constants.YesValue) {
                                    if (item.participationYn == Constants.NoValue) {
                                        join.text = resources.getString(R.string.seminar_apply)
                                    } else {
                                        join.text = resources.getString(R.string.seminar_participate)
                                    }
                                }
                            }
                        }
                    }

                    iconLock.visibility = if(item.secretYn == Constants.YesValue) View.VISIBLE else View.INVISIBLE

                    val start = DateFormatter.instance.dateBarTimeFormatter().parse(item.startAt)
                    val end = DateFormatter.instance.dateBarTimeFormatter().parse(item.endAt)

                    seminarDate.text = resources.getString(R.string.seminar_date_format, DateFormatter.instance.yearDayFormatter().format(start),
                                                                                            DateFormatter.instance.dateTimeFormatter().format(end))

                    seminarMyCreateLayout.visibility = if(item.teacherId == repository.member.value!!.memberId) View.VISIBLE
                                                        else View.INVISIBLE

                    join.setOnClickListener {
                        if (repository.myAvatar.value!!.id == 0) {
                            CommonAlertDialog.Builder(requireContext())
                                .setCancelable(false)
                                .setMessage(R.string.avatar_select_message)
                                .setPositiveButton {}
                                .show()
                            return@setOnClickListener
                        }

                        repository.apply {
                            if(item.teacherId == repository.member.value!!.memberId) {
                                myCreateEnterSeminarRoom(item)
                            }else {
                                onJoinClick(item)
                            }
                        }
                    }
                }
            }
        }
    }
    */

    private fun myCreateEnterSeminarRoom(item: Content) = try {
        repository.apply {
            getRoomPassword(item.id).subscribeBy(onNext = { passwordResult ->
                Timber.tag(MainFragment.TAG).d("myCreateEnterSeminarRoom ${passwordResult.result!!.password}")

                if(passwordResult.resultCode == ApiResponse.RESULT_CODE_OK) {
                    val params = BaseParam(SeminarEnterParam(passwordResult.result!!.password)).parameter
                    setSeminarEnter(item.id, params).subscribeBy (onNext = {it ->
                        if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == "Y") {
                            enterSeminar(item!!, it.result!!)
                        } else {
                            CommonAlertDialog.Builder(this@SeminarSearchFragment.requireContext())
                                .setMessage(it.resultMessage.toString())
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                        }
                    })
                }else {
                    CommonAlertDialog.Builder(this@SeminarSearchFragment.requireContext())
                        .setMessage(passwordResult.resultMessage.toString())
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }
            })
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    private fun onJoinClick(item: Content) {

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


            when (item.status) {
                SeminarStatus.END -> {
                    CommonAlertDialog.Builder(requireContext())
                        .setMessage(R.string.seminar_end_message)
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }

                SeminarStatus.START -> {
                    if(item.secretYn == Constants.YesValue && item.participationYn == Constants.YesValue ) {
                        SeminarPasswordBottomDialogFragment(requireContext(), false).apply {
                            setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                            onClickListener = { data ->
                                if (data.toString().isEmpty()) {
                                    CommonAlertDialog.Builder(requireContext())
                                        .setMessage(R.string.password_input_hint)
                                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                                        .show()
                                } else {
                                    CommonAlertDialog.Builder(requireContext())
                                        .setMessage(R.string.seminar_enter_ask_message)
                                        .setNegativeButton(R.string.seminar_apply_cancel) {}
                                        .setPositiveButton(R.string.seminar_cancel_yes) {
                                            val params = BaseParam(SeminarEnterParam(data.toString())).parameter
                                            repository.apply {
                                                setSeminarEnter(item.id, params).subscribeBy(onNext = {it->
                                                    if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == "Y") {
                                                        enterSeminar(item, it.result!!)
                                                    } else {
                                                        CommonAlertDialog.Builder(this@SeminarSearchFragment.requireContext())
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
                            show(this@SeminarSearchFragment.childFragmentManager, Constants.SeminarPasswordBottomDialogFragmentTag)
                        }
                    }else {
                        if(item.secretYn == Constants.YesValue && item.participationYn == Constants.NoValue) {
                            CommonAlertDialog.Builder(requireContext())
                                .setMessage(R.string.seminar_live_not_allow)
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                        }else {
                            CommonAlertDialog.Builder(requireContext())
                                .setMessage(R.string.seminar_enter_ask_message)
                                .setNegativeButton(R.string.seminar_apply_cancel) {}
                                .setPositiveButton(R.string.seminar_cancel_yes) {
                                    Timber.tag(SeminarMainFragment.TAG).d("id  = $id")
                                    val params = BaseParam(SeminarEnterParam("")).parameter
                                    repository.apply {
                                        setSeminarEnter(item.id, params).subscribeBy(onNext = { it ->
                                            if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == "Y") {
                                                enterSeminar(item, it.result!!)
                                            } else {
                                                CommonAlertDialog.Builder(this@SeminarSearchFragment.requireContext())
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
                            CommonAlertDialog.Builder(requireContext())
                                .setMessage(R.string.seminar_secret_before_message)
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                        }else {
                            CommonAlertDialog.Builder(requireContext())
                                .setMessage(R.string.seminar_participate_message)
                                .setNegativeButton(R.string.seminar_apply_cancel) {}
                                .setPositiveButton(R.string.seminar_cancel_yes) {
                                    repository.setParticipate(item.id)
                                        .subscribeBy(onNext = {
                                            if (it.result!!.isSucceed) {
                                                SeminarAlertDialog.Builder(this@SeminarSearchFragment.requireContext())
                                                    .setCancelable(false)
                                                    .setTitle(R.string.secret_seminar_apply_success_message)
                                                    .setMessage(R.string.secret_seminar_apply_success_message_detail)
                                                    .setPositiveButton(R.string.system_alert_btn_ok) {
                                                        findNavController().popBackStack()
                                                    }
                                                    .show()
                                            }else {
                                                CommonAlertDialog.Builder(this@SeminarSearchFragment.requireContext())
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

        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }

    private fun enterSeminar(item: Content, result : SeminarEnterResult) = try {

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

            val action = SeminarSearchFragmentDirections.actionSeminarSearchToTorymetaWorld(infoData)
            findNavController().navigate(action)
        }
    }catch (e : Exception) {
        Timber.d(e.message)
    }

}