package com.tnmeta.torymeta.seminar.adapter

import android.annotation.SuppressLint
import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.GranularRoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.databinding.MyOpenSeminarItemListBinding
import com.tnmeta.torymeta.seminar.model.seminar.Content
import com.tnmeta.torymeta.seminar.myseminar.MyOpenedFragment
import com.tnmeta.torymeta.utils.DateFormatter
import timber.log.Timber

class MyOpenedAdapter(private val items : List<Content>,
                      val onItemClick: (Content) -> Unit,
                      val onItemButtonClick : (View, Content, Int) -> Unit) : RecyclerView.Adapter<MyOpenedAdapter.RecycleViewHolder>() {

    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = RecycleViewHolder (
        MyOpenSeminarItemListBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: MyOpenedAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = items!![position]
            holder.run {
                bind(position, dataInfo)

                itemView.setOnClickListener {
                    Timber.d("SeminarRecyclerViewAdapter + itemView")
                    onItemClick(dataInfo)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: MyOpenSeminarItemListBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(position: Int, item: Content) {
            with(viewBinding) {
                item.run {
                    seminarTitle.text = title
                    seminarDesc.text = description

                    seminarMaxCount.text = itemView.context.getString(R.string.people_total_count_text, "$maxEnterCount")
                    seminarCount.text = String.format("%d", item.requestParticipation)

                    val start = DateFormatter.instance.dateBarTimeFormatter().parse(startAt)
                    val end = DateFormatter.instance.dateBarTimeFormatter().parse(endAt)

                    itemView.context.apply {
                        seminarDate.text = resources.getString(
                            R.string.seminar_date_format, DateFormatter.instance.yearDayFormatter().format(start),
                            DateFormatter.instance.dateTimeFormatter().format(end))

                        if(password.isNotEmpty()) {
                            txtOpenPassword.text = password
                        }

                        Glide.with(root.context)
                            .load(room.roomImageUrl)
                            .transform(GranularRoundedCorners(0.0f, 0.0f, 32.0f, 32.0f))
                            .into(seminarImage)

                        if(item.secretYn == Constants.NoValue) {
                            passwordOpenLayout.visibility = View.GONE
                            iconLock.visibility = View.GONE
                        }

                        iconDelete.setOnClickListener {
                            onItemButtonClick(iconDelete, item, position)
                        }

                        Timber.tag(MyOpenedFragment.TAG).d(status)

                        when(status) {
                            SeminarStatus.CONFIRM -> {
                                seminarSituation.text = resources.getString(R.string.seminar_approve)
                                seminarSituationLayout.setBackgroundResource(R.drawable.seminar_appy_approve)
                            }
                            SeminarStatus.REJECT -> {
                                seminarSituation.text = resources.getString(R.string.seminar_reject)
                                seminarSituationLayout.setBackgroundResource(R.drawable.seminar_apply_reject)
                            }

                            SeminarStatus.BEFORE_START -> {
                                seminarSituation.text = resources.getString(R.string.seminar_before)
                                seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_before)
                            }

                            SeminarStatus.START -> {
                                seminarSituation.text = resources.getString(R.string.seminar_now)
                                seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_now)
                            }

                            SeminarStatus.END -> {
                                seminarSituation.text = resources.getString(R.string.seminar_end)
                                seminarSituationLayout.setBackgroundResource(R.drawable.seminar_status_end)
                            }
                        }
                    }

                    modify.setOnClickListener {
                        onItemButtonClick(modify, item, position)
                    }

                    seminarEnter.setOnClickListener {
                        onItemButtonClick(seminarEnter, item, position)
                    }
                }
            }
        }
    }
}