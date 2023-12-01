package com.tnmeta.torymeta.my_page


import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.google.android.material.tabs.TabLayoutMediator
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.ApiMode
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.my_page.profile.ProfileActivity
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.web.ToryWebActivity
import com.tnmeta.torymeta.web.Web
import com.tnmeta.torymeta.databinding.FragmentMyPageBinding
import com.tnmeta.torymeta.databinding.MyPageBottomSheetBinding
import com.tnmeta.torymeta.dialog.CommonDialogInterface
import com.tnmeta.torymeta.dialog.TutorialDialogFragment
import com.tnmeta.torymeta.intro.UniversitySelectActivity
import com.tnmeta.torymeta.model.SeminarStatus
import com.tnmeta.torymeta.model.dto.MyCommentDTO
import com.tnmeta.torymeta.model.dto.MyWriteDTO
import com.tnmeta.torymeta.my_page.mileage.MileagePointTransactionHistoryActivity
import com.tnmeta.torymeta.my_page.tory.ToryChargeActivity
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.text.DecimalFormat

class MyPageFragment: BaseFragment(), View.OnClickListener {
    companion object {
        fun newInstance() =
            MyPageFragment().apply {
            }
    }

    private lateinit var viewBinding: FragmentMyPageBinding
    private lateinit var viewModel: MyPageViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = FragmentMyPageBinding.inflate(inflater, container, false)
        viewModel = ViewModelProvider(this)[MyPageViewModel::class.java]

        return viewBinding.root
    }

    override fun onResume() {
        super.onResume()

        viewModel.apply {
            updatePoint()
            getMyWriteList()
            getMyCommentList()
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewBinding.apply {

            if(!repository.getMyPageTutorial()) {
                TutorialDialogFragment.TutorialDialogBuilder(childFragmentManager).apply {
                    setBackgroundResource(R.drawable.mypage_tutorial)
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

                // 알림 클릭
//                noticeBtn.setOnClickListener {
//                    if(Constants.is_FirebaseAnalytics) {
//                        firebaseAnalyticsMember(FirebaseParam.mobile_notice)
//                    }
//
//                    Intent(context, ToryWebActivity::class.java).run {
//                        putExtra(ToryWebActivity.PARAM_URL, Web.Url.NOTICE)
//                        startActivity(this)
//                    }
//                }

                // 설정 클릭
                settingBtn.setOnClickListener {
                    if(Constants.is_FirebaseAnalytics) {
                        firebaseAnalyticsMember(FirebaseParam.mobile_setting)
                    }

                    Intent(context, ToryWebActivity::class.java).run {
                        putExtra(ToryWebActivity.PARAM_URL, Web.Url.SETTING)
                        startActivity(this)
                    }
                }

                // 충전 클릭
                chargeBtn.setOnClickListener {
                    Intent(context, ShopActivity::class.java).run {
                        startActivity(this)
                    }
                }

                // 프로필 클릭
                profileImg.setOnClickListener {
                    Intent(context, ProfileActivity::class.java).run {
                        startActivity(this)
                    }
                }

                // 포인트 클릭
                pointRightArrow.setOnClickListener {
                    Intent(context, ToryChargeActivity::class.java).run {
                        viewModel.point.observe(viewLifecycleOwner) { point ->
                            putExtra(ToryChargeActivity.TORY_CHARGE_VALUE, point.point)
                        }
                        startActivity(this)
                    }
                }

                // 마일리지 클릭
                mileageRightArrow.setOnClickListener {
                    Intent(context, MileagePointTransactionHistoryActivity::class.java).run {
                        viewModel.point.observe(viewLifecycleOwner) { point ->
                            putExtra(MileagePointTransactionHistoryActivity.MILEAGE_POINT_VALUE, point.mileage)
                        }
                        startActivity(this)
                    }
                }

                // 포인트 설명 클릭
                pointInfoBtn.setOnClickListener {
                    CommonBottomSheet.createInRootView(requireActivity()).apply {
                        val viewBinding = MyPageBottomSheetBinding.inflate(LayoutInflater.from(rootView.context), rootView, false).apply {
                            title.text = getString(R.string.my_page_tory_point_info_title)
                            desc.text = getString(R.string.my_page_tory_point_info_desc)
                        }

                        commonBottomSheetBinding.content.addView(viewBinding.root)

                    }.show()
                }

                // 마일리지 설명 클릭
                mileageInfoBtn.setOnClickListener {
                    CommonBottomSheet.createInRootView(requireActivity()).apply {
                        val viewBinding = MyPageBottomSheetBinding.inflate(LayoutInflater.from(rootView.context), rootView, false).apply {
                            title.text = getString(R.string.my_page_mileage_info_title)
                            desc.text = getString(R.string.my_page_mileage_info_desc)
                        }
                        commonBottomSheetBinding.content.addView(viewBinding.root)
                    }.show()
                }

                campusTitle.setOnClickListener(this@MyPageFragment)
            }
        }
    }

    /**
     * 멤버 UI를 초기화합니다
     */
    private fun initMemberUI() = viewBinding.apply{
        viewModel.apply {
            member.observe(viewLifecycleOwner) { data ->
                campusTitle.text = viewModel.getCampus(data.universityCode).universityName
                nickname.text = data.profileName

                // update profile
                if( data.imgUrl.isNotEmpty() ) {
                    Glide.with(requireContext())
                        .load(data.imgUrl)
                        .circleCrop()
                        .into(profileImg)
                }
            }

            point.observe(viewLifecycleOwner) { point ->
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
            Intent(context, ToryWebActivity::class.java).run {
                putExtra(ToryWebActivity.PARAM_URL, Web.Url.getWirteDetailUrl(data))
                startActivity(this)
            }
        }

        val commentAdapter = CommentAdapter(myCommentList)
        commentAdapter.onClickCellListener = { data ->
            Intent(context, ToryWebActivity::class.java).run {
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
        viewModel.myWirteList.observe(viewLifecycleOwner) { list ->
            this@MyPageFragment.myWirteList.apply {
                clear()
                addAll(list)
            }
            pagerAdapter.notifyDataSetChanged()
        }

        viewModel.myCommentList.observe(viewLifecycleOwner) { list ->
            this@MyPageFragment.myCommentList.apply {
                clear()
                addAll(list)
            }

            pagerAdapter.notifyDataSetChanged()
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.campusTitle -> {
                Intent(requireActivity(), UniversitySelectActivity::class.java).run {
                    startActivity(this)
                }
            }
        }
    }
}