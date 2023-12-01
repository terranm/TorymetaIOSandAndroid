package com.tnmeta.torymeta.dialog

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.SortFilterBottomDialogFragmentBinding
import com.tnmeta.torymeta.model.unity.avatar.AvatarCategorySortyType

class SortFilterBottomDialogFragment(context: Context, sortType: AvatarCategorySortyType) : BottomSheetDialogFragment(), View.OnClickListener {

    private val mContext: Context = context
    private var viewBinding : SortFilterBottomDialogFragmentBinding? = null

    lateinit var onClickListener: ((Any) -> Unit)
    private var  mSortType = sortType

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = SortFilterBottomDialogFragmentBinding.inflate(inflater, container, false)
        return viewBinding!!.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        (dialog as? BottomSheetDialog)?.behavior?.state = BottomSheetBehavior.STATE_EXPANDED

        dialog!!.window!!.attributes.windowAnimations = R.style.BottomSheetDialogAnimation
        viewBinding!!.apply {
            close.setOnClickListener {
                onClickListener(mSortType)
                dialog?.dismiss()
            }

            arrayOf(sortBasic, sortPopularity, sortHigherPrice, sortLowestPrice, sortName).forEach {
                it.setOnClickListener(this@SortFilterBottomDialogFragment)
            }

            sortCheck(mSortType)
        }
    }


    override fun onDestroyView() {
        super.onDestroyView()
        viewBinding = null
    }

    override fun onClick(view: View) {
        viewBinding!!.apply {
            when(view.id) {
                R.id.sort_basic -> sortCheck(AvatarCategorySortyType.SORT_BASIC)

                R.id.sort_popularity -> sortCheck(AvatarCategorySortyType.SORT_POPULARITY)

                R.id.sort_higherPrice -> sortCheck(AvatarCategorySortyType.SORT_HIGHERPRICE)

                R.id.sort_lowestPrice -> sortCheck(AvatarCategorySortyType.SORT_LOWESTPRICE)

                R.id.sort_name -> sortCheck(AvatarCategorySortyType.SORT_NAME)
            }
        }
    }

    private fun sortCheck(sortType: AvatarCategorySortyType) = viewBinding!!.apply{
        arrayOf(sortBasic, sortPopularity, sortHigherPrice, sortLowestPrice, sortName).forEach {
            it.isChecked = false
        }

        val sort = arrayOf(sortBasic, sortPopularity, sortHigherPrice, sortLowestPrice, sortName)[sortType.origin]
        sort.isChecked = true

        mSortType = sortType
    }


}

