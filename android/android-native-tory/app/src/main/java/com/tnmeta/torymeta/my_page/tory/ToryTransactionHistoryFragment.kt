package com.tnmeta.torymeta.my_page.tory

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.firebase.analytics.FirebaseAnalytics
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.RestAPI
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.databinding.ActivityToryTransactionHistoryFragmentBinding
import com.tnmeta.torymeta.databinding.PeriodListItemBinding
import com.tnmeta.torymeta.databinding.PointListItemBinding
import com.tnmeta.torymeta.model.PointFilter
import com.tnmeta.torymeta.model.dto.HistoryDTO
import com.tnmeta.torymeta.my_page.mileage.MileagePointTransactionHistoryActivity
import com.tnmeta.torymeta.utils.DateFormatter
import com.tnmeta.torymeta.utils.Divider
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.DecimalFormat
import java.text.SimpleDateFormat


class ToryTransactionHistoryFragment : BaseFragment(){
    companion object {
        fun newInstance() =
            ToryTransactionHistoryFragment().apply {}
    }

    private val mPointHistoryArray = ArrayList<HistoryDTO>()

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

    private var selectedPosition = 1

    private val viewBinding by lazy(LazyThreadSafetyMode.NONE) {
        ActivityToryTransactionHistoryFragmentBinding.inflate(layoutInflater)
    }

    private lateinit var mAdapter: RecyclerViewAdapter

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {
            val dividerWidth = resources.getDimension(R.dimen.campus_top_list_item_padding_horizontal)
            topListView.apply {
                layoutManager = LinearLayoutManager(context, RecyclerView.HORIZONTAL, false)
                adapter = PeriodRecyclerViewAdapter()
                addItemDecoration(Divider(dividerWidth.toInt(), 0))
            }

            mAdapter = RecyclerViewAdapter()
            recyclerView.apply {
                layoutManager = LinearLayoutManager(requireContext())
                setDivider(R.drawable.recycler_view_divider)
                adapter = mAdapter
            }

            recyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                    super.onScrolled(recyclerView, dx, dy)
                    if(!recyclerView.canScrollVertically(1)) {
                        if(mPointHistoryArray.size % 10 == 0) {
                            val size = mPointHistoryArray.size / 10
                            getPointTransactionHistory(size, filterArray[selectedPosition])
                        }
                    }
                }
            })

            CoroutineScope(Dispatchers.Main).launch {
                getPointTransactionHistory(0, filterArray[selectedPosition])
            }

            if(Constants.is_FirebaseAnalytics) {
                firebaseAnalyticsMember(FirebaseParam.mobile_torycharge_transaction)
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
                            onChangePeriod(position)
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
        getPointTransactionHistory(0, filterArray[position])
    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun getPointTransactionHistory(page : Int, period : String) = try {
        viewBinding.apply {
            animationView.visibility = View.VISIBLE
            repository.getPointHistory(RestAPI.API_SEARCH_COUNT, page, period)
                .subscribeBy(onNext = {

                    if (page == 0) mPointHistoryArray.clear()

                    mPointHistoryArray.addAll(it.historyList)

                    if (mPointHistoryArray.isNotEmpty()) {
                        emptyView.visibility = View.INVISIBLE
                        recyclerView.visibility = View.VISIBLE

                    } else {
                        emptyView.visibility = View.VISIBLE
                        recyclerView.visibility = View.INVISIBLE
                    }
                    animationView.visibility = View.GONE
                    mAdapter.notifyDataSetChanged()
                }, onError = {

                    if (page == 0) mPointHistoryArray.clear()

                    if (mPointHistoryArray.isNotEmpty()) {
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


    inner class RecyclerViewAdapter : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = mPointHistoryArray.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = PointListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val pointInfo = mPointHistoryArray[position]

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

                        transactionNumber.text = if(txId.isNotEmpty() && !txId.contains("event")) {
                            String.format("(%s)", txId)
                        }else {
                            ""
                        }

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

                        val date  = DateFormatter.instance.dateFullFormat().parse(expireTime)
                        validity.text = getString(R.string.expire_time_format, "${DateFormatter.instance.simpleDotted().format(date)}")

                    } catch (e: Exception) {
                        Timber.d(e.message)
                    }
                }
            }
        }
    }

}