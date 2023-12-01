package com.tnmeta.torymeta.dialog

import android.annotation.SuppressLint
import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.campus.ToryAvatarProfileFragment
import com.tnmeta.torymeta.databinding.BuyItemsBottomDialogFragmentBinding
import com.tnmeta.torymeta.databinding.BuyListItemBinding
import com.tnmeta.torymeta.databinding.EventBottomDialogBinding
import com.tnmeta.torymeta.databinding.EventListItemBinding
import com.tnmeta.torymeta.model.dto.EventDTO
import com.tnmeta.torymeta.model.dto.myAvatar.AvataModel
import timber.log.Timber


class BuyItemsBottomDialogFragment(private val context: Context,
                                    private val itemArray : ArrayList<AvataModel>) : BottomSheetDialogFragment(), View.OnClickListener {

    companion object {
        val TAG : String = BuyItemsBottomDialogFragment::class.java.simpleName
        private const val LIST_SPAN_COUNT = 4
    }

    private var viewBinding : BuyItemsBottomDialogFragmentBinding? = null
    private lateinit var mAdapter: RecyclerViewAdapter


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = BuyItemsBottomDialogFragmentBinding.inflate(inflater, container, false)
        return viewBinding!!.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        (dialog as? BottomSheetDialog)?.behavior?.state = BottomSheetBehavior.STATE_EXPANDED
        viewBinding!!.apply {
            mAdapter = RecyclerViewAdapter(itemArray,
                onClickItemListener = { data ->
                })

            recyclerView.apply {
                layoutManager = GridLayoutManager(requireContext(), LIST_SPAN_COUNT)
                adapter = mAdapter
            }
            mAdapter.notifyDataSetChanged()
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        viewBinding = null
    }

    override fun onClick(view: View) {
        dialog?.dismiss()
    }


    inner class RecyclerViewAdapter(private val itemArray: ArrayList<AvataModel>, val onClickItemListener: (AvataModel) -> Unit) : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = itemArray.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = BuyListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val categoryInfo = itemArray!![position]
                holder.run {
                    Timber.tag(TAG).d("image Url ${categoryInfo.imgUrl}")
                    bind(categoryInfo)

                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: BuyListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: AvataModel) {
                with(viewBinding) {
                    item.run {
                        Glide.with(root)
                            .load(imgUrl)
                            .centerCrop()
                            .into(viewBinding.avatar)
                    }
                }
            }
        }
    }

}