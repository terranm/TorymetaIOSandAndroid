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
import com.tnmeta.torymeta.databinding.ActivityToryChargeFragmentBinding
import com.tnmeta.torymeta.databinding.ChargeListItemBinding
import com.tnmeta.torymeta.databinding.PeriodListItemBinding
import com.tnmeta.torymeta.databinding.PointListItemBinding
import com.tnmeta.torymeta.model.PointFilter
import com.tnmeta.torymeta.model.dto.ChargeHistoryDTO
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

class ToryChargeFragment : BaseFragment() {

    companion object {
        fun newInstance() =
            ToryChargeFragment().apply {}

        private val dateformat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
    }



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
            resources.getString(R.string.query_period_one_month),
            resources.getString(R.string.query_period_one_year),
            resources.getString(R.string.query_period_all)
        )
    }

    private val mPointChargeArray = ArrayList<ChargeHistoryDTO>()
    private lateinit var mAdapter: RecyclerViewAdapter
    private var selectedPosition = 1

    private val viewBinding by lazy(LazyThreadSafetyMode.NONE) {
        ActivityToryChargeFragmentBinding.inflate(layoutInflater)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

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
                layoutManager = LinearLayoutManager(context)
                setDivider(R.drawable.recycler_view_divider)
                adapter = mAdapter
            }

            recyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                    super.onScrolled(recyclerView, dx, dy)
                    if(!recyclerView.canScrollVertically(1)) {
                        if(mPointChargeArray.size % 10 == 0) {
                            val size = mPointChargeArray.size / 10
                            getChargeHistory(size, filterArray[selectedPosition])
                        }
                    }
                }
            })

            if(Constants.is_FirebaseAnalytics) {
                firebaseAnalyticsMember(FirebaseParam.mobile_torycharge_history)
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
        getChargeHistory(0, filterArray[position])
    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun getChargeHistory(page : Int, period : String) = try {
        viewBinding.apply {

            animationView.visibility = View.VISIBLE
            repository.getPointCharge(RestAPI.API_SEARCH_COUNT, page, period)
                .subscribeBy(onNext = {

                    if (page == 0) mPointChargeArray.clear()

                    mPointChargeArray.addAll(it.chargeHistoryList)

                    if (mPointChargeArray.isNotEmpty()) {
                        emptyView.visibility = View.INVISIBLE
                        recyclerView.visibility = View.VISIBLE

                    } else {
                        emptyView.visibility = View.VISIBLE
                        recyclerView.visibility = View.INVISIBLE
                    }
                    animationView.visibility = View.GONE
                    mAdapter.notifyDataSetChanged()
                }, onError = {

                    if (page == 0) mPointChargeArray.clear()

                    if (mPointChargeArray.isNotEmpty()) {
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
        override fun getItemCount(): Int = mPointChargeArray.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = ChargeListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val pointInfo = mPointChargeArray[position]
                holder.run {
                    bind(pointInfo)
                    itemView.setOnClickListener {
                    }
                }
            } catch (e: Exception) {
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: ChargeListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: ChargeHistoryDTO) = with(viewBinding) {
                item.run {
                    try {
                        val time  = dateformat.parse(chargeDay)
                        date.text = DateFormatter.instance.dateBarFormatter().format(time)

                        if(quantity > 0) {
                            when(chargeType.toInt()) {
                                1 -> {
                                    content.text =  getString(R.string.tory_charge_format, "${DecimalFormat("#,###").format(quantity)}")
                                    content.setTextColor(ContextCompat.getColor(itemView.context, R.color.tory_purple))
                                }

                                2 -> {
                                    content.text = getString(R.string.tory_refund_format, "${DecimalFormat("#,###").format(quantity)}")
                                    content.setTextColor(ContextCompat.getColor(itemView.context, R.color.tory_black))
                                }
                            }
                        }

                    } catch (e: Exception) {
                        Timber.d(e.message)
                    }
                }
            }
        }
    }

}