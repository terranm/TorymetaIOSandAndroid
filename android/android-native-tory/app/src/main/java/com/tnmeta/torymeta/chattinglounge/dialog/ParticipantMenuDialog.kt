package com.tnmeta.torymeta.chattinglounge.dialog

import android.annotation.SuppressLint
import android.app.AlertDialog
import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.chattinglounge.model.MenuType
import com.tnmeta.torymeta.chattinglounge.model.ParticipantMenu
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.databinding.ParticipantmenudialogBinding
import com.tnmeta.torymeta.databinding.ParticipantsmenuListItemBinding
import com.tnmeta.torymeta.model.dto.EventDTO
import timber.log.Timber

/**
 * ParticipantMenuDialog
 */
object ParticipantMenuDialog {

    private const val THEME_ID = R.style.AppTheme_Dialog

    class Builder(val context: Context, private val roomOption : Boolean) {
        private val mMenuArrayList = ArrayList<ParticipantMenu>()

        private val viewBinding = ParticipantmenudialogBinding.inflate(LayoutInflater.from(context))

        lateinit var onClickListener: ((Any) -> Unit)

        private var builder: AlertDialog.Builder = AlertDialog.Builder(context, THEME_ID).apply {
            try {
                viewBinding.apply {
                    setCancelable(true)
                    setView(root)

                    val mAdapter = MenuRecyclerViewAdapter(
                        onClickItemListener = {
                            onClickListener(it)
                            dialog?.dismiss()
                        }
                    )
                    menuRecyclerView.apply {
                        layoutManager = LinearLayoutManager(context)
                        setDivider(R.drawable.menu_view_divider)
                        adapter = mAdapter
                    }
                    mAdapter.notifyDataSetChanged()
                }
            }catch (e : Exception){
                Timber.d("ParticipantMenuDialog $e.message")
            }
        }

        fun setCancelable(cancelable: Boolean): Builder {
            builder.setCancelable(cancelable)
            return this
        }

        private var dialog: AlertDialog? = null


        /**
         * MenuRecyclerViewAdapter
         */
        inner class MenuRecyclerViewAdapter(val onClickItemListener: (ParticipantMenu) -> Unit) : RecyclerView.Adapter<MenuRecyclerViewAdapter.RecycleViewHolder>() {
            override fun getItemCount(): Int = mMenuArrayList.size


            override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MenuRecyclerViewAdapter.RecycleViewHolder {
                val binding = ParticipantsmenuListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                return RecycleViewHolder(binding)
            }

            override fun onBindViewHolder(holder: MenuRecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
                try {
                    val itemValue = mMenuArrayList[position]

                    holder.run {
                        bind(itemValue)
                        itemView.setOnClickListener {
                            onClickItemListener(itemValue)
                        }
                    }

                }catch (e : Exception){
                    Timber.d(e.message)
                }
            }

            inner class RecycleViewHolder(private var viewBinding: ParticipantsmenuListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
                fun bind(item: ParticipantMenu) {
                    with(viewBinding) {
                        item.run {
                            icon.setBackgroundResource(iconResId)
                            title.apply {
                                text = itemView.context.getString(titleResId)
                                setTextColor(itemView.context.getColor(txtColor))
                            }
                        }
                    }
                }
            }
        }

        fun show() {
            if(roomOption) {
                mMenuArrayList.add(ParticipantMenu(MenuType.Kick, R.drawable.img_kick, R.string.participantMenu_kick, R.color.sub_red_2))
                mMenuArrayList.add(ParticipantMenu(MenuType.Mandate, R.drawable.img_mandate, R.string.participantMenu_mandate, R.color.color_e79447))
                mMenuArrayList.add(ParticipantMenu(MenuType.Silence, R.drawable.img_silence, R.string.participantMenu_silence, R.color.color_4b555f))
                mMenuArrayList.add(ParticipantMenu(MenuType.FriendRequest, R.drawable.img_friend_request, R.string.participantMenu_friend_request, R.color.tory_purple))

                //mMenuArrayList.add(ParticipantMenu(MenuType.Report, R.drawable.img_report, R.string.participantMenu_report, R.color.sub_red_2))

                mMenuArrayList.add(ParticipantMenu(MenuType.Warning, R.drawable.img_warning, R.string.participantMenu_warning, R.color.tory_yellow))

            }else {
                mMenuArrayList.add(ParticipantMenu(MenuType.Silence, R.drawable.img_silence, R.string.participantMenu_silence, R.color.color_4b555f))
                mMenuArrayList.add(ParticipantMenu(MenuType.FriendRequest, R.drawable.img_friend_request, R.string.participantMenu_friend_request, R.color.tory_purple))

                //mMenuArrayList.add(ParticipantMenu(MenuType.Report, R.drawable.img_report, R.string.participantMenu_report, R.color.sub_red_2))

                mMenuArrayList.add(ParticipantMenu(MenuType.Warning, R.drawable.img_warning, R.string.participantMenu_warning, R.color.tory_yellow))
            }
            dialog = builder.show()
        }
    }
}