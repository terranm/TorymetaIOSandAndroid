package com.tnmeta.torymeta.intro

import android.content.Context
import android.content.Intent
import android.graphics.Paint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.google.firebase.analytics.FirebaseAnalytics
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityOnboardingBinding
import com.tnmeta.torymeta.databinding.OnboardingPageItemBinding
import com.tnmeta.torymeta.model.PageData
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getDrawableResId
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getStringResId
import com.tnmeta.torymeta.web.ToryWebActivity
import com.tnmeta.torymeta.web.Web
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch


/**
 * 온보딩 화면
 */
class OnboardingActivity: BaseActivity() {
    companion object {
        const val RE_LOGIN = "_RE_LOGIN_"

    }

    private val pageCount = 3
    private val pageDatas: List<PageData> by lazy {
        val list = ArrayList<PageData>()

        for( i in 0 until pageCount ) {
            list.add(
                PageData(
                    //getStringResId(String.format("onboarding_header_%02d", i+1)),
                    getDrawableResId(String.format("onboarding_title_%02d", i+1)),
                    getStringResId(String.format("onboarding_desc_%02d", i+1)),
                    getDrawableResId(String.format("onboarding_page_%02d", i+1))
                )
            )
        }
        list
    }

    private val viewBinding by viewBinding(ActivityOnboardingBinding::inflate)

    private val webLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(
        ActivityResultContracts.StartActivityForResult()) {
        setResult(it.resultCode)
        finish()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.run {
            setContentView(root)

            if(intent.hasExtra(RE_LOGIN)) {
                val intent = Intent(this@OnboardingActivity, ToryWebActivity::class.java).apply {
                    putExtra(ToryWebActivity.PARAM_URL, Web.Url.LOGIN)
                }
                webLauncher.launch(intent)
            }

            CoroutineScope(Dispatchers.Main).launch {

                initPager()

                // 시작하기 클릭
                startBtn.setOnClickListener {
                    val intent = Intent(this@OnboardingActivity, ToryWebActivity::class.java).apply {
                        putExtra(ToryWebActivity.PARAM_URL, Web.Url.LOGIN)
                    }
                    webLauncher.launch(intent)
                }

                // 로그인하기 클릭
                loginBtn.setOnClickListener {
                    Toast.makeText(this@OnboardingActivity, "로그인하기", Toast.LENGTH_SHORT).show()
                }

                loginBtn.apply {
                    // 밑줄 추가
                    paintFlags = Paint.UNDERLINE_TEXT_FLAG
                }
            }
        }
    }

    override fun onBackPressed() {
        // 백키 무시
    }

    /**
     * ViewPager를 초기화합니다
     */
    inner class PagerAdapter(private val pageData: List<PageData>): RecyclerView.Adapter<PagerAdapter.PagerViewHolder>() {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PagerViewHolder {
            val binding = OnboardingPageItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return PagerViewHolder(binding)
        }

        override fun onBindViewHolder(holder: PagerViewHolder, position: Int) {
            holder.bind(pageData[position])
        }

        override fun getItemCount(): Int = pageData.size

        inner class PagerViewHolder(val rootView: OnboardingPageItemBinding): RecyclerView.ViewHolder(rootView.root) {
            fun bind(data: PageData) {
                rootView.apply {
                    //headerView = root.context.getString(data.headerId)

                    headerView.setBackgroundResource(data.headerId)

                    //descView.text = root.context.getString(data.descId)
                    icon.setBackgroundResource(data.imgId)

                    // 이미지 ratio 유지
                    val ratio: Float = icon.background.minimumHeight.toFloat() / icon.background.minimumWidth.toFloat()
                    val lp = icon.layoutParams as ConstraintLayout.LayoutParams
                    lp.dimensionRatio = "1:${ratio}"
                }
            }
        }
    }

    private fun initPager() = viewBinding.apply {
        viewPager.adapter = PagerAdapter(pageDatas)
        indicator.setViewPager(viewPager)
    }
}