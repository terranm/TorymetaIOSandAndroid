package com.tnmeta.torymeta.chattinglounge


import android.annotation.SuppressLint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.chattinglounge.dialog.ChattingPasswordDialog
import com.tnmeta.torymeta.chattinglounge.model.ChattingLoungeViewModel
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import com.tnmeta.torymeta.chattinglounge.model.ChattingSortType
import com.tnmeta.torymeta.chattinglounge.model.param.ChattingRoomListParam
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.databinding.ChattingLoungeListItemBinding
import com.tnmeta.torymeta.databinding.ChattingLoungeRoomListItemBinding
import com.tnmeta.torymeta.databinding.FragmentChattingLoungeBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.main.MainFragmentDirections
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarModelingDTO
import com.tnmeta.torymeta.model.unity.VideoUrl
import com.tnmeta.torymeta.seminar.model.SortType
import com.tnmeta.torymeta.seminar.model.ToryLoungeInfo
import com.tnmeta.torymeta.ui.CommonAlertDialog
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


/**
 * ChattingLoungeFragment
 */
class ChattingLoungeFragment : BaseFragment(), View.OnClickListener {
    companion object {
        val TAG : String = ChattingLoungeFragment::class.java.simpleName

        fun newInstance() =
            ChattingLoungeFragment().apply {}
    }

    private var _viewBinding: FragmentChattingLoungeBinding? = null
    private val viewBinding get() = _viewBinding!!

    private lateinit var viewModel: ChattingLoungeViewModel
    private lateinit var mChattingAdapter : ChattingRecyclerViewAdapter

    private val mChattingArrayList = ArrayList<ChattingRoom>()
    private var mSortType = ChattingSortType.All

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentChattingLoungeBinding.inflate(inflater, container, false)
        viewModel = ViewModelProvider(this@ChattingLoungeFragment)[ChattingLoungeViewModel::class.java]

        return viewBinding.root
    }

    /**
     * onViewCreated
     *
     * @param view
     * @param savedInstanceState
     */
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        try {
            viewBinding.apply {
                ivBack.setOnClickListener {
                    findNavController().popBackStack()
                }

                initList()

                refreshLayout.setOnRefreshListener {
                    CoroutineScope(Dispatchers.Main).launch {
                        viewModel.apply {
                            val params = BaseParam(ChattingRoomListParam(Constants.ChatLounge, 30)).parameter
                            getChattingList(params)
                        }
                    }
                    refreshLayout.isRefreshing = false
                }

                arrayOf(toryLounge,actionUpMove,
                        filterAllLayout, filterOpenLayout, filterPrivateLayout).forEach {
                    it.setOnClickListener(this@ChattingLoungeFragment)
                }

                chattingRecyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
                    override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                        super.onScrollStateChanged(recyclerView, newState)
                        viewBinding.apply {
                            if(mChattingArrayList.size >= 2) {
                                actionUpMove.visibility = if (!chattingRecyclerView.canScrollVertically(-1) && newState == RecyclerView.SCROLL_STATE_IDLE) {
                                    View.INVISIBLE
                                } else {
                                    View.VISIBLE
                                }
                            }
                        }
                    }
                })

            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onResume() {
        super.onResume()
        try {
            viewModel.apply {
                val params = BaseParam(ChattingRoomListParam(Constants.ChatLounge, 30)).parameter
                getChattingList(params)
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


    override fun onPause() {
        super.onPause()
    }


    /**
     * initList
     *
     */
    private fun initList() {
        viewBinding.apply {
            mChattingAdapter = ChattingRecyclerViewAdapter()
            chattingRecyclerView.apply {
                layoutManager = LinearLayoutManager(requireContext())
                setDivider(R.drawable.menu_view_divider)
                adapter = mChattingAdapter
            }

            viewModel.apply {
                liveChattingList.observe(viewLifecycleOwner) {list ->
                    mChattingArrayList.apply {
                        clear()
                        addAll(list)
                        sortWith(
                            compareBy<ChattingRoom> {
                                it.createdAt
                            }.reversed()
                        )
                    }

                    if(mChattingArrayList.isEmpty()) {
                        emptyView.visibility = View.VISIBLE
                        chattingRecyclerView.visibility = View.GONE
                    }else {
                        emptyView.visibility = View.GONE
                        chattingRecyclerView.visibility = View.VISIBLE
                    }

                    mChattingAdapter.notifyDataSetChanged()
                }
            }
        }
    }


    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }


    override fun onClick(view: View) {
        when(view.id) {
            R.id.tory_lounge -> {
                //if(repository.myAvatar.value!!.id == 0) {
                if(repository.hasAvatarAttrYn == Constants.NoValue){
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(R.string.avatar_make_message)
                        .setPositiveButton {}
                        .show()
                    return
                }

                repository.apply {
                    val params = BaseParam(VideoUrl(
                                loungeType = "LOUNGE",
                                mediaType = "mp4")).parameter

                    getVideoUrl(json = params).subscribeBy(onNext = {
                        CoroutineScope(Dispatchers.Main).launch {

                            val infoData = enterToryLounge(
                                item = ToryLoungeInfo(videoUrl = it.videoUrl)
                            )

                            Timber.tag(MainFragment.TAG).d("tory_lounge $infoData")

                            val action = ChattingLoungeFragmentDirections.actionMainToTorymetaWorld(infoData)
                            findNavController().navigate(action)

                        }
                    }, onError = {})
                }
            }

            R.id.filter_all_layout -> initSortButton(ChattingSortType.All)
            R.id.filter_open_layout -> initSortButton(ChattingSortType.Open)
            R.id.filter_private_layout -> initSortButton(ChattingSortType.Private)

            R.id.actionUpMove -> {
                viewBinding.apply {
                    actionUpMove.visibility = View.INVISIBLE
                    CoroutineScope(Dispatchers.Main).launch {
                        chattingRecyclerView.smoothScrollToPosition(0)
                    }
                }
            }
        }
    }


    /**
     * ChattingRecyclerViewAdapter
     */
    inner class ChattingRecyclerViewAdapter : RecyclerView.Adapter<ChattingRecyclerViewAdapter.RecycleViewHolder>() {

        override fun getItemCount(): Int  {
            return when(mSortType) {
                ChattingSortType.All         -> mChattingArrayList.size
                ChattingSortType.Available   -> mChattingArrayList.filter { !it.locked }.size
                ChattingSortType.Lock        -> mChattingArrayList.filter { it.locked }.size
                ChattingSortType.Open        -> mChattingArrayList.filter { !it.privateRoom }.size
                ChattingSortType.Private     -> mChattingArrayList.filter { it.privateRoom }.size
            }
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ChattingRecyclerViewAdapter.RecycleViewHolder {
            val binding = ChattingLoungeRoomListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: ChattingRecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val dataInfo = when (mSortType) {
                    ChattingSortType.All        -> mChattingArrayList[position]
                    ChattingSortType.Available  -> mChattingArrayList.filter { !it.locked }[position]
                    ChattingSortType.Lock       -> mChattingArrayList.filter { it.locked }[position]
                    ChattingSortType.Open       -> mChattingArrayList.filter { !it.privateRoom }[position]
                    ChattingSortType.Private    -> mChattingArrayList.filter { it.privateRoom }[position]
                }

                holder.run {
                    bind(dataInfo)
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: ChattingLoungeRoomListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: ChattingRoom) {
                with(viewBinding) {
                    item.run {
                        chattingTitle.text = title
                        chattingCreator.text = creatorName

                        lock.visibility = if(privateRoom) View.VISIBLE
                                            else View.GONE

                        headCount.text = String.format("%d/%d", clients, maxClients)

                        val imageUrl = image
                        Glide.with(root.context)
                            .load(imageUrl)
                            .transform(CenterCrop(), RoundedCorners(16))
                            .into(profile)

                        enter.isEnabled = if(clients < maxClients && !locked) {
                            enter.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                            true
                        }else {
                            enter.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                            false
                        }

                        enter.setOnClickListener {
                            onEnterChattingLounge(item = item)
                        }
                    }
                }
            }
        }
    }


    /**
     * onEnterChattingLounge
     * @param item
     */
    private fun onEnterChattingLounge(item: ChattingRoom) = try {

        if(item.privateRoom) {
            ChattingPasswordDialog.Builder(requireContext(), item.password).apply {
                setOnEnterClick {
                    CoroutineScope(Dispatchers.Main).launch {

                        val infoData = enterChattingRoom(item.tableId)

                        Timber.tag(MainFragment.TAG).d("tory_lounge $infoData")

                        val action = ChattingLoungeFragmentDirections.actionMainToTorymetaWorld(infoData)
                        findNavController().navigate(action)
                    }
                }
                show()
            }

        }else {
            CoroutineScope(Dispatchers.Main).launch {
                val infoData = enterChattingRoom(item.tableId)
                Timber.tag(MainFragment.TAG).d("tory_lounge $infoData")

                val action = ChattingLoungeFragmentDirections.actionMainToTorymetaWorld(infoData)
                findNavController().navigate(action)
            }
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun initSortButton(type : ChattingSortType) = try {

        mSortType = type

        viewBinding.apply {
            val layoutArray = arrayOf(filterAllLayout, filterPossibleLayout, filterImpassibleLayout, filterOpenLayout, filterPrivateLayout)
            layoutArray.forEach {
                it.setBackgroundResource(R.drawable.common_corner_circle_stroke_gray_04)
            }

            val textArray = arrayOf(filterAll, filterPassible, filterImpassible, filterOpen, filterPrivate)
            textArray.forEach {
                it.setTextColor(ContextCompat.getColor(requireContext(),  R.color.tory_gray_04))
            }

            layoutArray[type.ordinal].setBackgroundResource(R.drawable.common_corner_round_stroke_purple_02)
            textArray[type.ordinal].setTextColor(ContextCompat.getColor(requireContext(),  R.color.tory_purple))

            if(mChattingArrayList.isNotEmpty()) {
                mChattingAdapter.apply {
                    notifyDataSetChanged()
                }
            }
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }


}