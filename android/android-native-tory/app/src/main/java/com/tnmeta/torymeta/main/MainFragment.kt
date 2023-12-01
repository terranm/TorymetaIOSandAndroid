package com.tnmeta.torymeta.main

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.naver.maps.geometry.LatLng
import com.naver.maps.map.util.FusedLocationSource
import com.pnikosis.materialishprogress.ProgressWheel
import com.tnmeta.torymeta.BuildConfig
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.campus.CampusActivity
import com.tnmeta.torymeta.campus.PedometerActivity
import com.tnmeta.torymeta.campus.viewmodel.CampusViewModel
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import com.tnmeta.torymeta.chattinglounge.model.param.ChattingRoomListParam
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.SeminarStatus
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.databinding.FragmentMainBinding
import com.tnmeta.torymeta.dialog.CommonDialogInterface
import com.tnmeta.torymeta.dialog.NetworkErrorDialogFragment
import com.tnmeta.torymeta.intro.UniversitySelectActivity
import com.tnmeta.torymeta.main.adapter.ChattingRecyclerViewAdapter
import com.tnmeta.torymeta.main.adapter.EventPagerAdapter
import com.tnmeta.torymeta.main.adapter.LiveSeminarAdapter
import com.tnmeta.torymeta.main.adapter.MetaRecyclerViewAdapter
import com.tnmeta.torymeta.main.dialog.ProfileEditAlertDialog
import com.tnmeta.torymeta.main.model.ProfileNameParam
import com.tnmeta.torymeta.main.model.RoomInfoDto
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.avatar.info.AvatarState
import com.tnmeta.torymeta.model.unity.avatar.info.AvatarValue
import com.tnmeta.torymeta.model.dto.EventDTO
import com.tnmeta.torymeta.model.param.SeminarEnterParam
import com.tnmeta.torymeta.model.result.ApiResponse
import com.tnmeta.torymeta.my_page.MyPageActivity
import com.tnmeta.torymeta.seminar.CreateSeminarActivity
import com.tnmeta.torymeta.seminar.dialog.SeminarAlertDialog
import com.tnmeta.torymeta.seminar.dialog.SeminarPasswordBottomDialogFragment
import com.tnmeta.torymeta.seminar.main.SeminarMessage
import com.tnmeta.torymeta.seminar.model.SeminarEnterInfo
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.model.SeminarInfo
import com.tnmeta.torymeta.seminar.model.ToryLoungeInfo
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.unity.UnityUtils
import com.tnmeta.torymeta.utils.PermissionHelper
import com.tnmeta.torymeta.utils.Utilts
import com.tnmeta.torymeta.web.ToryWebActivity
import com.tnmeta.torymeta.web.Web
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.DecimalFormat
import com.tnmeta.torymeta.chattinglounge.dialog.ChattingPasswordDialog
import com.tnmeta.torymeta.common.EventBottomID
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.dialog.EventAdBottomDialogFragment
import com.tnmeta.torymeta.model.dto.EventListDTO
import com.tnmeta.torymeta.model.event.EventType
import com.tnmeta.torymeta.model.event.EventTypeBus
import com.tnmeta.torymeta.model.param.InitVersion
import com.tnmeta.torymeta.model.push.PushMessageInfo
import com.tnmeta.torymeta.model.unity.VideoUrl
import com.tnmeta.torymeta.model.unity.avatar.info.SwitchSceneSimple
import com.tnmeta.torymeta.talk.ToryTalkActivity
import com.tnmeta.torymeta.videoplayer.LectureLoginActivity
import com.tnmeta.torymeta.videoplayer.MyLectureRoomActivity
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode
import java.util.Calendar


class MainFragment : BaseFragment(), View.OnClickListener {

    companion object {
        val TAG : String = MainFragment::class.java.simpleName

        fun newInstance() = MainFragment().apply {}

        const val REQUEST_CODE_PERMISSION_LOCATION = 1000
        const val PERMISSION_REQUEST_ACTIVITY_RECOGNITION = 100
    }

    private var _viewBinding: FragmentMainBinding? = null
    private val viewBinding get() = _viewBinding!!

    private lateinit var viewModel: CampusViewModel
    private lateinit var locationSource: FusedLocationSource

    private lateinit var mChattingAdapter : ChattingRecyclerViewAdapter
    private lateinit var mSeminarAdapter : LiveSeminarAdapter
    private lateinit var mMetaAdapter : MetaRecyclerViewAdapter

    private var mPushMessage : PushMessageInfo? = null
    private lateinit var dialogFragment : EventAdBottomDialogFragment

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        try {
            _viewBinding = FragmentMainBinding.inflate(inflater, container, false)
            viewBinding.apply {
                viewModel = ViewModelProvider(this@MainFragment)[CampusViewModel::class.java]

                if (UnityUtils.getPlayer() != null) {
                    (UnityUtils.getPlayer().parent.parent as ViewGroup).removeAllViews()
                }

                UnityUtils.createPlayer(requireActivity()) {
                    UnityUtils.addUnityViewToGroup(unity)
                    if(!ToryApplication.isUnityLoad) {
                        ToryApplication.isUnityLoad = true
                        onAwake()
                    }
                }

                //unityLayout.visibility = View.VISIBLE
                //loadingProgress.visibility = View.GONE

                val values =  SwitchSceneSimple(scene = ToryMetaSceneParam.AvatarView)
                sendNativeUnityMessage(type = ToryMetaMessageType.SwitchSceneSimple, valueParam = values)

                /*
                if (arguments != null) {
                    arguments?.let {
                        mPushMessage = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            it.getParcelable(Params.PUSH_DATA_PARAM, PushMessageInfo::class.java)
                        }else {
                            it.getParcelable(Params.PUSH_DATA_PARAM)
                        }
                    }
                }
                 */

                if(!EventBus.getDefault().isRegistered(this@MainFragment))
                    EventBus.getDefault().register(this@MainFragment)
            }

        }catch (e : Exception){
            Timber.d("MainFragment ${e.message}")
        }

        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        try {
            viewBinding.apply {

                initData()
                setClickEvent()
                fusedUpdateLocation()

                initPager()

                repository.apply {
                    if(hasAvatarAttrYn == Constants.NoValue) {
                        welcomeLayout.visibility = View.VISIBLE
                        avatarLayout.visibility = View.INVISIBLE

                    }else {
                        avatarLayout.visibility = View.VISIBLE
                        welcomeLayout.visibility = View.GONE
                    }
                }

                viewModel.apply {
                    updatePoint()
                    point.observe(viewLifecycleOwner) { point ->
                        myToryPoint.text = String.format("%s", DecimalFormat("#,###").format(point.point))
                    }
                }

                updateProfileName()

                refreshLayout.setOnRefreshListener {
                    CoroutineScope(Dispatchers.Main).launch {
                        viewModel.apply {
                            getLiveSeminarList()
                            getRecommandMeta()

                            val params = BaseParam(ChattingRoomListParam(Constants.ChatLounge, 10)).parameter
                            getChattingList(params)
                        }
                    }
                    refreshLayout.isRefreshing = false
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    /**
     * onChangeNativeActivity
     * @param paramValue
     */
    private fun onChangeNativeActivity(paramValue : String) = try {
        when(paramValue) {
            EventBottomID.STU -> {
                if(repository.member.value!!.certUniYn == 0) {
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(resources.getString(R.string.certification_message))
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                            univSelectLauncher.launch(Intent(requireContext(), UniversitySelectActivity::class.java))
                            return@setPositiveButton
                        }
                        .setNegativeButton(R.string.system_alert_btn_cancel) {}
                        .show()
                }
                Intent(requireContext(), PedometerActivity::class.java).run {
                    startActivity(this)
                }
            }

            EventBottomID.TTCAUTH ->{
                if(repository.ttcStatus.isNotEmpty() && repository.ttcStatus == "LOGIN") {
                    CoroutineScope(Dispatchers.Main).launch {
                        firebaseAnalyticsMember(FirebaseParam.mobile_bottom_ttc_classroom)
                        MyLectureRoomActivity.createIntent(requireContext()).run {
                            startActivity(this)
                        }
                    }
                }else {
                    LectureLoginActivity.createIntent(requireContext()).run {
                        startActivity(this)
                    }
                }
            }
            else -> {}
        }

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }



    private fun fusedUpdateLocation() = try {
        if(repository.member.value!!.certUniYn != 0) {
            locationSource = FusedLocationSource(this@MainFragment, REQUEST_CODE_PERMISSION_LOCATION)
            locationSource.activate {
                it?.let {
                    viewModel.updateMyLocation(LatLng(it.latitude, it.longitude))
                }
            }
        }else { }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun setClickEvent() = try {
        viewBinding.apply {
            arrayOf(addAvatar, avatarSelect, imgMymenu, chattingMore, imgTalk,
                    seminarCreate, seminarMore, toryLounge, imgAlarm, campusLayout, nftLayout,
                    avatarNickname,
                    onlineLecture
                ).forEach {
                it.setOnClickListener(this@MainFragment)
            }
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    private fun updateProfileName(isProfileUpdate : Boolean = false) = try {
        viewModel.myAvatarAttr.observe(viewLifecycleOwner) {item ->

            viewBinding.apply {

                nickname.text = repository.member.value!!.profileName

                if (repository.isAvatarload) {
                    unityLayout.visibility = View.VISIBLE
                    loadingProgress.visibility = View.GONE
                }

                if(isProfileUpdate) {
                    requireMember()
                }else {
                    initSetAvatar()
                }
            }
        }
    }catch (e : Exception){
        Timber.d("sendNativeUnityMessage " + e.message)
    }


    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null

        if (EventBus.getDefault().isRegistered(this))
            EventBus.getDefault().unregister(this)
    }

    override fun onStop() {
        super.onStop()
    }

    override fun onResume() {
        super.onResume()
        try {
            UnityUtils.resume()

            viewModel.apply {
                getLiveSeminarList()
                getRecommandMeta()

                val params = BaseParam(ChattingRoomListParam(Constants.ChatLounge, 10)).parameter
                getChattingList(params)
            }

            if(repository.getIsShowBottomDialog())
                showEventBottomDialog()


        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onPause() {
        super.onPause()
        try {
            UnityUtils.pause()
            //isRunning = false
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


    private fun showEventBottomDialog() {
        try {
            val currentCalendar = Calendar.getInstance()
            val readDate = repository.getAdEventDate()

            currentCalendar.apply {
                timeInMillis = readDate
                get(Calendar.DAY_OF_MONTH)
            }

            if (repository.eventBannerList.isNotEmpty() &&
                (Calendar.getInstance().get(Calendar.DAY_OF_MONTH) - currentCalendar.get(Calendar.DAY_OF_MONTH) != 0)
            ) {
                Timber.tag(TAG).d("EventAdBottomDialogFragment")

                dialogFragment = EventAdBottomDialogFragment(requireContext(), repository.eventBannerList,
                    onButtonClick = {
                        when (it.id) {
                            R.id.hideToday -> repository.setAdEventDate(System.currentTimeMillis())
                        }
                    },
                    onItemViewClick = { data ->
                        val detailArray = data.bannerAppUrl.split(":")
                        when (detailArray[0]) {
                            "W" -> {
                                val url = "${Web.Url.BASE}${detailArray[1]}"
                                Intent(context, ToryWebActivity::class.java).run {
                                    putExtra(ToryWebActivity.PARAM_URL, url)
                                    startActivity(this)
                                }
                            }

                            "N" -> onChangeNativeActivity(detailArray[1])
                        }
                    })


                dialogFragment.apply {
                    setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                    //show(this@MainFragment.childFragmentManager, Constants.EventBottomDialogFragmentTag)
                    showDialog(dialogFragment, Constants.EventBottomDialogFragmentTag)
                }

                //showDialog(dialogFragment, Constants.EventBottomDialogFragmentTag)

            } else { }
        } catch (e: Exception) {
            Timber.tag(TAG).d(e.message)
        }
    }

    private fun showDialog(dialogFragment: DialogFragment, tag: String) {
        childFragmentManager.findFragmentByTag(tag).let { fragment ->
            fragment ?: let {
                childFragmentManager.beginTransaction().let { transition ->
                    dialogFragment.show(transition, tag)
                }
            }
        }
    }


    /**
     * onClick
     */
    override fun onClick(view: View) {
        when(view.id) {

            R.id.add_avatar -> findNavController().navigate(R.id.action_main_to_avatar_profile)

            R.id.chatting_more -> findNavController().navigate(R.id.action_main_to_chatting_lounge)

            R.id.avatarSelect -> findNavController().navigate(R.id.action_main_to_avatar_profile)

            R.id.imgMymenu -> {
                MyPageActivity.createIntent(requireContext()).run {
                    startActivity(this)
                }
            }

            R.id.seminar_create -> {
                CreateSeminarActivity.createIntent(requireContext()).run {
                    startActivity(this)
                }
            }

            R.id.seminar_more -> {
                if(Constants.is_FirebaseAnalytics) {
                    CoroutineScope(Dispatchers.Main).launch {
                        firebaseAnalyticsMember(FirebaseParam.mobile_seminacenter)
                    }
                }
                findNavController().navigate(R.id.action_main_to_seminar_main)
            }

            R.id.imgAlarm -> {
                Intent(context, ToryWebActivity::class.java).run {
                    putExtra(ToryWebActivity.PARAM_URL, Web.Url.NOTICE)
                    startActivity(this)
                }
            }

            /**
             * tory lounge click
              */
            R.id.tory_lounge -> {
                if(repository.hasAvatarAttrYn == Constants.NoValue){
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(R.string.avatar_make_message)
                        .setPositiveButton {}
                        .show()
                    return
                }

                repository.apply {
                    val params = BaseParam(VideoUrl(
                        loungeType = "LOUNGE",
                        mediaType = "mp4"
                    )).parameter

                    getVideoUrl(json = params).subscribeBy(onNext = {
                        CoroutineScope(Dispatchers.Main).launch {

                            val infoData = enterToryLounge(
                                item = ToryLoungeInfo(videoUrl = it.videoUrl)
                            )

                            val action = MainFragmentDirections.actionMainToTorymetaWorld(infoData)
                            findNavController().navigate(action)
                        }
                    }, onError = {})
                }
            }

            /**
             * campus_layout click
             */
            R.id.campus_layout -> {
                if(repository.member.value!!.certUniYn != 0) {
                    CampusActivity.createIntent(requireContext()).run {
                        startActivity(this)
                    }
                }else {
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(resources.getString(R.string.certification_message))
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                            univSelectLauncher.launch(Intent(requireContext(), UniversitySelectActivity::class.java))
                        }
                        .setNegativeButton(R.string.system_alert_btn_cancel) {}
                        .show()
                }
            }

            /**
             * nft_layout click
             **/
            R.id.nft_layout -> {
                if (Utilts.instance.netWorkCheck(requireContext())) {
                    if (Constants.is_FirebaseAnalytics) {
                        firebaseAnalyticsMember(FirebaseParam.mobile_nft)
                    }

                    val loginToken = repository.getLoginToken()
                    val bcToken = repository.getBCToken()

                    ToryWebActivity.createIntent(requireContext(), Web.Url.getNFTUrl(loginToken, bcToken, repository)).run {
                        startActivity(this)
                    }

                } else {
                    NetworkErrorDialogFragment.NetworkErrorDialogBuilder(childFragmentManager).apply {
                        setClickListener(object : CommonDialogInterface.OnClickListener {
                            override fun onClick(i: Int) {
                                when (i) {
                                    R.id.backBtn -> {
                                        viewBinding.apply {
                                            //bottomNavigationView.selectedItemId = R.id.placeholder
                                        }
                                    }

                                    R.id.refresh -> {
                                        if (Constants.is_FirebaseAnalytics) {
                                            firebaseAnalyticsMember(FirebaseParam.mobile_nft)
                                        }

                                        val loginToken = repository.getLoginToken()
                                        val bcToken = repository.getBCToken()
                                        ToryWebActivity.createIntent(requireContext(), Web.Url.getNFTUrl(loginToken, bcToken, repository)).run {
                                            startActivity(this)
                                        }
                                    }
                                }
                            }
                        })
                    }.show()
                }
            }

            /**
             * avatar nickname click
             */
            R.id.avatar_nickname -> {
                ProfileEditAlertDialog.Builder(requireContext(), onClick = { profileName ->
                    onUpdateProfileName(profileName)
                    })
                    .setCancelable(false)
                    .setNickName(repository.member.value!!.profileName)
                    .setPositiveButton { profileName ->
                        onUpdateProfileName(profileName)
                    }.show()

            }

            R.id.imgTalk -> {
                if(Constants.is_FirebaseAnalytics) {
                    firebaseAnalyticsMember(FirebaseParam.mobile_torytolk)
                }
                Intent(requireContext(), ToryTalkActivity::class.java).run {
                    startActivity(this)
                }
            }

            R.id.online_lecture -> {
                if(repository.ttcStatus.isNotEmpty() && repository.ttcStatus == "LOGIN") {
                    CoroutineScope(Dispatchers.Main).launch {
                        firebaseAnalyticsMember(FirebaseParam.mobile_ttc_myclassroom)
                        MyLectureRoomActivity.createIntent(requireContext()).run {
                            startActivity(this)
                        }
                    }
                }else {
                    LectureLoginActivity.createIntent(requireContext()).run {
                        startActivity(this)
                    }
                }
            }
        }
    }


    /**
     * onUpdateProfileName()
     * @param profileName
     */
    private fun onUpdateProfileName(profileName : String) {
        try {
            if (profileName.isEmpty()) {
                CommonAlertDialog.Builder(requireContext())
                    .setCancelable(false)
                    .setMessage(R.string.avatar_profile_name_empty)
                    .setPositiveButton {}
                    .show()
                return
            }
            viewModel.apply {
                val params = BaseParam(ProfileNameParam(profileName)).parameter
                setProfileName(params).subscribeBy(onNext = {
                    if (it.result!!.isSucceed) {
                        CommonAlertDialog.Builder(requireContext())
                            .setCancelable(false)
                            .setMessage(R.string.profile_name_change_success)
                            .setPositiveButton {
                                repository.member.value!!.profileName = profileName
                                CoroutineScope(Dispatchers.Main).launch {
                                    updateProfileName(true)
                                }
                            }
                            .show()
                    } else {
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(it.resultMessage.toString())
                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                            .show()
                    }

                }, onError = {
                    Timber.d("error $it.message")
                })
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


    /**
     * Event Item Click
     */
    private fun onClickEventItem(eventInfo :EventListDTO) {
        try {
            val detailArray = eventInfo.bannerAppUrl.split(":")
            if (detailArray.isEmpty())
                return

            when (detailArray[0]) {
                "W" -> {
                    if (detailArray[1] == "/event/event001") {
                        if (Constants.is_FirebaseAnalytics) {
                            CoroutineScope(Dispatchers.Main).launch {
                                firebaseAnalyticsMember(FirebaseParam.mobile_present)
                            }
                        }
                    }
                    val url = "${Web.Url.BASE}${detailArray[1]}"
                    Timber.tag(TAG).d("url - $url")
                    Intent(context, ToryWebActivity::class.java).run {
                        putExtra(ToryWebActivity.PARAM_URL, url)
                        startActivity(this)
                    }
                }

                "N" -> onChangeNativeActivity(detailArray[1])
            }
        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }


    private val reCogNitionPermissions = arrayOf(
        Manifest.permission.ACTIVITY_RECOGNITION,
    )

    private val locationPermissions = arrayOf(
        Manifest.permission.ACCESS_FINE_LOCATION,
        Manifest.permission.ACCESS_COARSE_LOCATION
    )

    private fun isLocationPermissionGranted(): Boolean {
        return PermissionHelper.isPermissionGranted(requireContext(), locationPermissions)
    }


    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        //super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if( requestCode == REQUEST_CODE_PERMISSION_LOCATION ) {
            locationSource.onRequestPermissionsResult(requestCode, permissions, grantResults)

            // 권한 허용
            if( isLocationPermissionGranted() ) {
            }
            // 권한 거부
            else {
            }
        }else if(requestCode == PERMISSION_REQUEST_ACTIVITY_RECOGNITION) {
            if(isActivityRecognitionPermissionGranted()) {

            }else{

            }
        }
    }

    private fun isActivityRecognitionPermissionGranted(): Boolean {
        return PermissionHelper.isPermissionGranted(requireContext(), reCogNitionPermissions)
    }

    private fun requestActivityRecognitionPermission() {
        if( PermissionHelper.shouldShowRequestPermissionRationale(requireActivity(), reCogNitionPermissions) ) {
        }
        // 권한 요청
        else {
            PermissionHelper.requestPermission(requireActivity(), reCogNitionPermissions, PERMISSION_REQUEST_ACTIVITY_RECOGNITION)
        }
    }


    private fun initPager() = viewBinding.apply {
        try {
            viewModel.setCurrentPosition(0)
            viewPager.adapter = EventPagerAdapter(
                pageData = repository.eventArray,
                onItemViewClick = {
                    onClickEventItem(it)
                }
            )
            indicator.setViewPager(viewPager)

            /*
            viewModel.currentPosition.observe(viewLifecycleOwner) {currentPosition->
                viewPager.currentItem = currentPosition
            }
            */

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    /**
     * init
     */
    private val mChattingArrayList = ArrayList<ChattingRoom>()
    private val mSeminarArrayList = ArrayList<SeminarDto>()
    private val mMetaArrayList = ArrayList<RoomInfoDto>()

    private fun initData() = viewBinding.apply{
        mChattingAdapter = ChattingRecyclerViewAdapter(
            items = mChattingArrayList,
            onItemViewClick = {chattingRoom ->
                Timber.tag(TAG).d("chattingRoom ${chattingRoom.password}")

                if(chattingRoom.privateRoom) {
                    ChattingPasswordDialog.Builder(requireContext(), chattingRoom.password).apply {
                        setOnEnterClick {
                            CoroutineScope(Dispatchers.Main).launch {
                                val infoData = enterChattingRoom(chattingRoom.tableId)

                                Timber.tag(TAG).d("tory_lounge $infoData")

                                val action = MainFragmentDirections.actionMainToTorymetaWorld(infoData)
                                findNavController().navigate(action)
                            }
                        }
                        show()
                    }

                }else {
                    CoroutineScope(Dispatchers.Main).launch {

                        val infoData = enterChattingRoom(chattingRoom.tableId)
                        Timber.tag(TAG).d("tory_lounge $infoData")
                        val action = MainFragmentDirections.actionMainToTorymetaWorld(infoData)
                        findNavController().navigate(action)
                    }
                }
            }
        )

        chattingRecyclerView.apply {
            layoutManager = LinearLayoutManager(requireContext())
            setDivider(R.drawable.menu_view_divider)
            adapter = mChattingAdapter
        }

        mMetaAdapter = MetaRecyclerViewAdapter(
            datas = mMetaArrayList,
            onItemClick =  {},
            onItemButtonClick = {
                enterWorld(it)
            }
        )

        metaListView.apply {
            layoutManager = LinearLayoutManager(requireContext(), RecyclerView.HORIZONTAL, false)
            adapter = mMetaAdapter
        }

        mSeminarAdapter = LiveSeminarAdapter(
            repository = repository,
            onItemClick = {dataInfo->
                val infoData = SeminarInfo(dataInfo.id, dataInfo.roomImageUrl)
                val action  = MainFragmentDirections.actionMainToSeminarDetail(infoData)
                findNavController().navigate(action)
            },

            onItemButtonClick = { item, position ->
                if(repository.hasAvatarAttrYn == Constants.NoValue) {
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(R.string.avatar_make_message)
                        .setPositiveButton {}
                        .show()
                    return@LiveSeminarAdapter
                }

                if(item.teacherId == repository.member.value!!.memberId) {
                    myCreateEnterSeminarRoom(item)
                }else {
                    when(item.status) {
                        SeminarStatus.START -> isCheckSeminarRoom(item)
                        SeminarStatus.BEFORE_START -> seminarBeforeStart(item, position)
                    }
                }
            }
        )
        seminarListView.apply {
            layoutManager = LinearLayoutManager(requireContext(), RecyclerView.HORIZONTAL, false)
            adapter = mSeminarAdapter
        }


        viewModel.apply {
            liveChattingList.observe(viewLifecycleOwner) {list ->

                val tempArray = ArrayList<ChattingRoom>().apply {
                    addAll(list)
                    sortWith(
                        compareBy<ChattingRoom> {
                            it.createdAt
                        }.reversed()
                    )
                }

                if(tempArray.size >= 6 ) {
                    mChattingArrayList.apply {
                        clear()
                        addAll(tempArray.subList(0, 6))
                    }
                }else {
                    mChattingArrayList.apply {
                        clear()
                        addAll(tempArray)
                    }
                }

                if(mChattingArrayList.isEmpty()) {
                    emptyChatting.visibility = View.VISIBLE
                    chattingRecyclerView.visibility = View.GONE
                }else {
                    emptyChatting.visibility = View.GONE
                    chattingRecyclerView.visibility = View.VISIBLE
                }

                mChattingAdapter.notifyDataSetChanged()
            }

            liveSeminarList.observe(viewLifecycleOwner) { list ->
                /*
                val sortlist = list.sortedBy {
                    it.startAt
                }
                */

                mSeminarArrayList.apply {
                    clear()
                    addAll(list)
                }

                if(mSeminarArrayList.isEmpty()) {
                    seminarListView.visibility = View.GONE
                    emptyView.visibility = View.VISIBLE
                }else {
                    seminarListView.visibility = View.VISIBLE
                    emptyView.visibility = View.GONE
                }

                mSeminarAdapter.replaceItems(mSeminarArrayList)
            }

            recommandList.observe(viewLifecycleOwner) { list ->
                mMetaArrayList.apply {
                    clear()
                    addAll(list)
                }
                mMetaAdapter.notifyDataSetChanged()
            }
        }

    }

    /**
     * myCreateEnterSeminarRoom
     */
    private fun myCreateEnterSeminarRoom(item: SeminarDto) = try {
        repository.apply {
            getRoomPassword(item.id).subscribeBy(onNext = { passwordResult ->
                if(passwordResult.resultCode == ApiResponse.RESULT_CODE_OK) {
                    val params = BaseParam(SeminarEnterParam(passwordResult.result!!.password)).parameter
                    viewModel.setSeminarEnter(item.id, params).subscribeBy (onNext = {it ->
                        if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                            enterSeminarRoom(item!!, it.result!!)
                        } else {
                            CommonAlertDialog.Builder(this@MainFragment.requireContext())
                                .setMessage(it.resultMessage.toString())
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                        }
                    })
                }else {
                    CommonAlertDialog.Builder(this@MainFragment.requireContext())
                        .setMessage(passwordResult.resultMessage.toString())
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }
            })
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    /**
     * 개설자가 본인인지 확인 체크
     */
    private fun isCheckSeminarRoom(item: SeminarDto) = try {
        if (item.secretYn == Constants.NoValue) {
            CommonAlertDialog.Builder(requireContext())
                .setMessage(R.string.seminar_enter_ask_message)
                .setNegativeButton(R.string.seminar_apply_cancel) {}
                .setPositiveButton(R.string.seminar_cancel_yes) {
                    val params = BaseParam(SeminarEnterParam("")).parameter
                    viewModel.apply {
                        setSeminarEnter(item.id, params).subscribeBy(onNext = { it ->
                            if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                                enterSeminarRoom(item!!, it.result!!)
                            } else {
                                CommonAlertDialog.Builder(this@MainFragment.requireContext())
                                    .setMessage(it.resultMessage.toString())
                                    .setPositiveButton(R.string.system_alert_btn_ok) {}
                                    .show()
                            }
                        }, onError = {
                            Timber.d("" + it.message)
                        }, onComplete = {
                            Timber.d("onComplete")
                        })
                    }
                }
                .show()
        } else {
            if (item.secretYn == Constants.YesValue && item.participationYn == Constants.YesValue) {
                CommonAlertDialog.Builder(requireContext())
                    .setMessage(R.string.seminar_enter_ask_message)
                    .setNegativeButton(R.string.seminar_apply_cancel) {}
                    .setPositiveButton(R.string.seminar_cancel_yes) {
                        SeminarPasswordBottomDialogFragment(this@MainFragment.requireContext(), false).apply {
                            setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                            onClickListener = { data ->
                                if (data.toString().isEmpty()) {
                                    CommonAlertDialog.Builder(this@MainFragment.requireContext())
                                        .setMessage(R.string.password_input_hint)
                                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                                        .show()
                                } else {
                                    val params = BaseParam(SeminarEnterParam(data.toString())).parameter
                                    viewModel.apply {
                                        setSeminarEnter(item.id, params).subscribeBy(onNext = { it ->
                                            if (it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.enterYn == Constants.YesValue) {
                                                enterSeminarRoom(item!!, it.result!!)
                                            } else {
                                                CommonAlertDialog.Builder(this@MainFragment.requireContext())
                                                    .setMessage(it.resultMessage.toString())
                                                    .setPositiveButton(R.string.system_alert_btn_ok) {}
                                                    .show()
                                            }

                                        }, onError = {
                                            Timber.d("" + it.message)
                                        }, onComplete = {
                                            Timber.d("onComplete")
                                        })
                                    }
                                }
                            }
                            show(this@MainFragment.childFragmentManager, Constants.SeminarPasswordBottomDialogFragmentTag)
                        }
                    }
                    .show()

            } else {
                SeminarMessage.instance.showAlertMessage(this@MainFragment.requireContext(),
                                                            R.string.seminar_live_not_allow)
            }
        }

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


    /**
     * 강의 시작 전
     */
    private fun seminarBeforeStart(item: SeminarDto, position: Int) = try {
        if(item.secretYn == Constants.YesValue) {
            if(item.participationYn == Constants.YesValue) {
                SeminarMessage.instance.showAlertMessage(this@MainFragment.requireContext(),
                                                        R.string.seminar_secret_before_message)
            }else {
                CommonAlertDialog.Builder(requireContext())
                    .setMessage(R.string.seminar_participate_message)
                    .setNegativeButton(R.string.seminar_apply_cancel) {}
                    .setPositiveButton(R.string.seminar_cancel_yes) {
                        viewModel.setParticipate(item.id).subscribeBy(onNext = {
                            if (it.result!!.isSucceed) {
                                SeminarAlertDialog.Builder(this@MainFragment.requireContext())
                                    .setCancelable(false)
                                    .setTitle(R.string.secret_seminar_apply_success_message)
                                    .setPositiveButton(R.string.system_alert_btn_ok) {
                                        item.participationYn = "Y"
                                        mSeminarArrayList[position] = item
                                        mSeminarAdapter.notifyItemChanged(position, item)
                                    }
                                    .show()
                            }else {
                                CommonAlertDialog.Builder(requireContext())
                                    .setMessage(it.resultMessage.toString())
                                    .setPositiveButton(R.string.system_alert_btn_ok) {}
                                    .show()
                            }

                        }, onError = {

                        })

                    }.show()
            }
        }else {
            SeminarMessage.instance.showAlertMessage(this@MainFragment.requireContext(),
                                                    R.string.seminar_secret_before_message)
        }

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }

    /**
     * enterSeminarRoom
     */
    private fun enterSeminarRoom(item: SeminarDto, result : SeminarEnterResult)  {
        try {
            if(repository.hasAvatarAttrYn == Constants.NoValue) {
                SeminarMessage.instance.showAlertMessage(this@MainFragment.requireContext(),
                                                            R.string.avatar_make_message)
                return
            }

            CoroutineScope(Dispatchers.Main).launch {
                val infoData = enterSeminarRoom(
                    item = SeminarEnterInfo(teacherName = item.teacherName, title = item.title, item.startAt),
                    result = result
                )

                Timber.tag(TAG).d("infoData $infoData")

                val action = MainFragmentDirections.actionMainToTorymetaWorld(infoData)
                findNavController().navigate(action)
            }

        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }


    /**
     * enterWorld
     */
    private fun enterWorld(dataInfo : RoomInfoDto) {
        try {
            if(repository.hasAvatarAttrYn == Constants.NoValue){
                SeminarMessage.instance.showAlertMessage(this@MainFragment.requireContext(),
                                                            R.string.avatar_make_message)
                return
            }

            if(repository.member.value!!.certUniYn == 0) {
                CommonAlertDialog.Builder(requireContext())
                    .setCancelable(false)
                    .setMessage(resources.getString(R.string.certification_message))
                    .setPositiveButton(R.string.system_alert_btn_ok) {
                        univSelectLauncher.launch(Intent(requireContext(), UniversitySelectActivity::class.java))
                    }
                    .setNegativeButton(R.string.system_alert_btn_cancel) {}
                    .show()

                return
            }

            val infoData = enterSceneWorld(dataInfo)
            Timber.tag(TAG).d("infoData $infoData")

            val action = MainFragmentDirections.actionMainToTorymetaWorld(infoData)
            findNavController().navigate(action)

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


    private val univSelectLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == AppCompatActivity.RESULT_OK) {
            fusedUpdateLocation()
            val params = BaseParam(InitVersion(BuildConfig.VERSION_NAME, Build.MODEL, Build.VERSION.RELEASE, Constants.BannerType)).parameter
            repository.initData(params).subscribeBy(onNext = {
                    toryApplication.apply {
                        initIAB(repository.toryItemList)
                    }
                }, onError = {}
            )
        }
    }


    /**
     * onSendToNative
     */
    fun onSendToNative(currentActivity: Activity, visible : Boolean) {
        
        try {
            CoroutineScope(Dispatchers.Main).launch {

                currentActivity.apply {
                    findViewById<ViewGroup>(R.id.unity_layout).visibility = View.VISIBLE
                    findViewById<ProgressWheel>(R.id.loadingProgress).visibility = View.GONE
                }

                val repository = ToryApplication.getRepository(currentActivity)
                repository.isAvatarload = true

                ToryApplication.getRepository(currentActivity).apply {
                    val avatarValue = AvatarValue(
                        userName = member.value!!.profileName,
                        memberId = member.value!!.memberId,
                        avatarState = AvatarState(
                            skinCode = myAvatarAttr.value!!.skinCode,
                            skinColorCode = myAvatarAttr.value!!.skinColorCode,

                            faceCode = myAvatarAttr.value!!.faceCode,
                            faceColorCode = myAvatarAttr.value!!.faceColorCode,

                            hairCode = myAvatarAttr.value!!.hairCode,
                            hairColorCode = myAvatarAttr.value!!.hairColorCode,

                            topCode = myAvatarAttr.value!!.topCode,
                            topColorCode = myAvatarAttr.value!!.topColorCode,

                            bottomCode = myAvatarAttr.value!!.bottomCode,
                            bottomColorCode = myAvatarAttr.value!!.bottomColorCode,

                            shoesCode = myAvatarAttr.value!!.shoesCode,
                            shoesColorCode = myAvatarAttr.value!!.shoesColorCode,

                            bodyType = myAvatarAttr.value!!.bodyCode
                        )
                    )

                    sendNativeUnityMessage(
                        type = ToryMetaMessageType.AvatarInfo,
                        valueParam = avatarValue
                    )

                }

            }

        } catch (e: Exception) {
            Timber.tag(TAG).d("MainFragment onSendToNative error ${e.message}")
        }
    }


    fun onMainAwake(currentActivity: Activity) {
        Timber.tag(TAG).d("onMainAwake")
        currentActivity.apply {
            findViewById<ConstraintLayout>(R.id.unity_layout).visibility = View.VISIBLE
            findViewById<ProgressWheel>(R.id.loadingProgress).visibility = View.GONE
        }

    }


    @Subscribe(threadMode = ThreadMode.MAIN)
    fun eventUpdate(eventBus: EventTypeBus) {
        try {
            when(eventBus.type) {
                EventType.TORYMETA_FESTIVAL -> {
                    Timber.tag(TAG).d("eventUpdate GO_FESTIVAL")
                    if(repository.hasAvatarAttrYn == Constants.NoValue){
                        CommonAlertDialog.Builder(requireContext())
                            .setCancelable(false)
                            .setMessage(R.string.avatar_make_message)
                            .setPositiveButton {}
                            .show()
                        return
                    }

                    repository.apply {
                        val params = BaseParam(VideoUrl(
                            loungeType = "LOUNGE",
                            mediaType = "mp4"
                        )).parameter

                        getVideoUrl(json = params).subscribeBy(onNext = {
                            CoroutineScope(Dispatchers.Main).launch {

                                val infoData = enterToryLounge(
                                    item = ToryLoungeInfo(videoUrl = it.videoUrl),
                                    type = "festival"
                                )

                                Timber.tag(TAG).d("GO_FESTIVAL $infoData")
                                val action = MainFragmentDirections.actionMainToTorymetaWorld(infoData)
                                findNavController().navigate(action)
                            }
                        }, onError = {})
                    }
                }
                else -> {

                }
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


}