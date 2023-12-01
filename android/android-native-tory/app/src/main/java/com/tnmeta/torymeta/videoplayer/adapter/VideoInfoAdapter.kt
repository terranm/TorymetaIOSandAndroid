package com.tnmeta.torymeta.videoplayer.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.LectureVideoListItemBinding
import com.tnmeta.torymeta.videoplayer.model.LectureVideoInfo
import timber.log.Timber

class VideoInfoAdapter(private val items : List<LectureVideoInfo>,
                       val onItemViewClick : (LectureVideoInfo, Int) -> Unit,
                       private var selectedPosition : Int) :  RecyclerView.Adapter<VideoInfoAdapter.RecycleViewHolder>(){

    fun setSelectPosition(position: Int) {
        this.selectedPosition = position
    }

    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =  RecycleViewHolder (
        LectureVideoListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: VideoInfoAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val itemValue = items!![position]
            holder.run {
                bind(itemValue, position)
                itemView.setOnClickListener {
                    if(selectedPosition == position)
                        return@setOnClickListener

                    val prevPosition = selectedPosition
                    itemValue.isSelect = !itemValue.isSelect
                    selectedPosition = position
                    notifyItemChanged(selectedPosition)

                    if (prevPosition != -1 && selectedPosition != prevPosition) {
                        val itemInfo = items!![prevPosition]
                        itemInfo.isSelect = false
                        notifyItemChanged(prevPosition)
                    }

                    onItemViewClick(itemValue, position)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: LectureVideoListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: LectureVideoInfo, position: Int) {
            with(viewBinding) {
                item.run {
                    lectureTitle.text = item.title
                    txtAttendance.text = String.format("%s %d%%", itemView.resources.getString(R.string.progress_rate), process)
                    currentProgressBar.progress = process

                    val imageResource = if (item.isSelect) R.drawable.select_video_item_background
                                            else R.drawable.unselect_video_item_background

                    listItem.setBackgroundResource(imageResource)


                }
            }
        }
    }
}