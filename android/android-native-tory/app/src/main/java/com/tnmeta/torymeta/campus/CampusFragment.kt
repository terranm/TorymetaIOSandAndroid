package com.tnmeta.torymeta.campus

import android.Manifest
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.naver.maps.geometry.LatLng
import com.naver.maps.map.CameraAnimation
import com.naver.maps.map.CameraPosition
import com.naver.maps.map.CameraUpdate
import com.naver.maps.map.NaverMap
import com.naver.maps.map.overlay.Marker
import com.naver.maps.map.overlay.OverlayImage
import com.naver.maps.map.util.FusedLocationSource
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.campus.ui.*
import com.tnmeta.torymeta.campus.viewmodel.CampusViewModel
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.databinding.FragmentCampusBinding
import com.tnmeta.torymeta.databinding.MyCustomMarkerBinding
import com.tnmeta.torymeta.databinding.MyFriendCustomMarkerBinding
import com.tnmeta.torymeta.dialog.*
import com.tnmeta.torymeta.model.event.EventType
import com.tnmeta.torymeta.model.event.EventTypeBus
import com.tnmeta.torymeta.model.CampusTopMenuData
import com.tnmeta.torymeta.model.CampusTopMenuType
import com.tnmeta.torymeta.model.MarkerType
import com.tnmeta.torymeta.model.MarkerUserData
import com.tnmeta.torymeta.model.SeminarStatus
import com.tnmeta.torymeta.model.dto.EventDTO
import com.tnmeta.torymeta.model.dto.EventListDTO
import com.tnmeta.torymeta.model.dto.MarkerDTO
import com.tnmeta.torymeta.model.dto.MarkerDTOEnc
import com.tnmeta.torymeta.model.dto.UniversityDTO
import com.tnmeta.torymeta.talk.ChattingActivity
import com.tnmeta.torymeta.talk.ToryTalkActivity
import com.tnmeta.torymeta.talk.ui.FriendDetailView
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.Divider
import com.tnmeta.torymeta.utils.PermissionHelper
import com.tnmeta.torymeta.utils.Utilts
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.isVisible
import com.tnmeta.torymeta.web.ToryWebActivity
import com.tnmeta.torymeta.web.Web
import io.reactivex.rxjava3.kotlin.subscribeBy
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode
import timber.log.Timber


class CampusFragment: BaseFragment(), View.OnClickListener {
    companion object {
        const val REQUEST_CODE_PERMISSION_LOCATION = 1000
        const val PERMISSION_REQUEST_ACTIVITY_RECOGNITION = 1001


        val TAG : String = CampusFragment::class.java.simpleName

        fun newInstance() =
            CampusFragment().apply {}
    }

    private lateinit var viewBinding: FragmentCampusBinding
    private lateinit var viewModel: CampusViewModel

    private var isDropDown = true


    private val topMenuArray: Array<CampusTopMenuData> by lazy {
        arrayOf(
            CampusTopMenuData(CampusTopMenuType.TOGETHER,     R.drawable.campus_icon_together,   R.string.campus_title_together),
            CampusTopMenuData(CampusTopMenuType.SCHOOL_MEAL,  R.drawable.campus_icon_school_meal, R.string.campus_title_schoolmeal),
            CampusTopMenuData(CampusTopMenuType.SCHOOL_EVENT, R.drawable.campus_icon_school_event,     R.string.campus_title_school),
        )
    }

    private val recogitionPermissions = arrayOf(
        Manifest.permission.ACTIVITY_RECOGNITION,
    )

    private lateinit var locationSource: FusedLocationSource
    private var naverMap: NaverMap? = null

    // 마커

    private val myMarker = createMarker(MarkerType.MY, R.dimen.my_custom_marker_width, R.dimen.my_custom_marker_height).apply {
        icon = OverlayImage.fromResource(R.drawable.my_position_marker_background)
    }

    private val myCampusMarker = createMarker(MarkerType.CAMPUS, R.dimen.marker_campus_width, R.dimen.marker_campus_height)
    private val buildingMarkers = ArrayList<Marker>()
    private var isBuildingMarkerVisible = true

    private var visitCampusCode: String? = null
    private var visitCampusMarker: Marker? = null
    private val visitCampusBuildingMarkers = ArrayList<Marker>()

    private val friendMarkers = ArrayList<Marker>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = FragmentCampusBinding.inflate(inflater, container, false)

        viewBinding.apply {
            viewModel = ViewModelProvider(this@CampusFragment)[CampusViewModel::class.java].apply {

                member.observe(viewLifecycleOwner) {
                    val url = it.imgUrl

                    if( url.isNotEmpty() ) {
                        Glide.with(requireContext()).asBitmap()
                            .load(url)
                            .transform(CenterCrop(), RoundedCorners(resources.getDimension(R.dimen.marker_my_icon_radius).toInt()))
                            .into(object: CustomTarget<Bitmap>() {
                                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap?>?) {
                                    val customViewBinding = MyCustomMarkerBinding.inflate(LayoutInflater.from(context))
                                    customViewBinding.apply {
                                        imgMarker.setImageBitmap(resource)
                                    }
                                    myMarker.icon = OverlayImage.fromView(customViewBinding.root)
                                }
                                override fun onLoadCleared(placeholder: Drawable?) {}
                            })
                    }

                    // 위치 공유 인디케이터 업데이트
                    val imageResouce = if (it.isLocationShared)  R.drawable.icon_mylocation_on
                                        else R.drawable.icon_mylocation_off

                    locationOffIndicator.setBackgroundResource(imageResouce)

                }

                // 친구 마커 데이터 관찰
                friendMarkerList.observe(viewLifecycleOwner) {
                    initFriendMarker(it)
                }

                // 위치 데이터 관찰
                myLocation.observe(viewLifecycleOwner) { loc ->
                    myMarker.run {
                        position = loc
                        map = naverMap
                    }
                }
            }
        }

        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        try {
            viewBinding.apply {

                mapView.onCreate(savedInstanceState)
                initMap()
                initTopMenu()

                requestLocationPermission()
                imgDrop.setOnClickListener(this@CampusFragment)
                campusSchedule.setOnClickListener(this@CampusFragment)
                myStep.setOnClickListener(this@CampusFragment)

                togetherLayout.setOnClickListener(this@CampusFragment)
                mealLayout.setOnClickListener(this@CampusFragment)
                schoolLayout.setOnClickListener(this@CampusFragment)
                //eventLayout.setOnClickListener(this@CampusFragment)
                //m2eLayout.setOnClickListener(this@CampusFragment)
                selectSchoolLayout.setOnClickListener(this@CampusFragment)
                iconExpands.setOnClickListener(this@CampusFragment)
                iconCollapse.setOnClickListener(this@CampusFragment)

                mapZoomin.setOnClickListener(this@CampusFragment)
                mapZoomout.setOnClickListener(this@CampusFragment)

                locationOffIndicator.setOnClickListener(this@CampusFragment)

                /*
                if (viewModel.isShowSeminarPopup() && !toryApplication.isSeminarPopupOpenHistory) {
                    toryApplication.isSeminarPopupOpenHistory = true
                    SeminarPopup.Builder(requireContext())
                        .onClose {
                            if (repository.eventArray.isNotEmpty()) {
                                EventBottomDialogFragment(requireContext(), repository.eventArray).apply {
                                    setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                                    onClickListener = { data ->
                                        val eventInfo = data as EventDTO
                                        onClickEventItem(eventInfo)
                                    }
                                    show(this@CampusFragment.childFragmentManager, Constants.EventBottomDialogFragmentTag)
                                }
                            }
                        }
                        .onEnterButton {
                            seminarBtn.performClick()
                        }
                        .show()
                } else {
                    if (repository.eventArray.isNotEmpty()) {
                        EventBottomDialogFragment(requireContext(), repository.eventArray).apply {
                            setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                            onClickListener = { data ->
                                val eventInfo = data as EventDTO
                                onClickEventItem(eventInfo)
                            }
                            show(this@CampusFragment.childFragmentManager, Constants.EventBottomDialogFragmentTag)
                        }
                    }
                }
                 */

                if (!EventBus.getDefault().isRegistered(this@CampusFragment))
                    EventBus.getDefault().register(this@CampusFragment)

                if(isBuildingMarkerVisible) {
                    buildingVisibleToggleBtn.setBackgroundResource(R.drawable.icon_build_on)
                }
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


    override fun onStart() {
        super.onStart()
        viewBinding.apply {
            mapView.onStart()
        }
    }

    override fun onResume() {
        super.onResume()
        viewBinding.apply {
            mapView.onResume()
        }
    }

    override fun onPause() {
        super.onPause()
        viewBinding.apply {
            mapView.onPause()
        }
    }

    override fun onHiddenChanged(hidden: Boolean) {
        if(!hidden) {
            repository.getSeminarDetail(ApiMode.UIMode.NONE)
                .subscribeBy(onNext = { data ->
                    when( data.status ) {
                        SeminarStatus.FINISHED-> {
                            viewBinding.apply {
                                //seminarBtn.setVisible(false)
                            }
                        }
                        else -> {}
                    }

                }, onError = {})
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        viewBinding.apply {
            mapView.onSaveInstanceState(outState)
        }
    }

    override fun onStop() {
        super.onStop()
        viewBinding.apply {
            mapView.onStop()
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        viewBinding.apply {
            mapView.onDestroy()
        }

        if (!EventBus.getDefault().isRegistered(this))
            EventBus.getDefault().unregister(this)
    }

    override fun onLowMemory() {
        super.onLowMemory()
        viewBinding.apply {
            mapView.onLowMemory()
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.campus_schedule -> {

                if(repository.eventArray.isNotEmpty()) {
                    EventBottomDialogFragment(requireContext(), repository.eventArray).apply {
                        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                        onClickListener = { data ->
                            val eventInfo = data as EventListDTO
                            onClickEventItem(eventInfo)
                        }
                        show(this@CampusFragment.childFragmentManager, Constants.EventBottomDialogFragmentTag)
                    }
                }
            }

            R.id.myStep -> {
                if(checkActivityRecognitionPermission()) {
                    Intent(requireContext(), PedometerActivity::class.java).run {
                        startActivity(this)
                    }
                }else {
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(R.string.system_alert_permission_denied)
                        .setPositiveButton {  }
                        .show()
                }


            }

            R.id.imgDrop -> {
                viewBinding.apply {
                    if(titleContentLayout.isVisible()) {
                        imgDrop.animate().apply {
                            duration= 300
                            rotation(180f)
                        }
                        titleContentLayout.visibility = View.GONE
                    }else {
                        imgDrop.animate().apply {
                            duration= 300
                            rotation(0f)
                        }
                        titleContentLayout.visibility = View.VISIBLE
                    }

                }
            }


            R.id.together_layout -> {
                isDropDown = false

                viewBinding.apply {
                    //imgDrop.setImageResource(R.drawable.map_title_menu_drop_down)
                    imgDrop.animate().apply {
                        duration= 300
                        rotation(180f)
                    }
                    titleContentLayout.visibility = View.GONE
                }
                TogetherDialogFragment.TogetherDialogBuilder(childFragmentManager).apply {
                    setImageUrl(viewModel.getMyCampus().imgUrl)
                    setClickListener(object : CommonDialogInterface.OnClickListener {
                        override fun onClick(i: Int) {
                            val url = when(i){
                                R.id.tory_market_layout -> {
                                    firebaseAnalyticsMember( FirebaseParam.mobile_community_market)
                                    Web.Url.COMMUNITY_MARKET
                                }
                                R.id.tory_together_layout -> {
                                    firebaseAnalyticsMember( FirebaseParam.mobile_community_gother)
                                    Web.Url.COMMUNITY_GATHER
                                }
                                R.id.tory_talk_layout -> {
                                    firebaseAnalyticsMember( FirebaseParam.mobile_community_talk)
                                    Web.Url.COMMUNITY_TALK
                                }
                                R.id.tory_help_layout -> {
                                    firebaseAnalyticsMember( FirebaseParam.mobile_community_help)
                                    Web.Url.COMMUNITY_HELP
                                }

                                else -> {
                                    Web.Url.COMMUNITY_MARKET
                                }
                            }

                            Intent(context, ToryWebActivity::class.java).run {
                                putExtra(ToryWebActivity.PARAM_URL, url)
                                putExtra(ToryWebActivity.BACK_KEY, false)
                                startActivity(this)
                            }
                        }
                    })
                }.show()
            }

            R.id.meal_layout -> {
                isDropDown = false
                viewBinding.apply {
                    //imgDrop.setImageResource(R.drawable.map_title_menu_drop_down)
                    imgDrop.animate().apply {
                        duration= 300
                        rotation(180f)
                    }
                    titleContentLayout.visibility = View.GONE
                }

                if(Constants.is_FirebaseAnalytics) {
                    firebaseAnalyticsMember(FirebaseParam.mobile_school_meal)
                }

                Intent(context, ToryWebActivity::class.java).run {
                    putExtra(ToryWebActivity.PARAM_URL, Web.Url.SCHOOL_MEAL)
                    startActivity(this)
                }
            }

            R.id.school_layout -> {
                isDropDown = false
                viewBinding.apply {
                    //imgDrop.setImageResource(R.drawable.map_title_menu_drop_down)
                    imgDrop.animate().apply {
                        duration= 300
                        rotation(180f)
                    }
                    titleContentLayout.visibility = View.GONE
                }

                if(Constants.is_FirebaseAnalytics) {
                    firebaseAnalyticsMember(FirebaseParam.mobile_school_meal)
                }

                Intent(context, ToryWebActivity::class.java).run {
                    putExtra(ToryWebActivity.PARAM_URL, Web.Url.SCHOOL_EVENT)
                    startActivity(this)
                }
            }

            /*
            R.id.event_layout -> {
                isDropDown = false
                viewBinding.apply {
                    //imgDrop.setImageResource(R.drawable.map_title_menu_drop_down)
                    imgDrop.animate().apply {
                        duration= 300
                        rotation(180f)
                    }
                    titleContentLayout.visibility = View.GONE
                }
                if(repository.eventArray.isNotEmpty()) {
                    EventBottomDialogFragment(requireContext(), repository.eventArray).apply {
                        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                        onClickListener = { data ->
                            val eventInfo = data as EventDTO
                            onClickEventItem(eventInfo)
                        }
                        show(this@CampusFragment.childFragmentManager, Constants.EventBottomDialogFragmentTag)
                    }
                }
            }
            R.id.m2e_layout -> {
                isDropDown = false
                viewBinding.apply {
                    //imgDrop.setImageResource(R.drawable.map_title_menu_drop_down)
                    imgDrop.animate().apply {
                        duration= 300
                        rotation(180f)
                    }
                    titleContentLayout.visibility = View.GONE
                }

                Intent(requireContext(), PedometerActivity::class.java).run {
                    startActivity(this)
                }

            }
            */

            R.id.select_school_layout -> {
                isDropDown = false
                viewBinding.apply {
                    //imgDrop.setImageResource(R.drawable.map_title_menu_drop_down)
                    imgDrop.animate().apply {
                        duration= 300
                        rotation(180f)
                    }
                    titleContentLayout.visibility = View.GONE
                }

                CampusSelectView(requireActivity(), viewModel, visitCampusCode).apply {
                    onSelected = {
                        visitCampus(it)
                    }
                }.show()
            }

            R.id.iconExpands -> {
                viewBinding.apply {
                    leftIconGroup01.visibility = View.GONE
                    leftIconGroup02.animate().apply {
                        duration = 500
                        leftIconGroup02.visibility = View.VISIBLE
                    }
                }
            }

            R.id.iconCollapse -> {
                viewBinding.apply {
                    leftIconGroup02.visibility = View.GONE
                    //leftIconGroup01.visibility = View.VISIBLE
                    leftIconGroup01.animate().apply {
                        duration = 500
                        leftIconGroup01.visibility = View.VISIBLE
                    }
                }
            }

            R.id.map_zoomin -> {
                viewBinding.apply {
                    naverMap!!.cameraPosition = CameraPosition(naverMap!!.cameraPosition.target,
                                                                naverMap!!.cameraPosition.zoom + 1)
                }
            }
            R.id.map_zoomout -> {

                naverMap!!.cameraPosition = CameraPosition(naverMap!!.cameraPosition.target,
                                                        naverMap!!.cameraPosition.zoom - 1)
            }

            R.id.locationOffIndicator -> {
                viewBinding.apply {
                    val isShared = !viewModel.member.value!!.isLocationShared
                    viewModel.updateMyLocationShared(ApiMode.UIMode.NONE, isShared)

                    val imageResouce = if (isShared)  R.drawable.icon_mylocation_on
                                    else R.drawable.icon_mylocation_off
                    locationOffIndicator.setBackgroundResource(imageResouce)
                }

            }
        }
    }

    private fun checkActivityRecognitionPermission(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q)
            return true                     // We are good, Activity Recognition permission is not required before Android Q


        if (isActivityRecognitionPermissionGranted())
            return true                     // We are good, Activity Recognition permission already granted

        requestActivityRecognitionPermission()

        return false
    }


    private fun isActivityRecognitionPermissionGranted(): Boolean {
        return PermissionHelper.isPermissionGranted(requireContext(), recogitionPermissions)
    }

    private fun requestActivityRecognitionPermission() {
        if( PermissionHelper.shouldShowRequestPermissionRationale(requireActivity(), recogitionPermissions) ) {
        }
        // 권한 요청
        else {
            PermissionHelper.requestPermission(requireActivity(), recogitionPermissions, PERMISSION_REQUEST_ACTIVITY_RECOGNITION)
        }
    }

    private fun onClickEventItem(eventInfo :EventListDTO)  {
        try {
            val detailArray = eventInfo.bannerAppUrl.split(":")
            if (detailArray.isNotEmpty()) {
                if (detailArray[0] == "W") {
                    if(detailArray[1] == "/event/event001") {
                        if(Constants.is_FirebaseAnalytics) {
                            firebaseAnalyticsMember(FirebaseParam.mobile_present)
                        }
                    }
                    val url = "${Web.Url.BASE}${detailArray[1]}"
                    Intent(context, ToryWebActivity::class.java).run {
                        putExtra(ToryWebActivity.PARAM_URL, url)
                        startActivity(this)
                    }
                } else if (detailArray[0] == "N") {
                    if (detailArray[1] == "stu") {
                        Intent(requireContext(), PedometerActivity::class.java).run {
                            startActivity(this)
                        }
                    }
                }
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    /**
     * 마커 클릭
     */
    private fun onClickMarker(marker: Marker): Boolean {
        val userData = marker.tag as MarkerUserData

        when( userData.type ) {
            // 내 마커
            MarkerType.MY-> {
                MarkerDetailView(requireActivity(), viewModel).show()
                return true
            }

            // 친구 마커
            MarkerType.FRIEND-> {
                val data = userData.data as MarkerDTO
                viewModel.getFriend(ApiMode.UIMode.NONE, data.memberId!!).subscribeBy(onNext = {

                    FriendDetailView(requireActivity(), it, toryApplication.repository).run {
                        onClickListener = {
                            Intent(requireContext(), ChattingActivity::class.java).run {
                                startActivity(this)
                            }
                        }
                        show()
                    }
                }, onError = {
                })

                return true
            }

            // 건물 마커
            MarkerType.BUILDING-> {
                val data = userData.data as MarkerDTO
                viewModel.getMarkerDetail(data.markerId).subscribeBy(onNext = {
                    MarkerDetailBuildingView(requireActivity(), it).show()
                }, onError = {
                })
                return true
            }

            else-> {}
        }

        return false
    }

    /**
     * 캠퍼스 방문
     */
    private fun visitCampus(campus: UniversityDTO) {
        if( campus.universityCode == viewModel.getMyCampus().universityCode ) {
            return
        }

        removeVisitCampusMarkers()
        scrollToCampus(campus)

        visitCampusCode = campus.universityCode

        // 방문 캠퍼스 마커 추가
        visitCampusMarker = createMarker(MarkerType.CAMPUS, R.dimen.marker_campus_width, R.dimen.marker_campus_height).apply {
            (tag as MarkerUserData).data = campus
            position = LatLng(campus.lat, campus.lng)
            map = naverMap
            updateMarkerImage(this, campus.imgUrl)
        }

        // 방문 캠퍼스 건물 마커 생성
        viewModel.getCampusBuildingMarker(campus.universityCode).subscribeBy(onNext = { markerDatas ->
            markerDatas.forEach { data ->
                val marker = addBuildingMarker(data)
                visitCampusBuildingMarkers.add(marker)
            }
        }, onError = {
        })
    }

    /**
     * 방문 캠퍼스 마커를 모두 삭제합니다
     */
    private fun removeVisitCampusMarkers() = try {
        visitCampusCode = null

        visitCampusMarker?.let {
            removeMarker(it)
        }
        visitCampusMarker = null

        visitCampusBuildingMarkers.forEach {
            removeMarker(it)
        }
        visitCampusBuildingMarkers.clear()
    }catch (e : Exception){
        Timber.d(e.message)
    }

    /**
     * 맵 위치 이동
     */
    private fun scrollTo(position: LatLng, restoreZoom: Boolean = true): CameraUpdate {
        val scroll = CameraUpdate.scrollTo(LatLng(position.latitude, position.longitude))
            .animate(CameraAnimation.None)
            .finishCallback {

            }
            .cancelCallback {

            }
        naverMap?.moveCamera(scroll)

        if( restoreZoom ) {
            val zoom = CameraUpdate.zoomTo(NaverMap.DEFAULT_CAMERA_POSITION.zoom)
                .animate(CameraAnimation.None)
            naverMap?.moveCamera(zoom)
        }

        return scroll
    }

    private fun scrollTo(lat: Double, lng: Double, restoreZoom: Boolean = true): CameraUpdate = scrollTo(LatLng(lat, lng), restoreZoom)

    /**
     * 현 위치로 이동합니다
     */
    private fun scrollToCurrentPosition() {
        if( !isLocationPermissionGranted() ) {
            CommonAlertDialog.Builder(requireContext())
                .setCancelable(false)
                .setMessage(R.string.location_permission_denied)
                .setPositiveButton(resources.getString(R.string.app_setting_open)){
                    Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + requireContext().packageName)).run {
                        addCategory(Intent.CATEGORY_DEFAULT)
                        flags = Intent.FLAG_ACTIVITY_NEW_TASK
                        startActivity(this)
                    }
                }
                .show()
            return
        }

        val loc = locationSource.lastLocation
        loc?.let {
            scrollTo(it.latitude, it.longitude)
        }

        Log.i(TAG, "현 위치로 이동: " + (loc ?: "좌표없음"))
    }

    /**
     * 캠퍼스로 이동합니다
     */
    private fun scrollToCampus(campus: UniversityDTO) {
        scrollTo(campus.lat, campus.lng)
    }

    private fun scrollToMyCampus() = scrollToCampus(viewModel.getMyCampus())

    /**
     * 건물 마커 visible을 설정합니다
     */
    private fun setBuildingMarkerVisible(isVisible: Boolean) {
        if( isBuildingMarkerVisible == isVisible ) {
            return
        }
        isBuildingMarkerVisible = isVisible

        getMyCampusBuildingMarkers().apply {
            if( isVisible ) {
                forEach { marker ->
                    marker.map = naverMap
                }
            } else {
                forEach { marker ->
                    marker.map = null
                }
            }
        }
    }

    /**
     * 마커 이미지 업데이트
     */
    private fun updateMarkerImage(marker: Marker, url: String) {
        Glide.with(this).asBitmap()
            .load(url)
            .into(object: CustomTarget<Bitmap?>(marker.width, marker.height) {
                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap?>?) {
                    marker.icon = OverlayImage.fromBitmap(resource)
                }
                override fun onLoadCleared(placeholder: Drawable?) {}
            })
    }

    /**
     * 마커를 생성합니다
     */
    private fun createMarker(type: MarkerType, widthResId: Int, heightResId: Int): Marker {
        val marker = Marker().apply {
            tag = MarkerUserData(type)
            width = ToryApplication.context!!.resources.getDimension(widthResId).toInt()
            height = ToryApplication.context!!.resources.getDimension(heightResId).toInt()
            zIndex = run {
                when( type ) {
                    MarkerType.MY->         5
                    MarkerType.FRIEND->     4
                    MarkerType.CAMPUS->     3
                    MarkerType.BUILDING->   2
                }
            }

            setOnClickListener {
                onClickMarker(this)
            }
        }
        return marker
    }

    private fun removeMarker(marker: Marker) = try {
        marker.map = null
        buildingMarkers.remove(marker)
    }catch (e : Exception){
        Timber.d(e.message)
    }


    /**
     * 건물 마커를 추가합니다
     */
    private fun addBuildingMarker(data: MarkerDTO): Marker {
        val marker = createMarker(MarkerType.BUILDING, R.dimen.marker_building_width, R.dimen.marker_building_height).apply {
            (tag as MarkerUserData).data = data
            position = LatLng(data.lat, data.lng)
            map = naverMap

            updateMarkerImage(this, data.imgUrl)
        }

        buildingMarkers.add(marker)
        return marker
    }

    private fun getMyCampusBuildingMarkers(): List<Marker> {
        return buildingMarkers.filter { marker ->
            val userData = marker.tag as MarkerUserData
            (userData.data as MarkerDTO).universityCode == viewModel.getMyCampus().universityCode
        }
    }

    /**
     * 맵을 초기화합니다
     */
    private fun initMap() = viewBinding.apply{
        locationSource = FusedLocationSource(this@CampusFragment, REQUEST_CODE_PERMISSION_LOCATION)
        locationSource.activate {
            it?.let {
                viewModel.updateMyLocation(LatLng(it.latitude, it.longitude))
            }
        }

        // Naver Map 객체 초기화
        mapView.getMapAsync {
            naverMap = it
            naverMap!!.locationSource = locationSource
            // naverMap.locationTrackingMode = LocationTrackingMode.Follow

            scrollToMyCampus()
            initMarker()

        }

        //uiSettings.isZoomControlEnabled = false

        // 내 위치 클릭
        myLocationBtn.setOnClickListener {
            scrollToCurrentPosition()
        }

        myLocationBtn01.setOnClickListener {
            scrollToCurrentPosition()
        }
        // 건물 Visible 토글 클릭
        buildingVisibleToggleBtn.setOnClickListener {
            setBuildingMarkerVisible(!isBuildingMarkerVisible)

            val imageResouce = if (isBuildingMarkerVisible) R.drawable.icon_build_on
                                else R.drawable.icon_build_off
            viewBinding.buildingVisibleToggleBtn.setBackgroundResource(imageResouce)
        }

        // 학교 버튼 클릭
        myCampusBtn.setOnClickListener {
            removeVisitCampusMarkers()
            scrollToMyCampus()
        }

        /*
        // 캠퍼스 방문 클릭
        visitCampusBtn.setOnClickListener {
            CampusSelectView(requireActivity(), viewModel, visitCampusCode).apply {
              onSelected = {
                  visitCampus(it)
              }
            }.show()
        }
        */

        /*
        // 3D 클릭
        map3dBtn.setOnClickListener {

            if(Constants.is_FirebaseAnalytics) {
                firebaseAnalyticsMember(FirebaseParam.mobile_metaverse)
            }

            if( viewModel.member.value?.universityCode == "CAU" ) {

                ToryUnityActivity.createIntent(requireContext(), ToryUnityActivity.SCENE_TYPE_CAMPUS).run {
                    startActivity(this)
                }

            } else {

                ToryUnityActivity.createIntent(requireContext(), ToryUnityActivity.SCENE_TYPE_CAMPUS_EMPTY).run {
                    startActivity(this)
                }
            }
        }
        */
        /*
        // 세미나 ON AIR 버튼
        seminarBtn.setVisible(viewModel.isShowSeminarOnAirButton())
        seminarBtn.setOnClickListener {
            viewModel.getSeminarDetail(ApiMode.UIMode.NONE)
                .subscribeBy(onNext = { data ->
                    when( data.status ) {
                        SeminarStatus.ENTER-> {
                            if(Constants.is_FirebaseAnalytics) {
                                firebaseAnalyticsMember(FirebaseParam.mobile_seminar)
                            }
                            ToryUnityActivity.createSeminarIntent(requireContext(), data.videoUrl ?: "").run {
                                startActivity(this)
                            }
                        }
                        SeminarStatus.NOT_STARTED-> {
                            Toast.makeText(requireContext(), R.string.system_alert_seminar_not_started, Toast.LENGTH_SHORT).show()
                        }
                        SeminarStatus.FINISHED-> {
                            Toast.makeText(requireContext(), R.string.system_alert_seminar_finished, Toast.LENGTH_SHORT).show()
                        }
                        else -> {}
                    }

                }, onError = {})
        }
         */
    }

    /**
     * 마커를 초기화합니다
     */
    private fun initMarker() = try {

        naverMap!!.uiSettings.isZoomControlEnabled = false

        // 내 캠퍼스 마커 추가
        with(viewModel.getMyCampus()) {
            (myCampusMarker.tag as MarkerUserData).data = this
            myCampusMarker.position = LatLng(lat, lng)
            myCampusMarker.map = naverMap
            updateMarkerImage(myCampusMarker, imgUrl)
        }

        // 내 캠퍼스 건물 마커 생성
        viewModel.getMyCampusBuildingMarker().subscribeBy(onNext = { markerDatas ->
            markerDatas.forEach { data ->
                addBuildingMarker(data)
            }
        }, onError = {
        })

        // 친구 마커 생성
        viewModel.friendMarkerList.value?.let {
            initFriendMarker(it)
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    /**
     * 친구 마커를 초기화합니다
     */
    private fun initFriendMarker(markerDataList: List<MarkerDTOEnc>) {
        if( naverMap == null ) {
            return
        }

        // remove previous marker
        friendMarkers.forEach {
            removeMarker(it)
        }
        friendMarkers.clear()

        markerDataList.forEach { data ->
            val marker = createMarker(MarkerType.FRIEND, R.dimen.my_custom_marker_width, R.dimen.my_custom_marker_height).apply {
                (tag as MarkerUserData).data = data
                //position = LatLng(data.lat, data.lng)
                position = LatLng(Utilts.instance.decryptCBC(data.lat).toDouble(),
                                    Utilts.instance.decryptCBC(data.lng).toDouble())
                map = naverMap

                val marker = this
                Glide.with(requireContext()).asBitmap()
                    .load(data.imgUrl)
                    .transform(CenterCrop(), RoundedCorners(resources.getDimension(R.dimen.marker_my_icon_radius).toInt()))
                    .into(object: CustomTarget<Bitmap>() {
                        override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap?>?) {
                            val customViewBinding = MyFriendCustomMarkerBinding.inflate(LayoutInflater.from(context))
                            customViewBinding.apply {
                                imgMarker.setImageBitmap(resource)
                            }
                            marker.icon = OverlayImage.fromView(viewBinding.root)
                        }
                        override fun onLoadCleared(placeholder: Drawable?) {}
                    })

            }

            friendMarkers.add(marker)
        }
    }

    /**
     * 상단 메뉴 클릭
     */
    private fun onClickTopMenu(type: CampusTopMenuType) {
        when( type ) {
            CampusTopMenuType.TALK -> {

                if(Constants.is_FirebaseAnalytics) {
                    firebaseAnalyticsMember(FirebaseParam.mobile_torytolk)
                }

                Intent(context, ToryTalkActivity::class.java).run {
                    startActivity(this)
                }
            }

            CampusTopMenuType.TOGETHER -> {
                BoardSelectView(viewModel.getMyCampus().imgUrl, requireActivity()).apply {
                    onClickListener = { url ->

                        if(Constants.is_FirebaseAnalytics) {
                            val eventId = when (url) {
                                Web.Url.COMMUNITY_MARKET -> FirebaseParam.mobile_community_market
                                Web.Url.COMMUNITY_GATHER -> FirebaseParam.mobile_community_gother
                                Web.Url.COMMUNITY_TALK -> FirebaseParam.mobile_community_talk
                                Web.Url.COMMUNITY_HELP -> FirebaseParam.mobile_community_help
                                else -> FirebaseParam.mobile_community_market
                            }

                            firebaseAnalyticsMember(eventId)
                        }

                        Intent(context, ToryWebActivity::class.java).run {
                            putExtra(ToryWebActivity.PARAM_URL, url)
                            startActivity(this)
                        }
                    }
                }.show()

            }

            CampusTopMenuType.SCHOOL_MEAL -> {
                if(Constants.is_FirebaseAnalytics) {
                    firebaseAnalyticsMember(FirebaseParam.mobile_school_meal)
                }

                Intent(context, ToryWebActivity::class.java).run {
                    putExtra(ToryWebActivity.PARAM_URL, Web.Url.SCHOOL_MEAL)
                    startActivity(this)
                }
            }

            CampusTopMenuType.SCHOOL_EVENT -> {
                if(Constants.is_FirebaseAnalytics) {
                    firebaseAnalyticsMember(FirebaseParam.mobile_school_event)
                }

                Intent(context, ToryWebActivity::class.java).run {
                    putExtra(ToryWebActivity.PARAM_URL, Web.Url.SCHOOL_EVENT)
                    startActivity(this)
                }
            }
        }
    }

    /**
     * 상단 메뉴를 초기화합니다
     */
    private fun initTopMenu() = viewBinding.apply {
        topListView.layoutManager = LinearLayoutManager(context, RecyclerView.HORIZONTAL, false)
        topListView.adapter = CampusTopMenuAdapter({ menuType ->
            onClickTopMenu(menuType)
        }, topMenuArray)

        val dividerWidth = resources.getDimension(R.dimen.campus_top_list_item_padding_horizontal)
        topListView.addItemDecoration(Divider(dividerWidth.toInt(), 0))
    }


    /**
     *  위치 권한을 요청합니다
     */

    private val locationPermissions = arrayOf(
        Manifest.permission.ACCESS_FINE_LOCATION,
        Manifest.permission.ACCESS_COARSE_LOCATION
    )

    private fun isLocationPermissionGranted(): Boolean {
        return PermissionHelper.isPermissionGranted(requireContext(), locationPermissions)
    }

//    private val locationPermissionLauncher : ActivityResultLauncher<Array<String>> =
//        registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
//            // 권한 허용
//            if( isLocationPermissionGranted() ) {
//
//            }
//            // 권한 거부
//            else {
//            }
//        }



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



    private fun requestLocationPermission() {
        // 이미 허용
        if( isLocationPermissionGranted() ) {
            return
        }

        // 거부됨
        if( PermissionHelper.shouldShowRequestPermissionRationale(requireActivity(), locationPermissions) ) {
        }
        // 권한 요청
        else {
            PermissionHelper.requestPermission(requireActivity(), locationPermissions, REQUEST_CODE_PERMISSION_LOCATION)

        }
    }



    @Subscribe(threadMode = ThreadMode.MAIN)
    fun eventUpdate(eventBus: EventTypeBus) {
        try {
            when(eventBus.type) {
                EventType.UPDATE -> {
                    viewBinding.apply {
                        mapView.getMapAsync {
                            naverMap = it
                            naverMap!!.locationSource = locationSource

                            scrollToMyCampus()
                            initMarker()
                        }
                    }
                }
                else -> {}
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }




}
