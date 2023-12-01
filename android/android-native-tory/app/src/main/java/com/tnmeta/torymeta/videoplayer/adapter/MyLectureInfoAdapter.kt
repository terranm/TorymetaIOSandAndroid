package com.tnmeta.torymeta.videoplayer.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.MyLectureListItemBinding
import com.tnmeta.torymeta.videoplayer.model.LectureInfo
import timber.log.Timber
import java.text.DecimalFormat

class MyLectureInfoAdapter(private val items : List<LectureInfo>,
                           val onItemViewClick : (LectureInfo) -> Unit) :  RecyclerView.Adapter<MyLectureInfoAdapter.RecycleViewHolder>(){
    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =  RecycleViewHolder (
        MyLectureListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: MyLectureInfoAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = items!![position]
            holder.run {
                bind(dataInfo, position)
                itemView.setOnClickListener {
                    onItemViewClick(dataInfo)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: MyLectureListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        @SuppressLint("StringFormatInvalid")
        fun bind(item: LectureInfo, position: Int) = try {
            with(viewBinding) {
                item.run {
                    lectureTitle.text = subject
                    lectureDate.text = String.format("%s ~ %s", item.start, item.end)
                    txtTotalProcess.text = String.format("%s %d%%", itemView.resources.getString(R.string.attendance_rate), totalProcess)

                    currentProgressBar.progress = totalProcess

                    val resource = when(item.cat) {
                        "저자직강" -> R.drawable.background_lecture_purple
                        "영상강의" -> R.drawable.background_lecture_yellow
                        "실시간줌강의" -> R.drawable.background_lecture_red
                        "특강" -> R.drawable.background_lecture_blue
                        else -> R.drawable.background_lecture_purple
                    }

                    info.setBackgroundResource(resource)
                    info.text = item.cat
                }
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }
}