package com.tnmeta.torymeta.my_page.mileage

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.RestAPI
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.databinding.ActivityMileagePointTransactionHistoryBinding
import com.tnmeta.torymeta.databinding.MyPageBottomSheetBinding
import com.tnmeta.torymeta.databinding.PeriodListItemBinding
import com.tnmeta.torymeta.databinding.PointListItemBinding
import com.tnmeta.torymeta.model.PointFilter
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.dto.HistoryDTO
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.utils.DateFormatter
import com.tnmeta.torymeta.utils.Divider
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.DecimalFormat
import java.text.SimpleDateFormat


class MileagePointTransactionHistoryActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH), View.OnClickListener {

    companion object {
        const val  MILEAGE_POINT_VALUE     = "_MILEAGE_POINT_VALUE_"
    }

    private val mMileagePointArray = ArrayList<HistoryDTO>()

    private lateinit var mAdapter: RecyclerViewAdapter
    private val viewBinding by viewBinding(ActivityMileagePointTransactionHistoryBinding::inflate)
    private var selectedPosition = 1

    private val searchFilterArray: ArrayList<PointFilter> by lazy {
        val list = ArrayList<PointFilter>()
        list.add(PointFilter(resources.getString(R.string.period_one_week), 0, false))
        list.add(PointFilter(resources.getString(R.string.period_one_month), 1, true))
        list.add(PointFilter(resources.getString(R.string.period_six_month), 2, false))
        list.add(PointFilter(resources.getString(R.string.period_one_year), 3, false))
        list.add(PointFilter(resources.getString(R.string.period_total), 4, false))

        list
    }

    private val filterArray : Array<String> by lazy {
        arrayOf(
            resources.getString(R.string.query_period_one_week),
            resources.getString(R.string.query_period_one_month),
            resources.getString(R.string.query_period_six_month),
            resources.getString(R.string.query_period_one_year),
            resources.getString(R.string.query_period_all)
        )
    }

    private lateinit var periodAdapter: PeriodRecyclerViewAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.apply {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, R.string.mileage_point_title_history)
            setTopBarBackButtonEnabled(viewBinding.topBar,true) {
                finish()
            }

            if(intent.hasExtra(MILEAGE_POINT_VALUE)) {
                val mileage = intent.getIntExtra(MILEAGE_POINT_VALUE, 0)
                mileageTextView.text = getString(R.string.my_page_mileage_format_01, "${DecimalFormat("#,###").format(mileage)}")
            }

            mAdapter = RecyclerViewAdapter()
            recyclerView.apply {
                layoutManager = LinearLayoutManager(this@MileagePointTransactionHistoryActivity)
                setDivider(R.drawable.recycler_view_divider)
                adapter = mAdapter
            }

            periodAdapter = PeriodRecyclerViewAdapter()
            val dividerWidth = resources.getDimension(R.dimen.campus_top_list_item_padding_horizontal)
            topListView.apply {
                layoutManager = LinearLayoutManager(context, RecyclerView.HORIZONTAL, false)
                adapter = periodAdapter
                addItemDecoration(Divider(dividerWidth.toInt(), 0))
            }

            recyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                    super.onScrolled(recyclerView, dx, dy)
                    if(!recyclerView.canScrollVertically(1)) {
                        if(mMileagePointArray.size % 10 == 0) {
                            val size = mMileagePointArray.size / 10
                            getMileageHistory(size, filterArray[selectedPosition])
                        }
                    }
                }
            })

            CoroutineScope(Dispatchers.Main).launch {
                getMileageHistory(0, filterArray[selectedPosition])
            }

            if(Constants.is_FirebaseAnalytics) {
                firebaseAnalyticsMember(FirebaseParam.mobile_mileage_history)
            }
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.mileageInfoBtn -> {
                CommonBottomSheet.createInRootView(this).apply {
                    val binding = MyPageBottomSheetBinding.inflate(LayoutInflater.from(rootView.context), rootView, false).apply {
                        title.text = getString(R.string.my_page_mileage_info_title)
                        desc.text = getString(R.string.my_page_mileage_info_desc)
                    }
                    commonBottomSheetBinding.content.addView(binding.root)
                }.show()
            }
        }
    }


    inner class PeriodRecyclerViewAdapter : RecyclerView.Adapter<PeriodRecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = searchFilterArray.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PeriodRecyclerViewAdapter.RecycleViewHolder {
            val binding = PeriodListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: PeriodRecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val itemValue = searchFilterArray!![position]
                holder.run {
                    bind(itemValue)

                    itemView.setOnClickListener {
                        if(selectedPosition == position) {
                            return@setOnClickListener
                        }
                        val prevPosition = selectedPosition
                        selectedPosition = position

                        val expanded = itemValue.isSelect
                        itemValue.isSelect = !expanded
                        notifyItemChanged(selectedPosition)

                        CoroutineScope(Dispatchers.Main).launch {
                            onChangePeriod(selectedPosition)
                        }
                        if (prevPosition != -1 && selectedPosition != prevPosition) {
                            val notificationInfo1 = searchFilterArray!![prevPosition]
                            notificationInfo1.isSelect = false
                            notifyItemChanged(prevPosition)
                        }
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: PeriodListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: PointFilter) {
                with(viewBinding) {
                    item.run {
                        if(isSelect) {
                            title.setTextColor(ContextCompat.getColor(itemView.context, R.color.tory_white))
                            bg.setBackgroundResource(R.drawable.select_point_filter)
                        }else {
                            title.setTextColor(ContextCompat.getColor(itemView.context, R.color.tory_black))
                            bg.setBackgroundResource(R.drawable.unselect_point_filter)
                        }

                        title.text = filterName
                    }
                }
            }
        }
    }

    private fun onChangePeriod(position: Int) = try {
        getMileageHistory(0, filterArray[position])
    }catch (e : Exception){
        Timber.d(e.message)
    }

    inner class RecyclerViewAdapter : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = mMileagePointArray.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = PointListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val pointInfo = mMileagePointArray[position]
                holder.run {
                    bind(pointInfo)
                }
            } catch (e: Exception) {
                Timber.d(e.message)
            }
        }


        inner class RecycleViewHolder(private var viewBinding: PointListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: HistoryDTO) = with(viewBinding) {
                item.run {
                    try {
                        val time  = DateFormatter.instance.dateFullFormat().parse(useTime)
                        date.text = DateFormatter.instance.fullDotted().format(time)
                        title.text = history

                        transactionNumber.text = if(txId.isNotEmpty()) String.format("(%s)", txId) else ""

                        val color = when(type) {
                            1 -> {
                                pointInfo.text = getString(R.string.point_add_format, "${DecimalFormat("#,###").format(quantity)}")
                                ContextCompat.getColor(itemView.context, R.color.color_blue_71)
                            }
                            2 -> {
                                pointInfo.text = getString(R.string.point_subtract_format, "${DecimalFormat("#,###").format(quantity)}")
                                ContextCompat.getColor(itemView.context, R.color.color_red_ff)
                            }
                            else -> ContextCompat.getColor(itemView.context, R.color.color_blue_71)
                        }

                        pointInfo.setTextColor(color)
                        validity.visibility = if(expireTime.isNullOrEmpty()) View.GONE else View.VISIBLE

                        validity.text = if(!expireTime.isNullOrEmpty()) {
                            val date  = DateFormatter.instance.dateFullFormat().parse(expireTime)
                            getString(R.string.expire_time_format, "${DateFormatter.instance.simpleDotted().format(date)}")
                        }else ""

                    } catch (e: Exception) {
                        Timber.d(e.message)
                    }
                }
            }
        }
    }


    private fun getMileageHistory(page : Int, period : String) = try {
        viewBinding.apply {
            animationView.visibility = View.VISIBLE
            repository.getMileageHistory(RestAPI.API_SEARCH_COUNT, page, period)
                .subscribeBy(onNext = {

                    if (page == 0) mMileagePointArray.clear()

                    mMileagePointArray.addAll(it.historyList)

                    if (mMileagePointArray.isNotEmpty()) {
                        emptyView.visibility = View.INVISIBLE
                        recyclerView.visibility = View.VISIBLE

                    } else {
                        emptyView.visibility = View.VISIBLE
                        recyclerView.visibility = View.INVISIBLE
                    }
                    animationView.visibility = View.GONE
                    mAdapter.notifyDataSetChanged()
                }, onError = {

                    if (page == 0) mMileagePointArray.clear()

                    if (mMileagePointArray.isNotEmpty()) {
                        emptyView.visibility = View.INVISIBLE
                        recyclerView.visibility = View.VISIBLE
                    } else {
                        emptyView.visibility = View.VISIBLE
                        recyclerView.visibility = View.INVISIBLE
                    }
                    animationView.visibility = View.GONE
                    mAdapter.notifyDataSetChanged()
                })
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

}