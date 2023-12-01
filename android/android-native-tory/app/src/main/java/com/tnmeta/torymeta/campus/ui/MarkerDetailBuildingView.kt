package com.tnmeta.torymeta.campus.ui

import android.app.Activity
import android.view.LayoutInflater
import android.view.ViewGroup
import com.tnmeta.torymeta.databinding.MarkerDetailBuildingViewBinding
import com.tnmeta.torymeta.model.dto.MarkerDetailDTO
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import com.tnmeta.torymeta.ui.CommonBottomSheet


class MarkerDetailBuildingView(private val activity: Activity, private val data: MarkerDetailDTO)
    : CommonBottomSheet(activity.getContentView() as ViewGroup) {

    init {

        val viewBinding = MarkerDetailBuildingViewBinding.inflate(LayoutInflater.from(rootView.context), rootView, false).apply {
            title.text = data.placeName
            address.text = data.addressName
        }

        commonBottomSheetBinding.content.addView(viewBinding.root)

    }
}