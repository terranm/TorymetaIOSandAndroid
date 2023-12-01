package com.tnmeta.torymeta.seminar.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.TodaySerminarListItemBinding
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.utils.DateFormatter
import timber.log.Timber

class SeminarScheduleAdapter(private val items: List<SeminarDto>,
                             val itemViewClick: (SeminarDto) -> Unit ) : RecyclerView.Adapter<SeminarScheduleAdapter.RecycleViewHolder>(){

    private var dateCount = 0

    fun setDateCount(dateCount : Int) {
        this.dateCount = dateCount
    }

    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = RecycleViewHolder (
        TodaySerminarListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: SeminarScheduleAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = items!![position]
            holder.run {
                bind(dataInfo)
                itemView.setOnClickListener {
                    itemViewClick(dataInfo)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: TodaySerminarListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: SeminarDto) {
            with(viewBinding) {
                item.run {

                    val image = if(dateCount < 0) {
                        R.drawable.schedule_state_02
                    }else if(dateCount == 0) {
                        R.drawable.schedule_state_01
                    }else if(dateCount > 0) {
                        R.drawable.schedule_state_03
                    }else {
                        R.drawable.schedule_state_01
                    }

                    imgStart.setBackgroundResource(image)

                    seminarTitle.text = title
                    seminarTeacher.text = teacherName

                    val start = DateFormatter.instance.dateBarTimeFormatter().parse(startAt)
                    val end = DateFormatter.instance.dateBarTimeFormatter().parse(endAt)
                    seminarDate.text = String.format("%s - %s",
                                                        DateFormatter.instance.dateTimeFormatter().format(start),
                                                        DateFormatter.instance.dateTimeFormatter().format(end))
                }
            }
        }
    }

}