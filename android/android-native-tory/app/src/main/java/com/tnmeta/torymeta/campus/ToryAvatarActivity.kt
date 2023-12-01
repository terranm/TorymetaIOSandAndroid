package com.tnmeta.torymeta.campus

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Size
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.core.view.size
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.Api
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.campus.list.AvatarListAdapter
import com.tnmeta.torymeta.campus.list.NoticeAdapter
import com.tnmeta.torymeta.campus.ui.BoardSelectView
import com.tnmeta.torymeta.campus.viewmodel.AvatarViewModel
import com.tnmeta.torymeta.campus.viewmodel.CampusViewModel
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityToryAvatarBinding
import com.tnmeta.torymeta.databinding.AvatarListItemBinding
import com.tnmeta.torymeta.databinding.CampusBoardSelectItemBinding
import com.tnmeta.torymeta.databinding.PeriodListItemBinding
import com.tnmeta.torymeta.model.PointFilter
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.dto.BBSNoticeDTO
import com.tnmeta.torymeta.model.dto.BoardDTO
import com.tnmeta.torymeta.model.dto.myAvatar.WholeModelDTO
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setItemPadding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber

class ToryAvatarActivity : BaseActivity(TransitionModeType.SLIDE_UP_IN), View.OnClickListener {

    companion object {
        val TAG : String = ToryAvatarActivity::class.java.simpleName
        fun createIntent(context: Context): Intent {
            return Intent(context, ToryAvatarActivity::class.java)
        }

        private const val LIST_SPAN_COUNT = 4
    }

    private val viewBinding by viewBinding(ActivityToryAvatarBinding::inflate)

    private lateinit var viewModel: AvatarViewModel
    private val avatarArrayList = ArrayList<WholeModelDTO>()
    private lateinit var mAdapter: RecyclerViewAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)
            imgClose.visibility = View.GONE
            viewModel = ViewModelProvider(this@ToryAvatarActivity)[AvatarViewModel::class.java]
            initAvatarList()
        }
    }

    private fun initAvatarList() = viewBinding.apply{
        //mAdapter = AvatarListAdapter(avatarArrayList)
        mAdapter = RecyclerViewAdapter()
        avatarList.apply {
            layoutManager = GridLayoutManager(this@ToryAvatarActivity, LIST_SPAN_COUNT)
            adapter = mAdapter
        }

        viewModel.apply {
            avatarList.observe(this@ToryAvatarActivity) {data ->
                Timber.d(" observe " + data.size)
                avatarArrayList.apply {
                    clear()
                    avatarArrayList.addAll(data)
                }
                mAdapter.notifyDataSetChanged()
            }
        }
    }

    override fun onResume() {
        super.onResume()

        viewModel.apply {
          getWholeModelingAvatar()
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.imgClose -> {
                finish()
            }
        }
    }

    private var selectedPosition = -1

    inner class RecyclerViewAdapter : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = avatarArrayList.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = AvatarListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val itemValue = avatarArrayList!![position]
                holder.run {
                    bind(itemValue)
                    itemView.setOnClickListener {
                        val prevPosition = selectedPosition
                        itemValue.isSelect = !itemValue.isSelect
                        selectedPosition = position
                        notifyItemChanged(selectedPosition)

                        selectAvatar(itemValue)

                        if (prevPosition != -1 && selectedPosition != prevPosition) {
                            val itemInfo = avatarArrayList!![prevPosition]
                            itemInfo.isSelect = false
                            notifyItemChanged(prevPosition)
                        }
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: AvatarListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: WholeModelDTO) {
                with(viewBinding) {
                    item.run {
                        val imageResouce = if (item.isSelect) R.drawable.avatar_select_background
                                            else R.drawable.avatar_background
                        avatarLayout.setBackgroundResource(imageResouce)

                        val url = Api.ImageUrl.BASE + "/" + Api.ImageUrl.AVATAR_WHOLE_MODELING + "/" +
                                                String.format("%s_%d.png", item.groupCode, item.id)

                        Glide.with(root)
                            .load(url)
                            .centerCrop()
                            .into(viewBinding.avatar)

                    }
                }
            }
        }
    }

    private fun selectAvatar(item: WholeModelDTO) {

    }

}