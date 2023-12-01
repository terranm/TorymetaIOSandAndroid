package com.tnmeta.torymeta.talk

import android.app.Activity
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.ChattingPeopleBoardViewBinding
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView


class ChattingPeopleView (private val activity: Activity, var onClickListener: (Any) -> Unit)
    : CommonBottomSheet(activity.getContentView() as ViewGroup) {


    val viewBinding = ChattingPeopleBoardViewBinding.inflate(LayoutInflater.from(rootView.context), rootView, false)

    init {
        commonBottomSheetBinding.content.addView(viewBinding.root, 1)
        initList()

        viewBinding.inviteBtn.setOnClickListener {
            onClickListener(R.id.inviteBtn)
            dismiss()
        }
    }


    private fun initList() {

        viewBinding.recyclerView.apply {
            layoutManager = LinearLayoutManager(rootView.context)

            /*
            adapter = BoardSelectView.ListAdapter(BoardSelectView.Companion.SizeInfo.itemSize, { data ->
                onClickListener(data.url)
                dismiss()
            }, data)
            */

        }
    }

}
