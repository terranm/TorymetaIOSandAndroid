package com.tnmeta.torymeta.main.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.ToryRepository
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.databinding.MainLiveSeminarListItemBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.utils.DateFormatter
import com.tnmeta.torymeta.utils.DiffUtil
import com.tnmeta.torymeta.utils.Utilts
import timber.log.Timber


class LiveSeminarAdapter(val repository: ToryRepository,
                         val onItemClick: (SeminarDto) -> Unit,
                         val onItemButtonClick : (SeminarDto, Int) -> Unit) : ListAdapter<SeminarDto, LiveSeminarAdapter.RecycleViewHolder>(DiffUtil.instance.seminarDtoDiffUtil){

    fun replaceItems(items: List<SeminarDto>) {
        submitList(items)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =  RecycleViewHolder (
        MainLiveSeminarListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )


    override fun onBindViewHolder(holder: LiveSeminarAdapter.RecycleViewHolder, position: Int) {
        try {
            val dataInfo = getItem(position)

            holder.apply {
                bind(dataInfo, position)

                itemView.setOnClickListener {
                    onItemClick(dataInfo)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


    inner class RecycleViewHolder(private var viewBinding: MainLiveSeminarListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: SeminarDto, position: Int) {
            with(viewBinding){
                item.run {
                    seminarTitle.text = title
                    seminarMaxCount.text = String.format("%d", maxParticipation)
                    seminarCount.text = String.format("%d", currentParticipation)

                    val start = DateFormatter.instance.dateBarTimeFormatter().parse(startAt)
                    val end = DateFormatter.instance.dateBarTimeFormatter().parse(endAt)

                    if(description.isEmpty()) {
                        detailComment.text = String.format("%s ~ %s", DateFormatter.instance.dateDayFormatterA().format(start),
                            DateFormatter.instance.dateTimeFormatter().format(end))
                        seminarDate.text = ""
                    }else {
                        detailComment.text = description
                        seminarDate.text = String.format("%s ~ %s", DateFormatter.instance.dateDayFormatterA().format(start),
                            DateFormatter.instance.dateTimeFormatter().format(end))
                    }

                    Timber.tag(MainFragment.TAG).d("roomImageUrl %s", roomImageUrl)
                    Glide.with(root.context)
                        .load(roomImageUrl)
                        .transform(CenterCrop(), RoundedCorners(16))
                        .into(imgRoom)

                    Glide.with(root.context)
                        .load(teacherImageUrl)
                        .transform(CenterCrop(), RoundedCorners(16))
                        .into(imgTeacher)

                    iconLock.visibility = if(item.secretYn == Constants.YesValue) {
                        View.VISIBLE
                    } else {
                        View.INVISIBLE
                    }

                    seminarMyCreateLayout.apply {
                        visibility = if(item.teacherId == repository.member.value!!.memberId) {
                            View.VISIBLE
                        }else {
                            join.apply {
                                setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                text = if(secretYn == Constants.YesValue) {
                                    if(participationYn == Constants.YesValue) {
                                        resources.getString(R.string.seminar_participate)
                                    }else {
                                        setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                        resources.getString(R.string.seminar_apply)
                                    }
                                }else {
                                    resources.getString(R.string.seminar_participate)
                                }
                            }
                            View.INVISIBLE
                        }
                    }

                    when(status) {
                        SeminarStatus.START -> {
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_now)
                            seminarSituation.text = itemView.context.getString(R.string.seminar_now)
                            if(item.teacherId == repository.member.value!!.memberId) {
                                join.apply {
                                    text = resources.getString(R.string.enter_comment)
                                    setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                }
                            }else {
                                if (item.secretYn == Constants.NoValue) {
                                    join.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                } else {
                                    join.text = if (item.participationYn == Constants.YesValue) {
                                        join.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                        itemView.context.getString(R.string.seminar_participate)
                                    } else {
                                        join.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                        itemView.context.getString(R.string.seminar_apply)
                                    }
                                }
                            }
                        }
                        SeminarStatus.BEFORE_START -> {
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_before)
                            seminarSituation.text = itemView.context.getString(R.string.seminar_before)

                            join.text = itemView.context.getString(R.string.seminar_participate)

                            repository.apply {
                                if(item.teacherId != member.value!!.memberId) {
                                    if(item.secretYn == Constants.YesValue) {
                                        if(participationYn == Constants.NoValue) {
                                            join.apply {
                                                text = resources.getString(R.string.seminar_apply)
                                                setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                            }
                                        }else {
                                            join.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                        }
                                    }else {
                                        join.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                    }
                                }else {
                                    join.apply {
                                        text = resources.getString(R.string.enter_comment)
                                        setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                    }
                                }
                            }
                        }
                        SeminarStatus.END -> {
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_before)
                            seminarSituation.text = itemView.context.getString(R.string.seminar_end)

                            join.text = itemView.context.getString(R.string.seminar_participate)

                            repository.apply {
                                if(item.teacherId != member.value!!.memberId) {
                                    join.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                }else {
                                    join.apply {
                                        text = resources.getString(R.string.enter_comment)
                                        setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                    }
                                }
                            }
                        }

                        else -> {}
                    }
                }

                join.setOnClickListener {
                    onItemButtonClick(item, position)
                }
            }
        }
    }


}