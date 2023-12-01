package com.tnmeta.torymeta.seminar.myseminar

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.GranularRoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.databinding.FragmentMyOpenedBinding
import com.tnmeta.torymeta.databinding.MyOpenSeminarItemListBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.meta.Member
import com.tnmeta.torymeta.model.meta.MetaVerseDto
import com.tnmeta.torymeta.model.meta.Options
import com.tnmeta.torymeta.model.param.SeminarEnterParam
import com.tnmeta.torymeta.model.result.ApiResponse
import com.tnmeta.torymeta.seminar.ModifySeminarActivity
import com.tnmeta.torymeta.seminar.adapter.MyOpenedAdapter
import com.tnmeta.torymeta.seminar.model.SeminarEnterInfo
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.viewmodel.MyCreateViewModel
import com.tnmeta.torymeta.seminar.model.seminar.Content
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.DecimalFormat

class MyOpenedFragment : BaseFragment() {
    companion object {
        val TAG : String = MyOpenedFragment::class.java.simpleName
    }

    private var _viewBinding: FragmentMyOpenedBinding? = null
    private val viewBinding get() = _viewBinding!!

    //private lateinit var mAdapter : RecyclerViewAdapter
    private lateinit var mAdapter : MyOpenedAdapter
    private lateinit var viewModel: MyCreateViewModel
    private val mSeminarArrayList = ArrayList<Content>()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentMyOpenedBinding.inflate(inflater, container, false)
        viewBinding.apply {
            viewModel = ViewModelProvider(this@MyOpenedFragment)[MyCreateViewModel::class.java]
        }
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {

            initList()

            actionUpMove.setOnClickListener {
                actionUpMove.visibility = View.INVISIBLE
                CoroutineScope(Dispatchers.Main).launch {
                    seminarListView.smoothScrollToPosition(0)
                }
            }
        }

        if(Constants.is_FirebaseAnalytics) {
            CoroutineScope(Dispatchers.Main).launch {
                firebaseAnalyticsMember(FirebaseParam.mobile_mysemina_set)
            }
        }

    }

    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }

    private fun initList()  = viewBinding.apply {
        mAdapter = MyOpenedAdapter(
            items = mSeminarArrayList,
            onItemClick = {},
            onItemButtonClick = {view, item, position ->
                when(view.id) {
                    R.id.icon_delete -> {
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(R.string.seminar_delete_message)
                            .setNegativeButton(R.string.seminar_apply_cancel) {}
                            .setPositiveButton(R.string.seminar_cancel_yes) {
                                deleteSeminar(position, item.id)
                            }
                            .show()
                    }
                    R.id.modify -> {
                        onModifyActivityResult.launch(
                            Intent(requireContext(), ModifySeminarActivity::class.java)
                                .putExtra(Params.SEMINAR_ID, item.id)
                        )
                    }

                    R.id.seminar_enter -> {
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(R.string.seminar_enter_ask_message)
                            .setNegativeButton(R.string.seminar_apply_cancel) {}
                            .setPositiveButton(R.string.seminar_cancel_yes) {
                                val params = BaseParam(SeminarEnterParam(item.password)).parameter
                                repository.apply {
                                    Timber.tag(MyOpenedFragment.TAG).d("${item.id} param $params")
                                    setSeminarEnter(item.id, params).subscribeBy(onNext = { it->
                                        if(it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                                            enterSeminarRoom(item , it.result!!)
                                        }else {
                                            CommonAlertDialog.Builder(this@MyOpenedFragment.requireContext())
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
                            .show()
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

                if(mSeminarArrayList.size > 0) {
                    val lastVisibleItemPosition = (recyclerView.layoutManager as LinearLayoutManager?)!!.findLastCompletelyVisibleItemPosition()
                    val itemTotalCount = recyclerView.adapter!!.itemCount - 1
                    if (lastVisibleItemPosition == itemTotalCount) {
                        CoroutineScope(Dispatchers.Main).launch {
                            val lastIndex = mSeminarArrayList.lastIndex
                            viewModel.apply {
                                getCreateSeminar(mSeminarArrayList[lastIndex].id)
                            }
                        }
                    }
                }
            }
        })

        viewModel.apply {
            mSeminarArrayList.clear()
            getCreateSeminar()

            seminarList.observe(viewLifecycleOwner) { list ->
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
                    //myOpenCount.text = String.format("전체 %s", DecimalFormat("#,###").format(mSeminarArrayList.size))
                    myOpenCount.text = requireContext().getString(R.string.total_count_text, "${DecimalFormat("#,###").format(mSeminarArrayList.size)}")

                }

                mAdapter.notifyDataSetChanged()
            }
        }
    }


    private fun deleteSeminar(position : Int, id : Int) = viewBinding.apply {
        CoroutineScope(Dispatchers.Main).launch {
            viewModel.apply {
                deleteMySeminar(id)
                    .subscribeBy(onNext = {
                        try {
                            if (it.isSucceed) {
                                CommonAlertDialog.Builder(requireContext())
                                    .setMessage(R.string.seminar_delete_complete_message)
                                    .setPositiveButton {
                                        mSeminarArrayList.removeAt(position)

                                        if (mSeminarArrayList.isEmpty()) {
                                            emptyView.visibility = View.VISIBLE
                                            seminarListView.visibility = View.GONE
                                        } else {
                                            emptyView.visibility = View.GONE
                                            seminarListView.visibility = View.VISIBLE
                                        }

                                        myOpenCount.text = requireContext().getString(R.string.total_count_text, "${DecimalFormat("#,###").format(mSeminarArrayList.size)}")

                                        //mAdapter.notifyDataSetChanged()
                                        mAdapter.notifyItemChanged(position)
                                    }
                                    .show()
                            }
                        }catch (e : Exception){
                            Timber.d(e.message)
                        }
                    }, onError = {})
            }
        }
    }


    private fun enterSeminarRoom(item : Content, result : SeminarEnterResult)  {
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

                Timber.tag(TAG).d("enterSeminarRoom $infoData")
                val action = MyOpenedFragmentDirections.actionMySeminarToToryWorld(infoData)
                findNavController().navigate(action)
            }
        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }


    private val onModifyActivityResult: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == AppCompatActivity.RESULT_OK) {
            mSeminarArrayList.clear()
            viewModel.getCreateSeminar()
        }
    }


}