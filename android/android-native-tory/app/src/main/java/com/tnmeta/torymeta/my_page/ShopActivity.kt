package com.tnmeta.torymeta.my_page

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityShopBinding
import com.tnmeta.torymeta.databinding.MyPageBottomSheetBinding
import com.tnmeta.torymeta.databinding.ShopItemBinding
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.dto.ToryItemDTO
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.utils.Divider
import kotlinx.coroutines.launch
import java.text.DecimalFormat

/**
 * 토리 충전 화면
 */
class ShopActivity: BaseActivity(TransitionModeType.SLIDE_IN_RIGTH) {
    companion object {
        const val TAG          = "Shop"
    }

    private val viewBinding by viewBinding(ActivityShopBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.run {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, R.string.shop_title)
            setTopBarBackButtonEnabled(viewBinding.topBar, true) {
                finish()
            }

            initIAB()
            initItemList()

            repository.point.observe(this@ShopActivity) {
                myPointView.text = "${DecimalFormat("#,###").format(it.point)}"
            }

            pointInfoBtn.setOnClickListener {
                CommonBottomSheet.createInRootView(this@ShopActivity).apply {

                    val pageBottomSheetBinding = MyPageBottomSheetBinding.inflate(LayoutInflater.from(rootView.context), rootView, false).apply {
                        title.text = getString(R.string.my_page_tory_point_info_title)
                        desc.text = getString(R.string.my_page_tory_point_info_desc)
                    }
                    commonBottomSheetBinding.content.addView(pageBottomSheetBinding.root)

                }.show()
            }

            if(Constants.is_FirebaseAnalytics) {
                firebaseAnalyticsMember(FirebaseParam.mobile_torycharge)
            }
        }
    }

    /**
     * 아이템 클릭
     */
    private fun onClickItem(data: ToryItemDTO) {
        runOnUiThread {
            toryApplication.iabHelper.launchBillingFlow(this, data.itemId.lowercase())
        }
    }

    /**
     * 인앱 결제 초기화
     */
    private fun initIAB() {
        toryApplication.applicationScope.launch {
            toryApplication.iabHelper.getNewPurchases().collect { purchase ->
                Log.i(TAG, "getNewPurchases().collect ===== START")
                Log.i(TAG, "purchaseToken: ${purchase.purchaseToken}")
                Log.i(TAG, "developerPayload: ${purchase.developerPayload}")
                Log.i(TAG, "originalJson: ${purchase.originalJson}")

                for( prod in purchase.products ) {
                    Log.i(TAG, "prod: ${prod}")
                }

                repository.chargePoint(purchase.packageName, purchase.products[0], purchase.purchaseToken)

                Log.i(TAG, "getNewPurchases().collect ===== END")
            }
        }

        toryApplication.applicationScope.launch {
            toryApplication.iabHelper.getConsumedPurchases().collect { skuList ->
                Log.i(TAG, "getConsumedPurchases().collect ===== START")
                for( sku in skuList ) {
                    Log.i(TAG, "getConsumedPurchases(): ${sku}")
                }
                Log.i(TAG, "getConsumedPurchases().collect ===== END")
            }
        }
    }

    /**
     * 아이템 리스트 초기화
     */
    private fun initItemList() = viewBinding.apply {
        itemListView.layoutManager = LinearLayoutManager(this@ShopActivity, RecyclerView.VERTICAL, false)
        itemListView.adapter = ListAdapter({ data ->
            onClickItem(data)
        }, repository.toryItemList)

        /*
        class Divider(val padding: Int): RecyclerView.ItemDecoration() {
            override fun getItemOffsets(outRect: Rect, view: View, parent: RecyclerView, state: RecyclerView.State) {
                super.getItemOffsets(outRect, view, parent, state)

                val position = parent.getChildAdapterPosition(view)
                if( position > 0 ) {
                    outRect.top = padding
                }
            }
        }
         */
        val padding = resources.getDimension(R.dimen.shop_item_list_padding)
        itemListView.addItemDecoration(Divider(padding.toInt(), 1))
    }

    /**
     * 리스트 아이템 ViewHolder
     */
    class ItemViewHolder(val rootView: ShopItemBinding): RecyclerView.ViewHolder(rootView.root) {
        fun bind(data: ToryItemDTO) {
            rootView.apply {
                name.text = data.itemName
                price.text = "${DecimalFormat("#,###").format(data.cashValue)}원"
            }
        }
    }

    /**
     * 리스트 Adapter
     */
    class ListAdapter(val onClickItemListener: (ToryItemDTO) -> Unit, val datas: List<ToryItemDTO>): RecyclerView.Adapter<ItemViewHolder>() {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
            val viewBinding = ShopItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return ItemViewHolder(viewBinding)
        }

        override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
            val data = datas[position]
            holder.bind(data)
            holder.itemView.setOnClickListener {
                onClickItemListener(data)
            }
        }

        override fun getItemCount(): Int = datas.size
    }
}