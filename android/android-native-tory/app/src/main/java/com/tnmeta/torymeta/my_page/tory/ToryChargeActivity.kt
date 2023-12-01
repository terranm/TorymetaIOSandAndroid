package com.tnmeta.torymeta.my_page.tory

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import com.google.android.material.tabs.TabLayoutMediator
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityToryChargeBinding
import com.tnmeta.torymeta.databinding.MyPageBottomSheetBinding
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.my_page.ShopActivity
import com.tnmeta.torymeta.ui.CommonBottomSheet
import java.text.DecimalFormat


class ToryChargeActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH), View.OnClickListener {

    companion object {
        const val  TORY_CHARGE_VALUE     = "_TORY_CHARGE_VALUE_"
    }

    private val tabTitleArray : Array<String> by lazy {
        arrayOf(
            getString(R.string.charge_history),
            getString(R.string.transaction_history)
        )
    }

    private val viewBinding by viewBinding(ActivityToryChargeBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, R.string.tory_point_title_history)
            setTopBarBackButtonEnabled(viewBinding.topBar, true) {
                finish()
            }

            if(intent.hasExtra(TORY_CHARGE_VALUE)) {
                val toryValue = intent.getIntExtra(TORY_CHARGE_VALUE, 0)
                toryTextView.text =  getString(R.string.my_page_point_format_01, "${DecimalFormat("#,###").format(toryValue)}")
            }

            toryInfoBtn.setOnClickListener(this@ToryChargeActivity)
            chargeBtn.setOnClickListener(this@ToryChargeActivity)

            viewPager.adapter = ViewPagerAdapter(supportFragmentManager, lifecycle)
            TabLayoutMediator(tabLayout, viewPager) { tab, position ->
                tab.text = tabTitleArray[position]
            }.attach()

        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.toryInfoBtn -> {
                CommonBottomSheet.createInRootView(this).apply {
                    val binding = MyPageBottomSheetBinding.inflate(LayoutInflater.from(rootView.context), rootView, false).apply {
                        title.text = getString(R.string.my_page_tory_point_info_title)
                        desc.text = getString(R.string.my_page_tory_point_info_desc)
                    }
                    commonBottomSheetBinding.content.addView(binding.root)

                }.show()
            }

            R.id.chargeBtn -> {
                Intent(this, ShopActivity::class.java).run {
                    startActivity(this)
                }
            }
        }
    }

}