package com.tnmeta.torymeta.seminar.activity

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivitySeminarScheduleBinding
import com.tnmeta.torymeta.databinding.TodaySerminarListItemBinding
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date

class SeminarScheduleActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH), View.OnClickListener {

    companion object {

        fun createIntent(context: Context): Intent {
            return Intent(context, SeminarScheduleActivity::class.java)
        }
    }

    private lateinit var mSeminarAdapter : RecyclerViewAdapter

    private val viewBinding by viewBinding(ActivitySeminarScheduleBinding::inflate)
    private var dateCount = 0
    private val mSeminarArrayList = ArrayList<SeminarDto>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

            mSeminarAdapter = RecyclerViewAdapter()
            recyclerView.apply {
                layoutManager = LinearLayoutManager(this@SeminarScheduleActivity)
                adapter = mSeminarAdapter
            }

            val today = Date()
            val date = SimpleDateFormat("yy.MM.dd");

            txtToday.text = date.format(today)
            txtDate.text = "오늘"

            imgBeforeDay.setOnClickListener(this@SeminarScheduleActivity)
            imgNextDay.setOnClickListener(this@SeminarScheduleActivity)
            ivBack.setOnClickListener {
                finish()
            }

            requestSeminarInfo()
        }
    }


    override fun onClick(view: View) {
        when(view.id) {
            R.id.img_before_day -> {
                Timber.d("button  - day")
                viewBinding.apply {
                    dateCount -= 1

                    val day = Calendar.getInstance()
                    day.add(Calendar.DATE, dateCount)
                    val date = SimpleDateFormat("yy.MM.dd").format(day.time)
                    txtToday.text = date.toString()

                    if(dateCount == 0) {
                        txtDate.text = "오늘"
                        txtDate.setTextColor(ContextCompat.getColor(this@SeminarScheduleActivity, R.color.tory_purple))
                    }else {
                        if(dateCount < 0) {
                            txtDate.text = "종료"
                            txtDate.setTextColor(ContextCompat.getColor(this@SeminarScheduleActivity, R.color.color_d9d9d9d))
                        }else {
                            txtDate.text = "예정"
                            txtDate.setTextColor(ContextCompat.getColor(this@SeminarScheduleActivity, R.color.sub_purple_2))
                        }
                    }
                }

                requestSeminarInfo()

                //mSeminarAdapter.notifyDataSetChanged()
            }

            R.id.img_next_day -> {
                Timber.d("button  + day")
            viewBinding.apply {
                dateCount += 1

                val day = Calendar.getInstance()
                day.add(Calendar.DATE, dateCount)
                val date = SimpleDateFormat("yy.MM.dd").format(day.time)
                txtToday.text = date.toString()

                if(dateCount == 0) {
                    txtDate.text = "오늘"
                    txtDate.setTextColor(ContextCompat.getColor(this@SeminarScheduleActivity, R.color.tory_purple))

                }else {
                    if(dateCount < 0) {
                        txtDate.text = "종료"
                        txtDate.setTextColor(ContextCompat.getColor(this@SeminarScheduleActivity, R.color.color_d9d9d9d))
                    }else {
                        txtDate.text = "예정"
                        txtDate.setTextColor(ContextCompat.getColor(this@SeminarScheduleActivity, R.color.sub_purple_2))
                        }
                    }
                }

                //mSeminarAdapter.notifyDataSetChanged()
                requestSeminarInfo()
            }
        }
    }



    private fun requestSeminarInfo() {
        val day = Calendar.getInstance()
        day.add(Calendar.DATE, dateCount)
        val searchDate = DateFormatter.instance.dateFormatter().format(day.time)

        repository.getDateSeminar(searchDate).apply {
            subscribeBy(onNext = {
                mSeminarArrayList.apply {
                    clear()
                    addAll(it)
                }

                viewBinding.apply {
                    if(mSeminarArrayList.isEmpty()) {
                        recyclerView.visibility = View.GONE
                        emptyView.visibility = View.VISIBLE
                    }else {
                        recyclerView.visibility = View.VISIBLE
                        emptyView.visibility = View.GONE
                    }
                }

                mSeminarAdapter.notifyDataSetChanged()

            }, onError = {}, onComplete = {})
        }

    }


    inner class RecyclerViewAdapter : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = mSeminarArrayList.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecycleViewHolder {
            val binding = TodaySerminarListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val dataInfo = mSeminarArrayList!![position]
                holder.run {
                    bind(dataInfo)

                    itemView.setOnClickListener {
                        Intent(itemView.context, SeminarDetailActivity::class.java).run {
                            putExtra(Params.SEMINAR_DETAIL_INFO, dataInfo)
                            startActivity(this)
                        }
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
                        //seminarTeacher.text =

                        val start = DateFormatter.instance.dateBarTimeFormatter().parse(startAt)
                        val end = DateFormatter.instance.dateBarTimeFormatter().parse(endAt)
                        seminarDate.text = String.format("%s - %s", DateFormatter.instance.dateDayFormatter().format(start),
                                                        DateFormatter.instance.dateDayFormatter().format(end))

                    }
                }
            }
        }
    }


}