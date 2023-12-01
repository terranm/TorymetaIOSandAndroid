package com.tnmeta.torymeta.campus

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.view.View
import androidx.core.content.ContextCompat
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.database.step.PedometerDatabase
import com.tnmeta.torymeta.database.step.StepsRepository
import com.tnmeta.torymeta.databinding.ActivityCampusStepBinding
import com.tnmeta.torymeta.dialog.CommonDialogInterface
import com.tnmeta.torymeta.dialog.MileagePointAlertDialog
import com.tnmeta.torymeta.dialog.TutorialDialogInfoFragment
import com.tnmeta.torymeta.model.event.EventType
import com.tnmeta.torymeta.model.event.LocationInfoEventBus
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.param.StepEventParam
import com.tnmeta.torymeta.model.result.WalkEventResult
import com.tnmeta.torymeta.utils.FormatUtil
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode
import timber.log.Timber
import java.text.DecimalFormat



class PedometerActivity : BaseActivity(TransitionModeType.SLIDE_UP_IN), View.OnClickListener, SensorEventListener {

    companion object {
        private val TAG  = PedometerActivity::class.java.simpleName
    }

    private lateinit var stepsRepository: StepsRepository

    private enum class StepType {
        CAMPUS_INNER,
        CMMPUS_SUBURBS
    }

    private enum class RewardPointType (val origin: Int){
        REWARD_1000_STEPS(1000),
        REWARD_3000_STEPS(3000),
        REWARD_5000_STEPS(5000),
        REWARD_10000_STEPS(10000)
    }

    private val stepValueArray = arrayOf (
        "STEP_1_CONDITION",
        "STEP_2_CONDITION",
        "STEP_3_CONDITION",
        "STEP_4_CONDITION"
    )


    private val viewBinding by viewBinding(ActivityCampusStepBinding::inflate)
    private lateinit var walkEventResult : WalkEventResult
    private var mSelectTab = StepType.CAMPUS_INNER
    private var isLocationInfo = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)
            setTopBarTitle(viewBinding.topBar, R.string.pedometer_step_title)
            setTopBarBackButtonEnabled(viewBinding.topBar, false)

            /*
            closeBtn.setOnClickListener(this@PedometerActivity)
            campusInner.setOnClickListener(this@PedometerActivity)
            campusOut.setOnClickListener(this@PedometerActivity)
            imgPedInfo.setOnClickListener(this@PedometerActivity)
            */

            arrayOf(closeBtn, campusInner, campusOut, imgPedInfo).forEach {
                it.setOnClickListener(this@PedometerActivity)
            }


            EventBus.getDefault().register(this@PedometerActivity)
            CoroutineScope(Dispatchers.Main).launch {
                getWalkEvent()
            }

            if(!::stepsRepository.isInitialized) {
                stepsRepository = StepsRepository(PedometerDatabase.getInstance(this@PedometerActivity))
            }

            stepCount.text = FormatUtil.numberFormat
                                        .format(stepsRepository
                                        .getUpdateStepInfo(mSelectTab.ordinal))

            if(!repository.getStepTutorial()) {
                TutorialDialogInfoFragment.TutorialInfoDialogBuilder(supportFragmentManager).apply {
                    setClickListener(object : CommonDialogInterface.OnClickListener {
                        override fun onClick(i: Int) {
                            when (i) {
                                R.id.txtClose -> {
                                    repository.setStepTutorial(true)
                                }
                            }
                        }
                    })
                }.show()
            }

            if(Constants.is_FirebaseAnalytics) {
                firebaseAnalyticsMember(FirebaseParam.mobile_m2e)
            }
        }
    }

    override fun onResume() {
        super.onResume()
        try {
            val sm = getSystemService(Context.SENSOR_SERVICE) as SensorManager
            val sensor = sm.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)
            if (sensor != null) {
                sm.registerListener(this, sensor, SensorManager.SENSOR_DELAY_UI, 0)
            }

            stepsDistanceChanged()

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onPause() {
        super.onPause()
        try {
            val sm = getSystemService(Context.SENSOR_SERVICE) as SensorManager
            sm.unregisterListener(this)
        } catch (e: Exception) {
            Timber.d(e.message)
        }
    }



    override fun onDestroy() {
        super.onDestroy()
        EventBus.getDefault().unregister(this)
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.closeBtn -> finish()

            R.id.campus_inner -> {
                viewBinding.apply {
                    mSelectTab = StepType.CAMPUS_INNER
                    setStepInfo(StepType.CAMPUS_INNER)
                    campusInner.setBackgroundResource(R.drawable.common_corner_round_purple_01)
                    campusInnerTitle.setTextColor(ContextCompat.getColor(this@PedometerActivity,  R.color.tory_white))
                    campusOut.setBackgroundResource(R.drawable.common_corner_round_stroke_purple_02)
                    campusOutTitle.setTextColor(ContextCompat.getColor(this@PedometerActivity,  R.color.tory_purple))
                }
            }

            R.id.campus_out -> {
                viewBinding.apply {
                    mSelectTab = StepType.CMMPUS_SUBURBS
                    setStepInfo(StepType.CMMPUS_SUBURBS)
                    campusInner.setBackgroundResource(R.drawable.common_corner_round_stroke_purple_02)
                    campusInnerTitle.setTextColor(ContextCompat.getColor(this@PedometerActivity,  R.color.tory_purple))
                    campusOut.setBackgroundResource(R.drawable.common_corner_round_purple_01)
                    campusOutTitle.setTextColor(ContextCompat.getColor(this@PedometerActivity,  R.color.tory_white))
                }
            }

            R.id.step_reward_01_layout -> {
                setStepsReward(RewardPointType.REWARD_1000_STEPS)
            }

            R.id.step_reward_02_layout -> {
                setStepsReward(RewardPointType.REWARD_3000_STEPS)
            }

            R.id.step_reward_03_layout -> {
                setStepsReward(RewardPointType.REWARD_5000_STEPS)
            }

            R.id.step_reward_04_layout -> {
                setStepsReward(RewardPointType.REWARD_10000_STEPS)
            }

            R.id.imgPedInfo -> {
                TutorialDialogInfoFragment.TutorialInfoDialogBuilder(supportFragmentManager).apply {
                    setClickListener(object : CommonDialogInterface.OnClickListener {
                        override fun onClick(i: Int) {
                            when (i) {
                                R.id.txtClose -> {
                                }
                            }
                        }
                    })
                }.show()
            }

        }
    }

    private fun getWalkEvent() = try {
        repository.getEventWalk()
            .subscribeBy(onNext = {
                walkEventResult = it
                CoroutineScope(Dispatchers.Main).launch {
                    setStepInfo(mSelectTab)
                }
            })

    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun setStepInfo(index : StepType) = try {
        viewBinding.apply {
            val ration = if (index == StepType.CAMPUS_INNER) walkEventResult.insideRatio
                            else walkEventResult.outsideRatio

            val stepMainImage = if(index == StepType.CAMPUS_INNER) R.drawable.step_main_inner_image
                            else R.drawable.step_main_out_image
            mainStepImage.setBackgroundResource(stepMainImage)

            val textColor = if(index == StepType.CAMPUS_INNER) ContextCompat.getColor(this@PedometerActivity,  R.color.tory_purple)
                            else ContextCompat.getColor(this@PedometerActivity,  R.color.color_fdcb6e)
            stepCount.setTextColor(textColor)
            val stepBackResouce = if(index == StepType.CAMPUS_INNER) R.drawable.common_corner_circle_stroke_purple
                                else R.drawable.common_corner_round_yellow

            val stepImage = if(index == StepType.CAMPUS_INNER) R.drawable.step_inner_img
                                else R.drawable.step_out_img

            stepPerComment.text = if( index == StepType.CAMPUS_INNER) getString(R.string.steps_per_total, "${DecimalFormat("#,###").format(walkEventResult.maxInsideStep)}")
                                    else getString(R.string.steps_per_total, "${DecimalFormat("#,###").format(walkEventResult.maxOutsideStep)}")

            walkEventResult.stepCondition.forEach {
                when(it.key) {
                    stepValueArray[0] -> {
                        imgStep01.apply {
                            setBackgroundResource(stepBackResouce)
                            setImageResource(stepImage)
                        }

                        txtStep01.text = getString(R.string.steps_per_max, "${DecimalFormat("#,###").format(it.value)}")
                        stepReward01.text = getString(R.string.steps_per_reward, "${DecimalFormat("#,###").format(it.value * ration)}")
                    }

                    stepValueArray[1] -> {
                        imgStep02.apply {
                            setBackgroundResource(stepBackResouce)
                            setImageResource(stepImage)
                        }
                        txtStep02.text = getString(R.string.steps_per_max, "${DecimalFormat("#,###").format(it.value)}")
                        stepReward02.text = getString(R.string.steps_per_reward, "${DecimalFormat("#,###").format(it.value * ration)}")
                    }

                    stepValueArray[2] -> {
                        imgStep03.apply {
                            setBackgroundResource(stepBackResouce)
                            setImageResource(stepImage)
                        }
                        txtStep03.text = getString(R.string.steps_per_max, "${DecimalFormat("#,###").format(it.value)}")
                        stepReward03.text = getString(R.string.steps_per_reward, "${DecimalFormat("#,###").format(it.value * ration)}")
                    }

                    stepValueArray[3] -> {
                        imgStep04.apply {
                            setBackgroundResource(stepBackResouce)
                            setImageResource(stepImage)
                        }
                        txtStep04.text = getString(R.string.steps_per_max, "${DecimalFormat("#,###").format(it.value)}")
                        stepReward04.text = getString(R.string.steps_per_reward, "${DecimalFormat("#,###").format(it.value * ration)}")
                    }
                }
            }

            stepCount.text = FormatUtil.numberFormat
                                        .format(stepsRepository.getUpdateStepInfo(mSelectTab.ordinal))

            isCheckStep()
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }


    @Subscribe(threadMode = ThreadMode.MAIN)
    fun eventUpdate(eventBus: LocationInfoEventBus) {
        try {
            if(eventBus.type == EventType.LOCATION_INFO) {
                isLocationInfo = eventBus.isLocation
                Timber.tag(TAG).d(" eventUpdate $isLocationInfo")
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    private fun stepsDistanceChanged() {
        val stepsToday = stepsRepository.getStepsToday(mSelectTab.ordinal)
        updatePie(stepsToday)
    }

    private fun updatePie(stepsToday: Long) = viewBinding.apply{
        try {
            Timber.d("UI - update stepsToday: $stepsToday")

            val numberFormat = FormatUtil.numberFormat
            stepCount.text = numberFormat.format(stepsToday)

            isCheckStep()

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {

    }

    override fun onSensorChanged(event: SensorEvent) {
        viewBinding.apply {
            Timber.d("UI - sensorChanged | since boot: ${event.values[0]}")
            if (event.values[0] > Int.MAX_VALUE || event.values[0] == 0f) return

            val steps = event.values[0].toLong()
            val stepsToday = stepsRepository.updateStepsSinceBoot(steps, isLocationInfo, mSelectTab.ordinal)

            updatePie(stepsToday)
        }
    }


    private fun setStepsReward(rewardIndex : RewardPointType) = try {
        val step = stepsRepository.getStepsToday(mSelectTab.ordinal)

        if(step < rewardIndex.origin) {
            MileagePointAlertDialog.Builder(ToryApplication.activity!!)
                .setCancelable(false)
                .setTitleView(false)
                .setMessage(R.string.steps_not_fill_message)
                .setPositiveButton {}
                .show()
        }else {

            val type = stepValueArray[rewardIndex.ordinal]

            setWalkEvent(rewardIndex,
                            type,
                            if (mSelectTab == StepType.CAMPUS_INNER) "Y"
                            else "N")
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun isCheckStep() = viewBinding.apply {
        try {
            val step = stepsRepository.getStepsToday(mSelectTab.ordinal)
            val selectArray = if(mSelectTab == StepType.CAMPUS_INNER) walkEventResult.inStepYnArr
                                else walkEventResult.outStepYnArr

            if(selectArray[RewardPointType.REWARD_1000_STEPS.ordinal] == "Y") {
                val rewardValue = if(mSelectTab == StepType.CAMPUS_INNER ) {
                                        RewardPointType.REWARD_1000_STEPS.origin * walkEventResult.insideRatio
                                  }else {
                                        RewardPointType.REWARD_1000_STEPS.origin * walkEventResult.outsideRatio
                                  }
                stepReward01.text = getString(R.string.steps_receive_reward, "${DecimalFormat("#,###").format(rewardValue)}")
                stepReward01Layout.apply {
                    setBackgroundResource(R.drawable.step_reward_gray)
                    isEnabled = false
                }

            }else {
                if(step < RewardPointType.REWARD_1000_STEPS.origin) {
                    stepReward01Layout.apply {
                        setBackgroundResource(R.drawable.step_disable_button)
                        isEnabled = false
                    }
                }else {
                    stepReward01Layout.apply {
                        setBackgroundResource(R.drawable.step_select_purple)
                        isEnabled = true
                    }
                }
            }

            if(selectArray[RewardPointType.REWARD_3000_STEPS.ordinal] == "Y") {
                val rewardValue = if(mSelectTab == StepType.CAMPUS_INNER ) {
                                    RewardPointType.REWARD_3000_STEPS.origin * walkEventResult.insideRatio
                                 }else {
                                    RewardPointType.REWARD_3000_STEPS.origin * walkEventResult.outsideRatio
                                 }

                stepReward02.text = getString(R.string.steps_receive_reward, "${DecimalFormat("#,###").format(rewardValue)}")
                stepReward02Layout.apply {
                    setBackgroundResource(R.drawable.step_reward_gray)
                    isEnabled = false
                }
            }else {
                if(step < RewardPointType.REWARD_3000_STEPS.origin) {
                    stepReward02Layout.apply {
                        setBackgroundResource(R.drawable.step_disable_button)
                        isEnabled = false
                    }
                }else {
                    stepReward02Layout.apply {
                        setBackgroundResource(R.drawable.step_select_purple)
                        isEnabled = true
                    }
                }
            }

            if(selectArray[RewardPointType.REWARD_5000_STEPS.ordinal] == "Y") {
                val rewardValue = if(mSelectTab == StepType.CAMPUS_INNER ) {
                                    RewardPointType.REWARD_5000_STEPS.origin * walkEventResult.insideRatio
                                }else {
                                    RewardPointType.REWARD_5000_STEPS.origin * walkEventResult.outsideRatio
                                }

                stepReward03.text = getString(R.string.steps_receive_reward, "${DecimalFormat("#,###").format(rewardValue)}")
                stepReward03Layout.apply {
                    setBackgroundResource(R.drawable.step_reward_gray)
                    isEnabled = false
                }
            }else {
                if(step < RewardPointType.REWARD_5000_STEPS.origin) {
                    stepReward03Layout.apply {
                        setBackgroundResource(R.drawable.step_disable_button)
                        isEnabled = false
                    }
                }else {
                    stepReward03Layout.apply {
                        setBackgroundResource(R.drawable.step_select_purple)
                        isEnabled = true
                    }
                }
            }

            if(selectArray[RewardPointType.REWARD_10000_STEPS.ordinal] == "Y") {
                val rewardValue = if(mSelectTab == StepType.CAMPUS_INNER ) {
                                    RewardPointType.REWARD_10000_STEPS.origin * walkEventResult.insideRatio
                                }else {
                                    RewardPointType.REWARD_10000_STEPS.origin * walkEventResult.outsideRatio
                                }
                stepReward04.text = getString(R.string.steps_receive_reward, "${DecimalFormat("#,###").format(rewardValue)}")
                stepReward04Layout.apply {
                    setBackgroundResource(R.drawable.step_reward_gray)
                    isEnabled = false
                }
            }else {
                if(step < RewardPointType.REWARD_10000_STEPS.origin) {
                    stepReward04Layout.apply {
                        setBackgroundResource(R.drawable.step_disable_button)
                        isEnabled = false
                    }
                }else {
                    stepReward04Layout.apply {
                        setBackgroundResource(R.drawable.step_select_purple)
                        isEnabled = true
                    }
                }
            }

        } catch (e: Exception) {
            Timber.d(e.message)
        }
    }


    private fun setWalkEvent(rewardIndex : RewardPointType, type : String, inRangeYn : String) = try {
        val param = BaseParam(StepEventParam(type, inRangeYn)).parameter

        Timber.tag(TAG).d("setWalkEvent $param")

        repository.setEventWalk(param).subscribeBy(onNext = { data ->

            if(data.isSucceed && data.processYn == "Y") {

                val rewardValue = if(inRangeYn == "Y") {
                                    rewardIndex.origin * walkEventResult.insideRatio
                                }else {
                                    rewardIndex.origin * walkEventResult.outsideRatio
                                }

                val message = resources.getString(R.string.steps_step_reward_message, "${DecimalFormat("#,###").format(rewardValue)}")

                MileagePointAlertDialog.Builder(this)
                    .setCancelable(false)
                    .setImage(if(inRangeYn == "Y")  1 else  0)
                    .setMessage(message)
                    .setPositiveButton {

                        val index = rewardIndex.ordinal
                        Timber.tag(TAG).d("setWalkEvent $index")

                        if(mSelectTab == StepType.CAMPUS_INNER) {
                            walkEventResult.inStepYnArr[index] = "Y"
                        }else {
                            walkEventResult.outStepYnArr[index] = "Y"
                        }

                        isCheckStep()

                    }.show()
            }

        }, onError = {})

    }catch (e : Exception){
        Timber.d(e.message)
    }





}