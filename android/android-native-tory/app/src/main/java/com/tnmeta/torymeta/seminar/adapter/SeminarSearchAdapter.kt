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
import com.tnmeta.torymeta.api.ToryRepository
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.databinding.SeminarSearchListItemBinding
import com.tnmeta.torymeta.seminar.model.seminar.Content
import com.tnmeta.torymeta.utils.DateFormatter
import timber.log.Timber

class SeminarSearchAdapter(private val repository: ToryRepository,
                           private val items : List<Content>,
                           val onItemClick: (Content) -> Unit,
                           val onItemButtonClick : (Content) -> Unit): RecyclerView.Adapter<SeminarSearchAdapter.RecycleViewHolder>() {

    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = RecycleViewHolder (
        SeminarSearchListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: SeminarSearchAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = items!![position]
            holder.run {
                bind(dataInfo)

                itemView.setOnClickListener {
                    onItemClick(dataInfo)
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

                itemView.context.apply {
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
                                if (item.secretYn == Constants.NoValue) {
                                    join.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                } else {
                                    if (item.participationYn == Constants.YesValue) {
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

                    seminarDate.text = resources.getString(
                        R.string.seminar_date_format, DateFormatter.instance.yearDayFormatter().format(start),
                        DateFormatter.instance.dateTimeFormatter().format(end))

                    seminarMyCreateLayout.visibility = if(item.teacherId == repository.member.value!!.memberId) View.VISIBLE
                                                        else View.INVISIBLE
                }

                join.setOnClickListener {
                    onItemButtonClick(item)
                }
            }
        }
    }

}