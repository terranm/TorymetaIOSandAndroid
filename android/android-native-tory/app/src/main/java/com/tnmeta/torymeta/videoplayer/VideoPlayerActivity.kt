package com.tnmeta.torymeta.videoplayer

import android.app.ActionBar.LayoutParams
import android.content.Context
import android.content.Intent
import android.content.pm.ActivityInfo
import android.content.res.Configuration.ORIENTATION_LANDSCAPE
import android.content.res.Configuration.ORIENTATION_PORTRAIT
import android.content.res.Resources
import android.media.AudioManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.provider.Settings.SettingNotFoundException
import android.view.GestureDetector
import android.view.KeyEvent
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.ImageButton
import androidx.activity.OnBackPressedCallback
import androidx.core.content.ContextCompat
import androidx.core.view.GestureDetectorCompat
import androidx.lifecycle.ViewModelProvider
import androidx.media3.common.MediaItem
import androidx.media3.common.PlaybackException
import androidx.media3.common.Player
import androidx.media3.common.Player.STATE_BUFFERING
import androidx.media3.common.Player.STATE_ENDED
import androidx.media3.common.Player.STATE_IDLE
import androidx.media3.common.Player.STATE_READY
import androidx.media3.common.util.UnstableApi
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.DefaultHttpDataSource
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.dash.DashMediaSource
import androidx.media3.exoplayer.hls.HlsMediaSource
import androidx.media3.exoplayer.source.MediaSource
import androidx.media3.exoplayer.source.ProgressiveMediaSource
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.LinearSmoothScroller
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.control.click.DoubleClick
import com.tnmeta.torymeta.control.click.DoubleClickListener
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityVideoPlayerBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.isVisible
import com.tnmeta.torymeta.videoplayer.adapter.VideoInfoAdapter
import com.tnmeta.torymeta.videoplayer.model.LectureInfo
import com.tnmeta.torymeta.videoplayer.model.LectureVideoInfo
import com.tnmeta.torymeta.videoplayer.model.VideoInfoResult
import com.tnmeta.torymeta.videoplayer.model.param.LectureInfoParam
import com.tnmeta.torymeta.videoplayer.model.param.PlayVideoUpdateEndParam
import com.tnmeta.torymeta.videoplayer.model.param.PlayVideoUpdatePositionParam
import com.tnmeta.torymeta.videoplayer.model.param.PlayerInfoParam
import com.tnmeta.torymeta.videoplayer.viewmodel.VideoInfoViewModel
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import timber.log.Timber
import kotlin.math.abs


class VideoPlayerActivity : BaseActivity(), View.OnClickListener {

    companion object {
        val TAG: String = VideoPlayerActivity::class.java.simpleName
        fun createIntent(context: Context): Intent {
            return Intent(context, VideoPlayerActivity::class.java)
        }
    }

    private val viewBinding by viewBinding(ActivityVideoPlayerBinding::inflate)
    private var exoPlayer: ExoPlayer? = null
    private val dataSourceFactory: DataSource.Factory = DefaultHttpDataSource.Factory()

    private lateinit var viewModel: VideoInfoViewModel
    private lateinit var lectureInfo: LectureInfo
    private lateinit var videoInfoAdapter: VideoInfoAdapter

    private val mVideoInfoArray = ArrayList<LectureVideoInfo>()
    private var selectedPosition = -1

    private var playerVideoInfo : VideoInfoResult? = null

    private var gestureDetectorCompat : GestureDetectorCompat? = null
    private var touchPositionX = 0
    private var volume = 0
    private var shouldShowController = true
    private var audioManager: AudioManager? = null
    private val showMaxVolume = 50
    private val showMaxBrightness = 100
    private var brightness = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {
                setContentView(root)

                requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT

                audioManager = getSystemService(AUDIO_SERVICE) as AudioManager

                brightness = (getCurrentScreenBrightness() * 100).toInt()
                setVolumeVariable()

                initPlayer()

                viewModel = ViewModelProvider(this@VideoPlayerActivity)[VideoInfoViewModel::class.java]
                initData()

                playerView.apply {
                    arrayOf(findViewById<ImageButton>(R.id.screen_rotate_btn),
                            findViewById(R.id.img_sound),
                            findViewById(R.id.backward_10),
                            findViewById(R.id.forward_10),
                            findViewById(R.id.back_button),
                            findViewById(R.id.fit_screen_btn)
                        ).forEach {
                            it.setOnClickListener(this@VideoPlayerActivity)
                    }
                }

                if (intent.hasExtra(Params.LECTUREINFO)) {
                    lectureInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        intent.getParcelableExtra(Params.LECTUREINFO, LectureInfo::class.java)!!
                    } else {
                        intent.getParcelableExtra(Params.LECTUREINFO)!!
                    }

                    lectureTitle.text = String.format("%s%s", resources.getString(R.string.subject_title), lectureInfo.subject)

                    getLectureInfo()
                }

                refreshLayout.setOnRefreshListener {
                    CoroutineScope(Dispatchers.Main).launch {
                        viewModel.apply {
                            mVideoInfoArray.clear()
                            getLectureInfo()
                        }
                    }
                    refreshLayout.isRefreshing = false
                    loadingProgress.visibility = View.VISIBLE
                }
            }

            this.onBackPressedDispatcher.addCallback(this, onBackCall)

        } catch (e: Exception) {
            Timber.d(e.message)
        }
    }


    override fun onClick(view: View) {
        when (view.id) {
            R.id.ivBack -> finish()
            R.id.screen_rotate_btn -> {
                try {
                    val currentOrientation = resources.configuration.orientation

                    requestedOrientation = when(currentOrientation) {
                        ORIENTATION_PORTRAIT -> {
                            isShowViewController(false)
                            setFullScreen()
                            ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE
                        }

                        ORIENTATION_LANDSCAPE -> {
                            isShowViewController(true)
                            setNormalScreen()
                            ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
                        }

                        else -> {
                            isShowViewController(true)
                            setNormalScreen()
                            ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
                        }
                    }

                } catch (e: Exception) {
                    Timber.tag(TAG).d(e.message)
                }
            }

            R.id.img_sound -> {
                viewBinding.apply {
                    val currentVolume = exoPlayer?.volume
                    Timber.tag(TAG).d("currentVolume $currentVolume")

                    playerView.apply {
                        if (currentVolume == 0f) {
                            exoPlayer?.volume = 1f
                            findViewById<ImageButton>(R.id.img_sound).setBackgroundResource(R.drawable.img_sound_on)
                        } else {
                            exoPlayer?.volume = 0f
                            findViewById<ImageButton>(R.id.img_sound).setBackgroundResource(R.drawable.img_sound_off)
                        }
                    }
                }
            }

            R.id.backward_10 -> {
                exoPlayer?.seekTo(exoPlayer?.currentPosition?.minus(10000) ?: 0)
            }

            R.id.forward_10 -> {
                exoPlayer?.seekTo(exoPlayer?.currentPosition?.plus(10000) ?: 0)
            }

            R.id.back_button -> {
                requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
                isShowViewController(true)
                setNormalScreen()
            }

            /*
            R.id.fit_screen_btn -> {
                viewBinding.apply {
                    when(playerView.resizeMode) {
                        AspectRatioFrameLayout.RESIZE_MODE_FIT -> {
                            playerView.apply {
                                resizeMode = AspectRatioFrameLayout.RESIZE_MODE_ZOOM
                                findViewById<ImageButton>(R.id.fit_screen_btn).setBackgroundResource(R.drawable.crop_5_4)
                            }
                            Toast.makeText(this@VideoPlayerActivity, "ZOOM", Toast.LENGTH_SHORT).show()
                        }
                        AspectRatioFrameLayout.RESIZE_MODE_ZOOM -> {
                            playerView.apply {
                                resizeMode = AspectRatioFrameLayout.RESIZE_MODE_FILL
                                findViewById<ImageButton>(R.id.fit_screen_btn).setBackgroundResource(R.drawable.fit_screen)
                            }
                            Toast.makeText(this@VideoPlayerActivity, "FILL", Toast.LENGTH_SHORT).show()
                        }

                        AspectRatioFrameLayout.RESIZE_MODE_FILL -> {
                            playerView.apply {
                                resizeMode = AspectRatioFrameLayout.RESIZE_MODE_FIT
                                findViewById<ImageButton>(R.id.fit_screen_btn).setBackgroundResource(R.drawable.crop_free)
                            }
                            Toast.makeText(this@VideoPlayerActivity, "FIT", Toast.LENGTH_SHORT).show()
                        }
                    }
                }
            }
            */
        }
    }


    override fun onKeyUp(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_VOLUME_UP || keyCode == KeyEvent.KEYCODE_VOLUME_DOWN) {
            setVolumeVariable()
        }
        return super.onKeyUp(keyCode, event)
    }

    private var mVideoPlayerHeight = 0


    private fun isShowViewController(isVisible: Boolean) = viewBinding.apply {

        try {
            val viewValue = if (isVisible) View.VISIBLE else View.GONE

            titleLayout.visibility = viewValue
            lectureTitle.visibility = viewValue
            refreshLayout.visibility = viewValue
            videoNoticeLayout.visibility = viewValue

            if (isVisible) {
                playerView.apply {
                    layoutParams = ViewGroup.LayoutParams(LayoutParams.MATCH_PARENT, mVideoPlayerHeight)
                    findViewById<ImageButton>(R.id.back_button).visibility = View.GONE
                }

            } else {
                mVideoPlayerHeight = playerView.height

                playerView.apply {
                    findViewById<ImageButton>(R.id.back_button).visibility = View.VISIBLE
                    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
                }
            }

        } catch (e: Exception) {
            Timber.d("isShowViewController error ${e.message}")
        }
    }


    /*
    private fun isShowViewController(isVisible: Boolean) = viewBinding.apply {
        try {
            val viewValue = if (isVisible) View.VISIBLE else View.GONE

            titleLayout.visibility = viewValue
            lectureTitle.visibility = viewValue
            refreshLayout.visibility = viewValue
            videoNoticeLayout.visibility = viewValue

            if (isVisible) {

                videoRootView.removeAllViews()

                val set = ConstraintSet()

                titleLayout.apply {
                    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                        gravity = Gravity.TOP
                    }
                }
                videoRootView.addView(titleLayout, 0)
                set.clone(videoRootView)

                set.connect(titleLayout.id, ConstraintSet.TOP, ConstraintSet.PARENT_ID, ConstraintSet.TOP)

                /*
                lectureTitle.apply {
                    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                        gravity = Gravity.TOP
                    }
                }

                videoRootView.addView(lectureTitle, 1)
                set.connect(lectureTitle.id, ConstraintSet.TOP, titleLayout.id, ConstraintSet.BOTTOM)
                //set.applyTo(videoRootView)

                playerView.apply {
                    layoutParams = ViewGroup.LayoutParams(LayoutParams.MATCH_PARENT, mVideoPlayerHeight)
                    findViewById<ImageButton>(R.id.back_button).visibility = View.GONE
                }

                videoLayout.apply {
                    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                        gravity = Gravity.CENTER
                    }
                }

                videoRootView.addView(videoLayout, 2)
                set.connect(videoLayout.id, ConstraintSet.TOP, lectureTitle.id, ConstraintSet.BOTTOM)
                */

                playerView.apply {
                    layoutParams = ViewGroup.LayoutParams(LayoutParams.MATCH_PARENT, mVideoPlayerHeight)
                    findViewById<ImageButton>(R.id.back_button).visibility = View.GONE
                }

                videoLayout.apply {
                    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                        gravity = Gravity.CENTER
                    }
                }
                videoRootView.addView(videoLayout, 1)

                set.connect(videoLayout.id, ConstraintSet.TOP, titleLayout.id, ConstraintSet.BOTTOM)
                set.connect(videoLayout.id, ConstraintSet.LEFT, ConstraintSet.PARENT_ID, ConstraintSet.LEFT)
                set.connect(videoLayout.id, ConstraintSet.RIGHT, ConstraintSet.PARENT_ID, ConstraintSet.RIGHT)
                set.applyTo(videoRootView)

            } else {
                mVideoPlayerHeight = playerView.height
                playerView.apply {
                    findViewById<ImageButton>(R.id.back_button).visibility = View.VISIBLE
                    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
                }

                videoLayout.apply {
                    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT).apply {
                        gravity = Gravity.CENTER
                    }
                }
            }

        } catch (e: Exception) {
            Timber.d("isShowViewController error ${e.message}")
        }
    }
    */


    private fun getLectureInfo() = try {
        viewModel.apply {
            val param = BaseParam(
                LectureInfoParam(
                    wrId = lectureInfo.wrId.toString(),
                    lecId = lectureInfo.lecId
                )
            ).parameter
            getLectureInfo(param)
        }

    } catch (e: Exception) {
        Timber.d(e.message)
    }


    @androidx.annotation.OptIn(UnstableApi::class)
    private fun initData() = viewBinding.apply {
        try {
            viewModel.apply {
                videoInfoAdapter = VideoInfoAdapter(
                    items = mVideoInfoArray,
                    onItemViewClick = { info, position ->
                        if (loadingProgress.isVisible())
                            return@VideoInfoAdapter

                        selectedPosition = position
                        val param = BaseParam(PlayerInfoParam(
                                                applyId = info.applyId,
                                                lecId = info.lecId,
                                                wrOrder = info.wrOrder)).parameter

                        Timber.tag(TAG).d("getVideoInfo $param")

                        CoroutineScope(Dispatchers.Main).launch {
                            val smoothScroller: RecyclerView.SmoothScroller by lazy {
                                object : LinearSmoothScroller(this@VideoPlayerActivity) {
                                    override fun getVerticalSnapPreference() = SNAP_TO_START
                                }
                            }
                            smoothScroller.targetPosition = position
                            recyclerView.layoutManager?.startSmoothScroll(smoothScroller)
                        }

                        getVideoInfo(param).subscribeBy(onNext = {
                            if (it.isResultOK) {
                                try {
                                    playerVideoInfo = it.result
                                    playerView.setBackgroundColor(ContextCompat.getColor(this@VideoPlayerActivity,  R.color.tory_white))
                                    video.visibility = View.VISIBLE
                                    bufferProgressbar.visibility = View.VISIBLE
                                    playerError01.visibility = View.GONE
                                    playerError02.visibility = View.GONE

                                    //divideLine.visibility = View.GONE

                                    val url = it.result!!.contentUrl

                                    val source = if (url.contains("m3u8")) {
                                        getHlsMediaSource(url)
                                    } else if (url.contains("mp3") || url.contains("mp4")) {
                                        getProgressiveMediaSource(url)
                                    } else if (url.contains("mp4")) {
                                        getDashMediaSource(url)
                                    } else {
                                        getProgressiveMediaSource(url)
                                    }

                                    //playerVideoInfo!!.curpos = 15

                                    Timber.tag(TAG).d("current pos ${playerVideoInfo!!.curpos}")

                                    exoPlayer!!.apply {
                                        setMediaSource(source)
                                        prepare()
                                        seekTo(0, playerVideoInfo!!.curpos.toLong() * 1000)
                                    }

                                } catch (e: Exception) {
                                    Timber.d("VideoPlay error - ${e.message}")
                                }
                            }
                        })
                    },
                    selectedPosition = selectedPosition
                )

                recyclerView.apply {
                    layoutManager = LinearLayoutManager(this@VideoPlayerActivity)
                    adapter = videoInfoAdapter
                }

                videoList.observe(this@VideoPlayerActivity) { list ->
                    try {
                        mVideoInfoArray.apply {
                            clear()
                            addAll(list)
                        }

                        if (selectedPosition != -1 && selectedPosition < mVideoInfoArray.size) {
                            if (mVideoInfoArray[selectedPosition] != null) {
                                val selectValue = mVideoInfoArray[selectedPosition]
                                selectValue.isSelect = true
                                mVideoInfoArray[selectedPosition] = selectValue
                            }
                        }

                        videoInfoAdapter.apply {
                            notifyDataSetChanged()
                        }

                        loadingProgress.visibility = View.GONE

                    } catch (e: Exception) {
                        Timber.tag(TAG).d(e.message)
                    }
                }
            }
        } catch (e: Exception) {
            Timber.d(e.message)
        }
    }


    private fun initPlayer() = viewBinding.apply {
        try {
            exoPlayer = ExoPlayer.Builder(this@VideoPlayerActivity).build()
                .apply {
                    addListener(playerListener)
                }

            playerView.setOnTouchListener { _: View?, motionEvent: MotionEvent ->
                gestureDetectorCompat!!.onTouchEvent(motionEvent)
                if (motionEvent.action == MotionEvent.ACTION_UP) {
                    brightnessVolumeContainer.visibility = View.GONE
                    if (!shouldShowController) {
                        playerView.useController = false

                        Handler(Looper.getMainLooper()).postDelayed({
                            shouldShowController = true
                            playerView.useController = true
                        }, 500)
                    }
                }
                if (motionEvent.action == MotionEvent.ACTION_DOWN) {
                    touchPositionX = motionEvent.x.toInt()
                }
                false
            }

            playerView.setOnClickListener(DoubleClick(object : DoubleClickListener {
                override fun onSingleClickEvent(view: View?) {}

                override fun onDoubleClickEvent(view: View?) {
                    try {
                        playerView.useController = false
                        Handler(Looper.getMainLooper()).postDelayed({
                            playerView.useController = true
                        }, 500)

                        val deviceWidth = Resources.getSystem().displayMetrics.widthPixels
                        if (touchPositionX < deviceWidth / 2) {
                            doubleTapSkipBackwardIcon.visibility = View.VISIBLE
                            Handler(Looper.getMainLooper()).postDelayed({ doubleTapSkipBackwardIcon.visibility = View.GONE }, 500)
                            exoPlayer!!.seekTo(exoPlayer!!.currentPosition - 10000)
                        } else {
                            doubleTabSkipForwardIcon.visibility = View.VISIBLE
                            Handler(Looper.getMainLooper()).postDelayed({ doubleTabSkipForwardIcon.visibility = View.GONE }, 500)
                            exoPlayer!!.seekTo(exoPlayer!!.currentPosition + 10000)
                        }
                    }catch (e : Exception){
                        Timber.d(e.message)
                    }
                }
            }))

            gestureDetectorCompat = GestureDetectorCompat(this@VideoPlayerActivity, object : GestureDetector.OnGestureListener {
                override fun onDown(motionEvent: MotionEvent): Boolean {
                    return false
                }

                override fun onShowPress(motionEvent: MotionEvent) {}
                override fun onSingleTapUp(motionEvent: MotionEvent): Boolean {
                    return false
                }

                override fun onLongPress(motionEvent: MotionEvent) {}
                override fun onFling(motionEvent: MotionEvent, motionEvent1: MotionEvent, v: Float, v1: Float): Boolean {
                    return false
                }

                override fun onScroll(motionEvent: MotionEvent, motionEvent1: MotionEvent, distanceX: Float, distanceY: Float): Boolean {
                    try {
                        val deviceWidth = Resources.getSystem().displayMetrics.widthPixels

                        if (abs(distanceY) > abs(distanceX)) {
                            brightnessVolumeContainer.visibility = View.VISIBLE
                            shouldShowController = false

                            if (motionEvent.x < deviceWidth / 2) {
                                volumeIcon.visibility = View.GONE
                                brightnessIcon.visibility = View.VISIBLE
                                val increase = distanceY > 0
                                val newValue = if (increase) brightness + 1 else brightness - 1
                                if (newValue in 0..showMaxBrightness) {
                                    brightness = newValue
                                }
                                brightnessVolumeTv.text = (brightness.toString())
                                setScreenBrightness(brightness)
                            } else {
                                if (audioManager != null) {
                                    volumeIcon.visibility = View.VISIBLE
                                    brightnessIcon.visibility = View.GONE
                                    val increase = distanceY > 0
                                    val newValue = if (increase) volume + 1 else volume - 1
                                    if (newValue in 0..showMaxVolume) {
                                        volume = newValue
                                    }
                                    brightnessVolumeTv.text = volume.toString()
                                    setVolume(volume)
                                }
                            }
                        }
                        return true
                    }catch (e : Exception){
                        Timber.d(e.message)
                    }

                    return false
                }
            })

        } catch (e: Exception) {
            Timber.tag(TAG).d(e.message)
        }
    }

    /**
     * setVolume
     * @param volume
     */
    private fun setVolume(volume: Int) = try {
        val maxVolume = audioManager!!.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
        val d = maxVolume * 1.0f / showMaxVolume
        var newVolume = (d * volume).toInt()
        if (newVolume > maxVolume) {
            newVolume = maxVolume
        }
        if (volume == showMaxVolume && newVolume < maxVolume) {
            newVolume = maxVolume
        }
        audioManager!!.setStreamVolume(AudioManager.STREAM_MUSIC, newVolume, 0)

    } catch (e: Exception) {
        Timber.tag(TAG).d(e.message)
    }


    /**
     * setScreenBrightness
     * @param brightness
     */
    private fun setScreenBrightness(brightness: Int) = try {
        val d = 1.0f / showMaxBrightness
        val lp = window.attributes.apply {
            screenBrightness = d * brightness
        }
        window.attributes = lp

    } catch (e: Exception) {
        Timber.tag(TAG).d(e.message)
    }


    @androidx.annotation.OptIn(UnstableApi::class)
    private fun getHlsMediaSource(url: String): MediaSource {
        return HlsMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(url!!))
    }

    @androidx.annotation.OptIn(UnstableApi::class)
    private fun getProgressiveMediaSource(url: String): MediaSource {
        return ProgressiveMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(Uri.parse(url)))
    }

    @androidx.annotation.OptIn(UnstableApi::class)
    private fun getDashMediaSource(url: String): MediaSource {
        return DashMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(Uri.parse(url)))
    }

    private val onBackCall = object : OnBackPressedCallback(true) {
        override fun handleOnBackPressed() {
            exoPlayer!!.apply {
                stop()
                release()
            }
            finish()
        }
    }

    override fun onPause() {
        super.onPause()
        pause()
    }

    override fun onResume() {
        super.onResume()
        if (brightness > 0)
            setScreenBrightness(brightness)

        setVolume(volume)
        play()
    }

    override fun onDestroy() {
        super.onDestroy()
        releasePlayer()
        window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        handler.removeCallbacksAndMessages(null)
    }


    private fun releasePlayer() = try {
        exoPlayer?.let { player ->
            player.removeListener(playerListener)
            player.playWhenReady = false
            player.stop()
            player.release()
        }

        exoPlayer = null

    } catch (e: Exception) {

        Timber.tag(TAG).d(e.message)
    }

    private fun pause() {
        exoPlayer?.playWhenReady = false
    }

    private fun play() {
        exoPlayer?.playWhenReady = true
    }


    private val playerListener = object : Player.Listener {
        override fun onPlaybackStateChanged(playbackState: Int) {
            super.onPlaybackStateChanged(playbackState)

            Timber.tag(TAG).d("onPlaybackStateChanged $playbackState")

            viewBinding.apply {
                when (playbackState) {
                    STATE_IDLE -> {}

                    STATE_READY -> {
                        CoroutineScope(Dispatchers.Main).launch {
                            if(selectedPosition != -1) {
                                val smoothScroller: RecyclerView.SmoothScroller by lazy {
                                    object : LinearSmoothScroller(this@VideoPlayerActivity) {
                                        override fun getVerticalSnapPreference() = SNAP_TO_START
                                    }
                                }
                                smoothScroller.targetPosition = selectedPosition
                                recyclerView.layoutManager?.startSmoothScroll(smoothScroller)
                            }
                        }

                        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

                        playerView.setBackgroundColor(ContextCompat.getColor(this@VideoPlayerActivity,  R.color.tory_black))
                        bufferProgressbar.visibility = View.GONE
                        video.visibility = View.VISIBLE

                        playerError01.visibility = View.GONE
                        playerError02.visibility = View.GONE

                        playerView.player = exoPlayer

                        play()

                        updateSeek()
                    }

                    STATE_BUFFERING -> {
                        bufferProgressbar.visibility = View.VISIBLE
                    }

                    STATE_ENDED -> {
                        try {
                            handler.removeCallbacksAndMessages(null)
                            playEndUpdate()
                            CoroutineScope(Dispatchers.Main).launch {
                                delay(1000)
                                val currentOrientation = resources.configuration.orientation
                                if (currentOrientation == ORIENTATION_LANDSCAPE) {
                                    requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
                                    isShowViewController(true)
                                    setNormalScreen()
                                }

                                window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                            }
                        } catch (e: Exception) {
                            Timber.tag(TAG).d(e.message)
                        }
                    }
                }
            }
        }

        override fun onIsPlayingChanged(isPlaying: Boolean) {
            super.onIsPlayingChanged(isPlaying)
            if (isPlaying) {
                Timber.tag(TAG).d("currentPosition ${exoPlayer?.currentPosition}")
            }
        }

        override fun onPlayerError(error: PlaybackException) {
            viewBinding.apply {
                video.visibility = View.VISIBLE
                bufferProgressbar.visibility = View.GONE

                exoPlayer?.apply {
                    stop()
                    release()
                }
                playerError01.visibility = View.VISIBLE
                playerError02.visibility = View.VISIBLE
            }
        }
    }

    private fun setVolumeVariable() {
        volume = (audioManager!!.getStreamVolume(AudioManager.STREAM_MUSIC) * 1.0f / audioManager!!.getStreamMaxVolume(AudioManager.STREAM_MUSIC) * showMaxVolume).toInt()
        if (volume > showMaxVolume) {
            volume = showMaxVolume
        }
    }

    private fun getCurrentScreenBrightness(): Float {
        var currentBrightness = 0
        try {
            currentBrightness = Settings.System.getInt(
                contentResolver,
                Settings.System.SCREEN_BRIGHTNESS
            )
        } catch (e: SettingNotFoundException) {
            e.printStackTrace()
        }

        val maxBrightness = 255
        var brightnessValue = currentBrightness.toFloat() / maxBrightness

        brightnessValue = 0f.coerceAtLeast(1.0f.coerceAtMost(brightnessValue))
        return brightnessValue
    }



    private val handler = Handler(Looper.getMainLooper())
    private fun updateSeek() = try {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            handler.postDelayed(object : Runnable {
                override fun run() {
                    try {
                        val param = BaseParam(PlayVideoUpdatePositionParam(
                                applyId = playerVideoInfo!!.applyId,
                                lecId   = playerVideoInfo!!.lecId,
                                wrOrder = playerVideoInfo!!.wrOrder,
                                lmsTimeId =  playerVideoInfo!!.lmsTimeId,
                                isStudied = false,
                                contentTime = exoPlayer?.duration!!.toFloat() / 1000,
                                curpos = exoPlayer?.currentPosition!!.toFloat() / 1000
                            )).parameter

                        if(!playerVideoInfo!!.isStudied && selectedPosition != -1) {

                            val progressValue = ((exoPlayer?.currentPosition!!.toDouble() / 1000 ) / (exoPlayer?.duration!!.toDouble() / 1000) * 100).toInt()

                            Timber.tag(TAG).d("updateSeek $param -  progress - $progressValue")

                            mVideoInfoArray[selectedPosition].process = progressValue
                            videoInfoAdapter.notifyItemChanged(selectedPosition)
                        }

                        viewModel.apply {
                            videoUpdatePlayingPosition(param).subscribeBy(onNext = {
                                try {
                                    Timber.tag(TAG).d("${it.result}")
                                    if(!it.isResultOK) {
                                        CommonAlertDialog.Builder(this@VideoPlayerActivity)
                                            .setMessage(it.resultMessage.toString())
                                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                                            .show()
                                    }
                                }catch (e : Exception){
                                    Timber.d(e.message)
                                }

                            })
                        }

                    }catch (e : Exception){
                        handler.removeCallbacksAndMessages(null)
                        Timber.tag(TAG).d(e.message)
                    }

                    handler.postDelayed(this, 10000)
                }
            }, 0, 10000)

        }else { }
    }catch (e : Exception){
        handler.removeCallbacksAndMessages(null)
        Timber.tag(TAG).d(e.message)
    }

    private fun playEndUpdate() = try {

        val param = BaseParam(PlayVideoUpdateEndParam(
                                applyId = playerVideoInfo!!.applyId,
                                lecId   = playerVideoInfo!!.lecId,
                                wrOrder = playerVideoInfo!!.wrOrder,
                                lmsTimeId =  playerVideoInfo!!.lmsTimeId,
                                isStudied = false,
                                endCk   = "y",
                                time    =  exoPlayer?.currentPosition!!.toFloat() / 1000,
                                contentTime = exoPlayer?.duration!!.toFloat() / 1000
                            )).parameter

        if(!playerVideoInfo!!.isStudied && selectedPosition != -1) {
            val progressValue = ((exoPlayer?.currentPosition!!.toDouble() / 1000 ) / (exoPlayer?.duration!!.toDouble() / 1000) * 100).toInt()
            Timber.tag(TAG).d("playEndUpdate $param -  progress - $progressValue")

            mVideoInfoArray[selectedPosition].process = progressValue
            videoInfoAdapter.notifyItemChanged(selectedPosition)
        }


        viewModel.videoUpdateEndPosition(param).subscribeBy(onNext = {
            try {
                Timber.tag(TAG).d("${it.result}")

                if(!it.isResultOK) {
                    CommonAlertDialog.Builder(this)
                        .setMessage(it.resultMessage.toString())
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }else {

                }
            }catch (e : Exception){
                Timber.d(e.message)
            }
        })

    }catch (e : Exception){
        handler.removeCallbacksAndMessages(null)
        Timber.tag(TAG).d(e.message)
    }

}