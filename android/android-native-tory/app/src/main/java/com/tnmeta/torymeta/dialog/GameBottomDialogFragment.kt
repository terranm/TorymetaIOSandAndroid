package com.tnmeta.torymeta.dialog

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.GameBottomDialogFragmentBinding
import com.tnmeta.torymeta.databinding.GameListItemBinding
import com.tnmeta.torymeta.model.dto.GameDTO
import com.tnmeta.torymeta.web.ToryWebActivity
import timber.log.Timber

class GameBottomDialogFragment(gameInfoArray : ArrayList<GameDTO>) : BottomSheetDialogFragment(), View.OnClickListener {

    private var eventArray : ArrayList<GameDTO> = gameInfoArray
    private lateinit var viewBinding : GameBottomDialogFragmentBinding
    private lateinit var mAdapter: RecyclerViewAdapter
    private val listSpanCount = 2

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = GameBottomDialogFragmentBinding.inflate(inflater, container, false)
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        (dialog as? BottomSheetDialog)?.behavior?.state = BottomSheetBehavior.STATE_EXPANDED

        dialog!!.window!!.attributes.windowAnimations = R.style.BottomSheetDialogAnimation
        viewBinding.apply {
            mAdapter = RecyclerViewAdapter()
            recyclerView.apply {
                layoutManager = GridLayoutManager(context, listSpanCount)
                adapter = mAdapter

            }
        }
    }

    override fun onClick(view: View) {
        dialog?.dismiss()
    }


    inner class RecyclerViewAdapter : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = eventArray.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = GameListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            binding.root.layoutParams.apply {
            }
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val itemValue = eventArray!![position]
                holder.run {
                    bind(itemValue)

                    itemView.setOnClickListener {
                        dialog?.dismiss()
                        val url = itemValue.gameUrl
                        Intent(context, ToryWebActivity::class.java).run {
                            putExtra(ToryWebActivity.PARAM_URL, url)
                            startActivity(this)
                        }
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: GameListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: GameDTO) {
                with(viewBinding) {
                    item.run {
                        Glide.with(viewBinding.root)
                            .load(item.gameImgUrl)
                            .transform(CenterCrop(), RoundedCorners(5))
                            .into(eventImage)
                    }
                }
            }
        }
    }

}