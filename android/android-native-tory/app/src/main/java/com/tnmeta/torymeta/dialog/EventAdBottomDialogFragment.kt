package com.tnmeta.torymeta.dialog

import android.content.Context
import android.content.DialogInterface
import android.content.pm.ActivityInfo
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.GranularRoundedCorners
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.EventAdBottomDialogFragmentBinding
import com.tnmeta.torymeta.databinding.EventAdPageItemBinding
import com.tnmeta.torymeta.databinding.EventPageItemBinding
import com.tnmeta.torymeta.model.dto.EventBanner
import timber.log.Timber


class EventAdBottomDialogFragment(private val context: Context,
                                  private val itemArray : ArrayList<EventBanner>,
                                  private val onButtonClick : (View) -> Unit,
                                  private val onItemViewClick : (EventBanner) -> Unit) : BottomSheetDialogFragment(), View.OnClickListener {

    private var viewBinding : EventAdBottomDialogFragmentBinding? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(DialogFragment.STYLE_NORMAL, R.style.TransParentBottomSheetDialogTheme)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = EventAdBottomDialogFragmentBinding.inflate(inflater, container, false)
        return viewBinding!!.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        (dialog as? BottomSheetDialog)?.behavior?.state = BottomSheetBehavior.STATE_EXPANDED
        viewBinding!!.apply {
            viewPager.adapter = PagerAdapter(itemArray)
            if(itemArray.size <= 1) {
                indicator.visibility = View.INVISIBLE
            }

            indicator.setViewPager(viewPager)
            close.setOnClickListener {
                onButtonClick(close)
                dialog?.dismiss()
            }

            hideToday.setOnClickListener {
                onButtonClick(hideToday)
                dialog?.dismiss()
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        viewBinding = null
    }

    override fun onClick(view: View) {
        dialog?.dismiss()
    }





    inner class PagerAdapter(private val pageData: List<EventBanner>): RecyclerView.Adapter<PagerAdapter.PagerViewHolder>() {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PagerViewHolder {
            val binding = EventAdPageItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return PagerViewHolder(binding)
        }

        override fun onBindViewHolder(holder: PagerViewHolder, position: Int) {
            try {
                val dataInfo = pageData[position]
                holder.run {
                    bind(dataInfo)
                    itemView.setOnClickListener {
                        onItemViewClick(dataInfo)
                        dialog?.dismiss()
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        override fun getItemCount(): Int = pageData.size

        inner class PagerViewHolder(val rootView: EventAdPageItemBinding): RecyclerView.ViewHolder(rootView.root) {
            fun bind(data: EventBanner) {
                rootView.apply {
                    Glide.with(context)
                        .load(data.bannerImageUrl)
                        .transform(CenterCrop(), GranularRoundedCorners(60.0f, 60.0f, 0.0f, 0.0f))
                        .into(eventImage)
                }
            }
        }
    }
}