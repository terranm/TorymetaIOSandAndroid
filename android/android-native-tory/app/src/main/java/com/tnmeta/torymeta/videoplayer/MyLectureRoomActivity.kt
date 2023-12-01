package com.tnmeta.torymeta.videoplayer

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.databinding.ActivityMyLectureRoomBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.isVisible
import com.tnmeta.torymeta.videoplayer.adapter.MyLectureInfoAdapter
import com.tnmeta.torymeta.videoplayer.model.LectureInfo
import com.tnmeta.torymeta.videoplayer.model.param.OffsetParam
import com.tnmeta.torymeta.videoplayer.viewmodel.MyLectureRoomViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class MyLectureRoomActivity : BaseActivity(), View.OnClickListener {
    companion object {
        val TAG: String = MyLectureRoomActivity::class.java.simpleName

        fun createIntent(context: Context): Intent {
            return Intent(context, MyLectureRoomActivity::class.java)
        }
    }

    private val viewBinding by viewBinding(ActivityMyLectureRoomBinding::inflate)
    private lateinit var viewModel: MyLectureRoomViewModel
    private lateinit var mMyLectureAdapter : MyLectureInfoAdapter

    private val mLectureInfoArray = ArrayList<LectureInfo>()


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {

                setContentView(root)
                viewModel = ViewModelProvider(this@MyLectureRoomActivity)[MyLectureRoomViewModel::class.java]

                mLectureInfoArray.clear()
                initData()

                refreshLayout.setOnRefreshListener {
                    CoroutineScope(Dispatchers.Main).launch {
                        viewModel.apply {
                            mLectureInfoArray.clear()
                            getLectureInfo(mLectureInfoArray.size)
                        }
                    }
                    refreshLayout.isRefreshing = false
                    viewBinding.loadingProgress.visibility = View.VISIBLE
                }

                getLectureInfo(mLectureInfoArray.size)
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }

    }

    override fun onResume() {
        super.onResume()
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.ivBack -> finish()
        }
    }

    private fun getLectureInfo(offset : Int) = try {
        viewModel.apply {
            viewBinding.loadingProgress.visibility = View.VISIBLE
            val param = BaseParam(OffsetParam(offset = offset)).parameter
            getLecture(param)
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun initData() = viewBinding.apply {
        mMyLectureAdapter = MyLectureInfoAdapter(
            items = mLectureInfoArray,
            onItemViewClick = { info ->
                if(viewBinding.loadingProgress.isVisible())
                    return@MyLectureInfoAdapter

                Intent(this@MyLectureRoomActivity, VideoPlayerActivity::class.java).run {
                    putExtra(Params.LECTUREINFO, info)
                    startActivity(this)
                }
            }
        )

        recyclerView.apply {
            layoutManager = LinearLayoutManager(this@MyLectureRoomActivity)
            adapter = mMyLectureAdapter
        }

        viewModel.lectureList.observe(this@MyLectureRoomActivity) { list ->

            mLectureInfoArray.apply {
                if(list.isNotEmpty()) {
                    addAll(list)
                }
            }

            mMyLectureAdapter.apply {
                notifyDataSetChanged()
            }

            loadingProgress.visibility = View.GONE
        }


        recyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                super.onScrolled(recyclerView, dx, dy)
                val lastVisibleItemPosition = (recyclerView.layoutManager as LinearLayoutManager?)!!.findLastCompletelyVisibleItemPosition()
                val itemTotalCount = recyclerView.adapter!!.itemCount-1

                if(lastVisibleItemPosition == itemTotalCount ) {
                    CoroutineScope(Dispatchers.Main).launch {
                        viewModel.apply {
                            getLectureInfo(mLectureInfoArray.size)
                        }
                    }
                }
            }
        })
    }

}