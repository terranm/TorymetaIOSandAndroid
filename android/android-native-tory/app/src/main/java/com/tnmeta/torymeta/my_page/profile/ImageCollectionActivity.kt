package com.tnmeta.torymeta.my_page.profile

import android.content.Context
import android.os.Bundle
import android.util.Size
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityImageCollectionBinding
import com.tnmeta.torymeta.databinding.ImageListItemBinding
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.dto.InfoDTO
import com.tnmeta.torymeta.utils.Utilts
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setItemPadding
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/**
 * 이미지 컬렉션 화면
 */
open class ImageCollectionActivity: BaseActivity(TransitionModeType.SLIDE_UP_IN) {
    companion object {
        const val PARAM_TITLE  = "title"
    }

    private val viewBinding by viewBinding(ActivityImageCollectionBinding::inflate)

    private val mDataArray = ArrayList<Any>()
    private var mInfo = InfoDTO()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.run {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, intent.getStringExtra(PARAM_TITLE) ?: "")
            setTopBarBackButtonEnabled(viewBinding.topBar, true) {
                setResult(RESULT_CANCELED)
                finish()
            }

            collectionListView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                    super.onScrolled(recyclerView, dx, dy)
                    if(!recyclerView.canScrollVertically(1)) {
                        CoroutineScope(Dispatchers.Main).launch {
                            if(mInfo != null)
                                onScrolled(mInfo)
                        }
                    }
                }
            })

        }
    }

    protected open fun onScrolled(info: InfoDTO) {

    }

    protected open fun onBindItemView(itemView: View, data: Any) {
    }

    protected open fun onClickItem(data: Any) {
    }

    protected fun initList(dataArray: List<Any>, info : InfoDTO)  = viewBinding.run{
        mInfo = info
        if(mDataArray.isEmpty()) {
            emptyView.setVisible(dataArray.isEmpty())
            val spanCount = 2
            fun getItemWidth(): Float {
                var width = Utilts.instance.getScreenSize(this@ImageCollectionActivity).x.toFloat()
                width -= resources.getDimension(R.dimen.common_padding_horizontal) * 2
                width -= resources.getDimension(R.dimen.nft_collection_list_padding)
                return width / spanCount
            }
            fun getItemHeight() = Utilts.instance.getScreenSize(this@ImageCollectionActivity).y.toFloat() / 4

            val itemSize = Size(getItemWidth().toInt(), getItemHeight().toInt())

            collectionListView.layoutManager = GridLayoutManager(this@ImageCollectionActivity, spanCount)
            collectionListView.adapter = ListAdapter(this@ImageCollectionActivity, itemSize,
                onBindItemViewListener = { view, data ->
                    onBindItemView(view, data)
                },
                onClickItemListener = { data ->
                    onClickItem(data)
                })

            val padding = resources.getDimension(R.dimen.nft_collection_list_padding).toInt()
            collectionListView.setItemPadding(padding, padding)
        }
        mDataArray.addAll(dataArray)
        collectionListView.adapter!!.notifyDataSetChanged()

    }

    protected fun initList(dataArray: List<Any>)  = viewBinding.run{

        if(mDataArray.isEmpty()) {
            emptyView.setVisible(dataArray.isEmpty())
            val spanCount = 2
            fun getItemWidth(): Float {
                var width = Utilts.instance.getScreenSize(this@ImageCollectionActivity).x.toFloat()
                width -= resources.getDimension(R.dimen.common_padding_horizontal) * 2
                width -= resources.getDimension(R.dimen.nft_collection_list_padding)
                return width / spanCount
            }
            fun getItemHeight() = Utilts.instance.getScreenSize(this@ImageCollectionActivity).y.toFloat() / 4

            val itemSize = Size(getItemWidth().toInt(), getItemHeight().toInt())

            /*
            collectionListView.layoutManager = GridLayoutManager(this@ImageCollectionActivity, spanCount)
            collectionListView.adapter = ListAdapter(this@ImageCollectionActivity, itemSize,
                onBindItemViewListener = { view, data ->
                    onBindItemView(view, data)
                },
                onClickItemListener = { data ->
                    onClickItem(data)
                })

            val padding = resources.getDimension(R.dimen.nft_collection_list_padding).toInt()
            collectionListView.setItemPadding(padding, padding)
            */

            collectionListView.apply {
                layoutManager = GridLayoutManager(this@ImageCollectionActivity, spanCount)
                adapter = ListAdapter(this@ImageCollectionActivity, itemSize,
                    onBindItemViewListener = { view, data ->
                        onBindItemView(view, data)
                    },
                    onClickItemListener = { data ->
                        onClickItem(data)
                    })

                val padding = resources.getDimension(R.dimen.nft_collection_list_padding).toInt()
                setItemPadding(padding, padding)
            }

        }
        mDataArray.addAll(dataArray)
        collectionListView.adapter!!.notifyDataSetChanged()

    }

    /**
     * 리스트 아이템 ViewHolder
     */

    protected inner class ItemViewHolder(val rootView: ImageListItemBinding): RecyclerView.ViewHolder(rootView.root) {
        fun bind(data: Any) {
            rootView.apply {
            }
        }
    }

    /**
     * 리스트 Adapter
     */
    /*
    protected  class ListAdapter(val context: Context, val itemSize: Size, val datas: List<Any>,
                                 val onBindItemViewListener: (View, Any) -> Unit,
                                 val onClickItemListener: (Any) -> Unit): RecyclerView.Adapter<ItemViewHolder>() {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
            val binding = ImageListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            binding.imageBoard.layoutParams = ViewGroup.LayoutParams(itemSize.width, itemSize.height)
            return ItemViewHolder(binding)
        }

        override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
            val data = datas[position]
            holder.itemView.setOnClickListener {
                onClickItemListener(data)
            }

            onBindItemViewListener(holder.rootView.image, data)
        }

        override fun getItemCount(): Int = datas.size
    }
     */

    protected inner class ListAdapter(val context: Context, private val itemSize: Size,
                                      val onBindItemViewListener: (View, Any) -> Unit,
                                      val onClickItemListener: (Any) -> Unit): RecyclerView.Adapter<ItemViewHolder>() {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
            val binding = ImageListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            binding.imageBoard.layoutParams = ViewGroup.LayoutParams(itemSize.width, itemSize.height)
            return ItemViewHolder(binding)
        }

        override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
            val data = mDataArray[position]
            holder.itemView.setOnClickListener {
                onClickItemListener(data)
            }

            onBindItemViewListener(holder.rootView.image, data)
        }

        override fun getItemCount(): Int = mDataArray.size
    }
}