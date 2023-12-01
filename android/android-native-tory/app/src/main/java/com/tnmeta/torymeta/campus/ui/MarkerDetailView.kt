package com.tnmeta.torymeta.campus.ui

import android.app.Activity
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.findViewTreeLifecycleOwner
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.ApiMode
import com.tnmeta.torymeta.campus.viewmodel.CampusViewModel
import com.tnmeta.torymeta.databinding.MarkerDetailPersonViewBinding
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import com.tnmeta.torymeta.ui.CommonBottomSheet



class MarkerDetailView(private val activity: Activity, private val viewModel: CampusViewModel)
    : CommonBottomSheet(activity.getContentView() as ViewGroup) {
    
     private var viewBinding = MarkerDetailPersonViewBinding.inflate(LayoutInflater.from(rootView.context), rootView,  false) .apply {
         viewModel.apply {

         }
         nickname.text = viewModel.member.value!!.profileName
     }

    init {
        commonBottomSheetBinding.content.addView(viewBinding.root, 1)
        initProfile()
        initLocationToggle()
    }

    private fun initProfile() = viewBinding.apply {
        viewModel.member.value?.let {
            Glide.with(rootView)
                .load(it.imgUrl)
                .circleCrop()
                .into(profileImg)
        }
    }

    private fun initLocationToggle() = viewBinding.apply {
        val updateToggleImage: (Boolean)-> Unit = { isShared ->
                val resourcesID = if(isShared) R.drawable.campus_map_btn_location_on
                                    else R.drawable.campus_map_btn_location_off

                locationToggleBtn.setBackgroundResource(resourcesID)
            }

        updateToggleImage(viewModel.member.value!!.isLocationShared)

        locationToggleBtn.setOnClickListener {
            val isShared = !viewModel.member.value!!.isLocationShared
            viewModel.updateMyLocationShared(ApiMode.UIMode.NONE, isShared)
            val message = if(isShared) activity.resources.getString(R.string.my_position_share_message)
                            else activity.resources.getString(R.string.my_position_not_share_message)

            Toast.makeText(activity.applicationContext, message, Toast.LENGTH_SHORT).show()

        }

        viewModel.member.observe(viewBinding.root.findViewTreeLifecycleOwner()!!) {
            updateToggleImage(it.isLocationShared)
        }
    }

    override fun show(animationDuration: Long) {
        super.show(animationDuration)
    }

}