package com.tnmeta.torymeta.dialog

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.*
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.google.android.material.bottomsheet.BottomSheetBehavior.STATE_EXPANDED
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.campus.PedometerActivity
import com.tnmeta.torymeta.databinding.EventBottomDialogBinding
import com.tnmeta.torymeta.databinding.EventListItemBinding
import com.tnmeta.torymeta.model.dto.BoardDTO
import com.tnmeta.torymeta.model.dto.EventDTO
import com.tnmeta.torymeta.model.dto.EventListDTO
import com.tnmeta.torymeta.model.dto.UniversityDTO
import com.tnmeta.torymeta.web.ToryWebActivity
import com.tnmeta.torymeta.web.Web
import timber.log.Timber

class EventBottomDialogFragment(context: Context, eventArray : ArrayList<EventListDTO>) : BottomSheetDialogFragment(), View.OnClickListener {

    private val mContext: Context = context
    private var viewBinding : EventBottomDialogBinding? = null

    private var eventArray : ArrayList<EventListDTO> = eventArray
    private lateinit var mAdapter: RecyclerViewAdapter

    lateinit var onClickListener: ((Any) -> Unit)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = EventBottomDialogBinding.inflate(inflater, container, false)
        return viewBinding!!.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        (dialog as? BottomSheetDialog)?.behavior?.state = STATE_EXPANDED

        dialog!!.window!!.attributes.windowAnimations = R.style.BottomSheetDialogAnimation
        viewBinding!!.apply {
            close.setOnClickListener {
                dialog?.dismiss()
            }

            mAdapter = RecyclerViewAdapter(eventArray,
                onClickItemListener = { data ->
                    onClickListener(data)
                    dismiss()
                })

            recyclerView.apply {
                layoutManager = LinearLayoutManager(mContext)
                adapter = mAdapter
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


    inner class RecyclerViewAdapter(private val eventArray: ArrayList<EventListDTO>, val onClickItemListener: (EventListDTO) -> Unit) : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = eventArray.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = EventListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val eventInfo = eventArray!![position]
                holder.run {
                    bind(eventInfo)

                    itemView.setOnClickListener {
                        dialog?.dismiss()
                        onClickItemListener(eventInfo)
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: EventListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: EventListDTO) {
                with(viewBinding) {
                    item.run {
                        Glide.with(viewBinding.root)
                            .load(item.bannerImageUrl)
                            .into(eventImage)
                    }
                }
            }
        }
    }

}