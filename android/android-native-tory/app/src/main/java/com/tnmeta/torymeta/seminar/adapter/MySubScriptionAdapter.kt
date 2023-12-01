package com.tnmeta.torymeta.seminar.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.GranularRoundedCorners
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.databinding.MySubscriptItemListBinding
import com.tnmeta.torymeta.seminar.model.seminar.Content
import com.tnmeta.torymeta.utils.DateFormatter
import timber.log.Timber

class MySubScriptionAdapter(private val items : List<Content>,
                            val onItemClick: (Content) -> Unit,
                            val onItemButtonClick : (View, Content) -> Unit) : RecyclerView.Adapter<MySubScriptionAdapter.RecycleViewHolder>() {

    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = RecycleViewHolder (
        MySubscriptItemListBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: MySubScriptionAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = items!![position]
            holder.run {
                bind(dataInfo)

                itemView.setOnClickListener {
                    Timber.d("SeminarRecyclerViewAdapter + itemView")
                    onItemClick(dataInfo)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: MySubscriptItemListBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: Content) {
            with(viewBinding) {
                item.run {
                    Glide.with(root.context)
                        .load(room.roomImageUrl)
                        .transform(GranularRoundedCorners(40.0f, 40.0f, 0.0f, 0.0f))
                        .into(seminarImage)

                    seminarTitle.text = title
                    seminarDesc.text = description
                    //seminarMaxCount.text = String.format("%d명", maxEnterCount)

                    seminarMaxCount.text = itemView.context.getString(R.string.people_total_count_text, "$maxEnterCount")
                    seminarCount.text = String.format("%d", requestParticipation)

                    val start = DateFormatter.instance.dateBarTimeFormatter().parse(startAt)
                    val end = DateFormatter.instance.dateBarTimeFormatter().parse(endAt)

                    itemView.context.apply {
                        seminarDate.text = resources.getString(
                            R.string.seminar_date_format,
                            DateFormatter.instance.yearDayfullFormatter().format(start),
                            DateFormatter.instance.hourTimeFormatter().format(end))

                        txtEnter.text = resources.getString(R.string.seminar_enter)

                        when (status) {
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
                            }

                            SeminarStatus.END -> {
                                seminarSituation.text = resources.getString(R.string.status_end)
                                seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_end)

                                txtEnter.text = resources.getString(R.string.seminar_status_end)
                                seminarEnter.setBackgroundResource(R.drawable.common_round_enter_grey)
                            }

                            SeminarStatus.BEFORE_START -> {
                                seminarSituation.text = resources.getString(R.string.seminar_before)
                                seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_before)

                                txtEnter.text = resources.getString(R.string.seminar_participate)
                                seminarEnter.setBackgroundResource(R.drawable.common_round_enter_grey)
                            }
                        }
                    }

                    iconLock.visibility = if(item.secretYn == Constants.NoValue) View.GONE else View.VISIBLE

                    Glide.with(root.context)
                        .load(teacherImageUrl)
                        .transform(CenterCrop(), RoundedCorners(16))
                        .into(imgTeacher)

                    detailView.setOnClickListener {
                        onItemButtonClick(detailView, item)
                    }

                    seminarEnter.setOnClickListener {
                        onItemButtonClick(seminarEnter, item)
                    }
                }
            }
        }
    }
}