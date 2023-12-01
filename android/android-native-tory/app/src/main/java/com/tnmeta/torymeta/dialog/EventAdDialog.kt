package com.tnmeta.torymeta.dialog

import android.app.AlertDialog
import android.app.Dialog
import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.EventAdDialogBinding
import com.tnmeta.torymeta.databinding.EventPageItemBinding
import com.tnmeta.torymeta.model.dto.EventBanner
import timber.log.Timber


/**
 * EventAdDialog
 */
object EventAdDialog {
    private const val THEME_ID = R.style.AppTheme_Dialog

    class Builder(val context: Context) {

        private val viewBinding = EventAdDialogBinding.inflate(LayoutInflater.from(context))

        private var builder: AlertDialog.Builder = AlertDialog.Builder(context, THEME_ID).apply {

            viewBinding.apply {
                setCancelable(false)
                setView(root)
            }
        }
        private var dialog: AlertDialog? = null
        lateinit var onClickListener: ((Any) -> Unit)

        init {
            viewBinding.apply {
                close.setOnClickListener {
                    dialog?.dismiss()
                }
            }
        }

        fun setCancelable(cancelable: Boolean): Builder {
            builder.setCancelable(cancelable)
            return this
        }


        fun show() {
            dialog = builder.show()
        }

        fun dismiss() {
            dialog?.dismiss()
        }


        fun initPager(pageDatas : List<EventBanner>) = viewBinding.apply {
            viewPager.adapter = PagerAdapter(pageDatas,
                onClickItemListener = { data ->
                    onClickListener(data)
                    //dialog?.dismiss()
                }
            )
            indicator.setViewPager(viewPager)
        }


        inner class PagerAdapter(private val pageData: List<EventBanner>, val onClickItemListener: (EventBanner) -> Unit): RecyclerView.Adapter<PagerAdapter.PagerViewHolder>() {
            override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PagerViewHolder {
                val binding = EventPageItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                return PagerViewHolder(binding)
            }

            override fun onBindViewHolder(holder: PagerViewHolder, position: Int) {
                try {
                    val dataInfo = pageData[position]
                    holder.run {
                        bind(dataInfo)
                        itemView.setOnClickListener {
                            onClickItemListener(dataInfo)
                        }
                    }

                }catch (e : Exception){
                    Timber.d(e.message)
                }
            }

            override fun getItemCount(): Int = pageData.size

            inner class PagerViewHolder(val rootView: EventPageItemBinding): RecyclerView.ViewHolder(rootView.root) {
                fun bind(data: EventBanner) {
                    rootView.apply {
                        Glide.with(context)
                        .load(data.bannerImageUrl)
                        .into(eventImage)
                    }
                }
            }
        }
    }
}