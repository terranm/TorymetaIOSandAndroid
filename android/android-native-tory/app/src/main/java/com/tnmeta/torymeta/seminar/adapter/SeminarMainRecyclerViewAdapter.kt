package com.tnmeta.torymeta.seminar.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.ToryRepository
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.databinding.SeminarListItemBinding
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.seminar.main.SeminarMainFragment
import com.tnmeta.torymeta.seminar.model.SortType
import com.tnmeta.torymeta.utils.DateFormatter
import timber.log.Timber

class SeminarMainRecyclerViewAdapter (val repository: ToryRepository,
                                      val itemViewClick: (SeminarDto) -> Unit,
                                      val itemButtonClick : (SeminarDto, Int) -> Unit) : RecyclerView.Adapter<SeminarMainRecyclerViewAdapter.RecycleViewHolder>(){

    private var sortType = SortType.All
    private val mSeminarArrayList = ArrayList<SeminarDto>()

    fun arrayReset() {
        this.mSeminarArrayList.clear()
    }
    fun replaceItems(items: List<SeminarDto>) {
        this.mSeminarArrayList.addAll(items)
    }

    fun setSortType(sortType: SortType) {
        this.sortType = sortType
    }

    override fun getItemCount(): Int {
        return when (sortType) {
            SortType.All -> mSeminarArrayList.size
            SortType.Start -> mSeminarArrayList.filter { it.status == SeminarStatus.START }.size
            SortType.Before -> mSeminarArrayList.filter { it.status == SeminarStatus.BEFORE_START }.size
            SortType.End -> mSeminarArrayList.filter { it.status == SeminarStatus.END }.size
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecycleViewHolder {
        val binding = SeminarListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return RecycleViewHolder(binding)
    }

    override fun onBindViewHolder(holder: RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = when (sortType) {
                SortType.All    -> mSeminarArrayList[position]
                SortType.Start  -> mSeminarArrayList.filter { it.status == SeminarStatus.START }[position]
                SortType.Before -> mSeminarArrayList.filter { it.status == SeminarStatus.BEFORE_START }[position]
                SortType.End    -> mSeminarArrayList.filter { it.status == SeminarStatus.END }[position]
            }

            holder.run {
                bind(dataInfo, position)
                itemView.setOnClickListener {
                    itemViewClick(dataInfo)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: SeminarListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: SeminarDto, position: Int) = try {
            with(viewBinding) {
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

                    join.apply {
                        text = if(item.secretYn == Constants.YesValue) resources.getString(R.string.seminar_apply) else resources.getString(R.string.seminar_participate)
                        setBackgroundResource(R.drawable.common_corner_round_purple_02)
                    }

                    seminarMyCreateLayout.visibility = if(item.teacherId == repository.member.value!!.memberId) View.VISIBLE else View.GONE

                    when (status) {
                        SeminarStatus.START -> {
                            seminarSituation.text = itemView.context.getString(R.string.status_now)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_now)

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
                        SeminarStatus.END -> {
                            seminarSituation.text = itemView.context.getString(R.string.status_end)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_end)
                            join.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                        }

                        SeminarStatus.BEFORE_START -> {
                            seminarSituation.text = itemView.context.getString(R.string.status_before)
                            seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_before)
                            join.text = itemView.context.getString(R.string.seminar_participate)

                            repository.apply {
                                if(item.teacherId != member.value!!.memberId) {
                                    if(item.secretYn == Constants.YesValue) {
                                        if(participationYn == Constants.NoValue) {
                                            join.text = itemView.context.getString(R.string.seminar_apply)
                                            join.setBackgroundResource(R.drawable.common_corner_round_purple_02)
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
                    }

                    Glide.with(root.context)
                        .load(roomImageUrl)
                        .transform(CenterCrop(), RoundedCorners(16))
                        .into(imgRoom)

                    Glide.with(root.context)
                        .load(teacherImageUrl)
                        .transform(CenterCrop(), RoundedCorners(16))
                        .into(imgTeacher)

                    iconLock.visibility = if(item.secretYn == Constants.YesValue) View.VISIBLE
                                            else View.INVISIBLE
                }

                join.setOnClickListener {
                    itemButtonClick(item, position)
                }
            }

        }catch (e : Exception){
            Timber.tag(SeminarMainFragment.TAG).d(e.message)
        }
    }
}
