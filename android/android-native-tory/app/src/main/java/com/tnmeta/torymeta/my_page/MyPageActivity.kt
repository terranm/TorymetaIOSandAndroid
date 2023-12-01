package com.tnmeta.torymeta.my_page

import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.DisplayMetrics
import android.view.LayoutInflater
import android.view.View
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContentProviderCompat.requireContext
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.google.android.material.tabs.TabLayoutMediator
import com.tnmeta.torymeta.BuildConfig
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityShopBinding
import com.tnmeta.torymeta.databinding.FragmentMyPageBinding
import com.tnmeta.torymeta.databinding.MyPageBottomSheetBinding
import com.tnmeta.torymeta.dialog.CommonDialogInterface
import com.tnmeta.torymeta.dialog.TutorialDialogFragment
import com.tnmeta.torymeta.intro.UniversitySelectActivity
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.dto.MyCommentDTO
import com.tnmeta.torymeta.model.dto.MyWriteDTO
import com.tnmeta.torymeta.model.param.InitVersion
import com.tnmeta.torymeta.my_page.mileage.MileagePointTransactionHistoryActivity
import com.tnmeta.torymeta.my_page.profile.ProfileActivity
import com.tnmeta.torymeta.my_page.tory.ToryChargeActivity
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.web.ToryWebActivity
import com.tnmeta.torymeta.web.Web
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.DecimalFormat

class MyPageActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH), View.OnClickListener {

    companion object {

        fun createIntent(context: Context): Intent {
            return Intent(context, MyPageActivity::class.java)
        }

        val TAG : String = MyPageActivity::class.java.simpleName
    }

    private val viewBinding by viewBinding(FragmentMyPageBinding::inflate)
    private lateinit var viewModel: MyPageViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {
                setContentView(root)
                viewModel = ViewModelProvider(this@MyPageActivity)[MyPageViewModel::class.java]

                val display = this@MyPageActivity.applicationContext?.resources?.displayMetrics
                val deviceWidth = display?.widthPixels

                val imgResource = if (deviceWidth!! <= 904) {
                    R.drawable.mypage_tutorial_small
                } else if (deviceWidth <= 1080) {
                    R.drawable.mypage_tutorial_normal
                } else {
                    R.drawable.mypage_tutorial_411
                }

                if (!repository.getMyPageTutorial()) {
                    TutorialDialogFragment.TutorialDialogBuilder(supportFragmentManager).apply {
                        setBackgroundResource(imgResource)
                        setClickListener(object : CommonDialogInterface.OnClickListener {
                            override fun onClick(i: Int) {
                                when (i) {
                                    R.id.close -> {
                                        repository.setMyPageTutorial(true)
                                    }
                                }
                            }
                        })
                    }.show()
                }

                CoroutineScope(Dispatchers.Main).launch {
                    initMemberUI()
                    initWriteList()

                    // 설정 클릭
                    settingBtn.setOnClickListener {
                        if (Constants.is_FirebaseAnalytics) {
                            firebaseAnalyticsMember(FirebaseParam.mobile_setting)
                        }

                        Intent(this@MyPageActivity, ToryWebActivity::class.java).run {
                            putExtra(ToryWebActivity.PARAM_URL, Web.Url.SETTING)
                            startActivity(this)
                        }
                    }

                    // 충전 클릭
                    chargeBtn.setOnClickListener {
                        Intent(this@MyPageActivity, ShopActivity::class.java).run {
                            startActivity(this)
                        }
                    }

                    // 프로필 클릭
                    profileImg.setOnClickListener {
                        Intent(this@MyPageActivity, ProfileActivity::class.java).run {
                            startActivity(this)
                        }
                    }

                    // 포인트 설명 클릭
                    pointInfoBtn.setOnClickListener {
                        CommonBottomSheet.createInRootView(this@MyPageActivity).apply {
                            val viewBinding = MyPageBottomSheetBinding.inflate(LayoutInflater.from(rootView.context), rootView, false).apply {
                                title.text = getString(R.string.my_page_tory_point_info_title)
                                desc.text = getString(R.string.my_page_tory_point_info_desc)
                            }

                            commonBottomSheetBinding.content.addView(viewBinding.root)

                        }.show()
                    }

                    // 마일리지 설명 클릭
                    mileageInfoBtn.setOnClickListener {
                        CommonBottomSheet.createInRootView(this@MyPageActivity).apply {
                            val viewBinding = MyPageBottomSheetBinding.inflate(LayoutInflater.from(rootView.context), rootView, false).apply {
                                title.text = getString(R.string.my_page_mileage_info_title)
                                desc.text = getString(R.string.my_page_mileage_info_desc)
                            }
                            commonBottomSheetBinding.content.addView(viewBinding.root)
                        }.show()
                    }

                    close.setOnClickListener {
                        finish()
                    }

                    campusTitleLayout.setOnClickListener(this@MyPageActivity)
                    pointLayout.setOnClickListener {
                        Intent(this@MyPageActivity, ToryChargeActivity::class.java).run {
                            viewModel.point.observe(this@MyPageActivity) { point ->
                                putExtra(ToryChargeActivity.TORY_CHARGE_VALUE, point.point)
                            }
                            startActivity(this)
                        }
                    }

                    mileageLayout.setOnClickListener {
                        Intent(this@MyPageActivity, MileagePointTransactionHistoryActivity::class.java).run {
                            viewModel.point.observe(this@MyPageActivity) { point ->
                                putExtra(MileagePointTransactionHistoryActivity.MILEAGE_POINT_VALUE, point.mileage)
                            }
                            startActivity(this)
                        }
                    }
                }
            }
        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }

    override fun onResume() {
        super.onResume()
        try {
            if(this::viewModel.isInitialized) {
                viewModel.apply {
                    updatePoint()
                    getMyWriteList()
                    getMyCommentList()
                }
            }else {
                viewModel = ViewModelProvider(this@MyPageActivity)[MyPageViewModel::class.java]
                viewModel.apply {
                    updatePoint()
                    getMyWriteList()
                    getMyCommentList()
                }
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    private fun initMemberUI() = viewBinding.apply{
        viewModel.apply {
            member.observe(this@MyPageActivity) { data ->

                campusTitle.text = if(member.value!!.certUniYn == 0) resources.getString(R.string.university_uncertified)
                                    else viewModel.getCampus(data.universityCode).universityName

                nickname.text = data.profileName

                // update profile
                if( data.imgUrl.isNotEmpty() ) {
                    Glide.with(this@MyPageActivity)
                        .load(data.imgUrl)
                        .circleCrop()
                        .into(profileImg)
                }
            }

            point.observe(this@MyPageActivity) { point ->
                pointTextView.text = getString(R.string.my_page_point_format_01, "${DecimalFormat("#,###").format(point.point)}")
                mileageTextView.text = getString(R.string.my_page_mileage_format_01, "${DecimalFormat("#,###").format(point.mileage)}")

            }
        }
    }

    /**
     * 작성 글 목록을 초기화합니다
     */
    private val myWirteList = ArrayList<MyWriteDTO>()
    private val myCommentList = ArrayList<MyCommentDTO>()

    private fun initWriteList() = viewBinding.apply{
        // 내가 쓴 글 어댑터 초기화
        val writeAdapter = WriteAdapter(myWirteList)
        writeAdapter.onClickCellListener = { data ->
            Intent(this@MyPageActivity, ToryWebActivity::class.java).run {
                putExtra(ToryWebActivity.PARAM_URL, Web.Url.getWirteDetailUrl(data))
                startActivity(this)
            }
        }

        val commentAdapter = CommentAdapter(myCommentList)
        commentAdapter.onClickCellListener = { data ->
            Intent(this@MyPageActivity, ToryWebActivity::class.java).run {
                putExtra(ToryWebActivity.PARAM_URL, Web.Url.getCommentDetailUrl(data))
                startActivity(this)
            }
        }

        // 내가 쓴 글 / 내가 쓴 댓글 ViewPager 초기화
        val pagerAdapter = WritePagerAdapter(listOf(writeAdapter, commentAdapter) as List<RecyclerView.Adapter<RecyclerView.ViewHolder>>)
        writePager.adapter = pagerAdapter

        writeTabs.apply {
            val titles = listOf(R.string.my_page_write_title, R.string.my_page_comment_title)

            TabLayoutMediator(this, writePager) { tab, position ->
                tab.text = getString(titles[position])
            }.attach()
        }

        // 데이터 변경 시 리스트 업데이트
        viewModel.myWirteList.observe(this@MyPageActivity) { list ->
            this@MyPageActivity.myWirteList.apply {
                clear()
                addAll(list)
            }
            pagerAdapter.notifyDataSetChanged()
        }

        viewModel.myCommentList.observe(this@MyPageActivity) { list ->

            this@MyPageActivity.myCommentList.apply {
                clear()
                addAll(list)
            }

            pagerAdapter.notifyDataSetChanged()
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.campusTitle_layout -> {

                if(repository.member.value!!.certUniYn != 0) {
                    Intent(this@MyPageActivity, UniversitySelectActivity::class.java).run {
                        startActivity(this)
                    }
                }else {
                    CommonAlertDialog.Builder(this)
                        .setCancelable(false)
                        .setMessage(resources.getString(R.string.certification_message))
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                            univSelectLauncher.launch(Intent(this, UniversitySelectActivity::class.java))
                        }
                        .setNegativeButton(R.string.system_alert_btn_cancel) {}
                        .show()
                }
            }
        }
    }


    private val univSelectLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == RESULT_OK) {

            val params = BaseParam(InitVersion(BuildConfig.VERSION_NAME, Build.MODEL, Build.VERSION.RELEASE, Constants.BannerType)).parameter

            repository.initData(params).subscribeBy(onNext = {
                toryApplication.apply {
                    initIAB(repository.toryItemList)
                }
            }, onError = {})
        }

    }

}