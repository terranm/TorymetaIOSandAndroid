package com.tnmeta.torymeta.my_page

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.MyPageCommentItemBinding
import com.tnmeta.torymeta.databinding.MyPageWriteItemBinding
import com.tnmeta.torymeta.databinding.MyPageWritePageBinding
import com.tnmeta.torymeta.model.BoardType
import com.tnmeta.torymeta.model.dto.MyCommentDTO
import com.tnmeta.torymeta.model.dto.MyWriteDTO
import com.tnmeta.torymeta.ui.recyclerview.BaseAdapter
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder
import com.tnmeta.torymeta.utils.DateFormatter
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getDimension
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setItemPadding
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible


class WritePagerAdapter(val adapters: List<RecyclerView.Adapter<RecyclerView.ViewHolder>>): RecyclerView.Adapter<WritePagerAdapter.PagerViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PagerViewHolder {

        val viewBinding = MyPageWritePageBinding.inflate(LayoutInflater.from(parent.context), parent, false).apply {
            listView.layoutManager = LinearLayoutManager(parent.context, RecyclerView.VERTICAL, false)
            listView.setItemPadding(0, parent.context.getDimension(R.dimen.my_page_write_list_item_padding_vertical).toInt())
        }

        return PagerViewHolder(viewBinding)

    }

    override fun onBindViewHolder(holder: PagerViewHolder, position: Int) {
        holder.bind(adapters[position])
    }

    override fun getItemCount(): Int = adapters.size

    class PagerViewHolder(val rootView: MyPageWritePageBinding): RecyclerView.ViewHolder(rootView.root) {
        fun bind(adapter: RecyclerView.Adapter<RecyclerView.ViewHolder>) {
            rootView.apply {
                emptyView.setVisible(adapter.itemCount == 0)

                listView.adapter = adapter
                adapter.notifyDataSetChanged()
            }
        }
    }
}

/**
 * 내가 쓴 글 Adapter
 */
class WriteAdapter(datas: List<MyWriteDTO>): BaseAdapter<MyWriteDTO>(datas) {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): WriteViewHolder {
        val viewBinding = MyPageWriteItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        val holder = WriteViewHolder(viewBinding).apply {
            initViewHolder(this)
        }
        return holder
    }

    class WriteViewHolder(val rootView: MyPageWriteItemBinding): BaseViewHolder<MyWriteDTO>(rootView.root) {
        override fun bind(data: MyWriteDTO) {
            super.bind(data)

            rootView.apply {
                title.text = data.title
                content.text = data.content
                val dateTime = DateFormatter.instance.fullDotted().parse(data.date)
                date.text = DateFormatter.instance.dateBarFormatter().format(dateTime)
            }
        }
    }
}

/**
 * 내가 쓴 댓글 Adapter
 */
class CommentAdapter(datas: List<MyCommentDTO>): BaseAdapter<MyCommentDTO>(datas) {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CommentViewHolder {
        val viewBinding = MyPageCommentItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        val holder = CommentViewHolder(viewBinding).apply {
            initViewHolder(this)
        }
        return holder
    }

    class CommentViewHolder(val rootView: MyPageCommentItemBinding): BaseViewHolder<MyCommentDTO>(rootView.root) {
        override fun bind(data: MyCommentDTO) {
            super.bind(data)

            rootView.apply {
                content.text = data.content
                val dateTime = DateFormatter.instance.fullDotted().parse(data.date)
                date.text = DateFormatter.instance.dateBarFormatter().format(dateTime)

                when(data.type) {
                    BoardType.MARKET-> {
                        boardIcon.setBackgroundResource(R.drawable.icon_campus_board_market)
                        boardName.text = itemView.context.getString(R.string.campus_board_title_market)
                    }

                    BoardType.GATHER-> {
                        boardIcon.setBackgroundResource(R.drawable.icon_campus_board_gather)
                        boardName.text = itemView.context.getString(R.string.campus_board_title_gather)
                    }

                    BoardType.TALK-> {
                        boardIcon.setBackgroundResource(R.drawable.icon_campus_board_talk)
                        boardName.text = itemView.context.getString(R.string.campus_board_title_talk)
                    }

                    BoardType.HELP-> {
                        boardIcon.setBackgroundResource(R.drawable.icon_campus_board_help)
                        boardName.text = itemView.context.getString(R.string.campus_board_title_help)
                    }

                    else -> {
                        boardIcon.setBackgroundResource(0)
                        boardName.text = ""
                    }
                }
            }
        }
    }
}
