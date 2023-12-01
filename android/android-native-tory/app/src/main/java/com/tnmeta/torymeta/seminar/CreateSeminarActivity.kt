package com.tnmeta.torymeta.seminar

import android.app.AlertDialog
import android.app.DatePickerDialog
import android.app.TimePickerDialog
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.text.format.DateFormat
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.PagerSnapHelper
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.RoomSize
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityCreateSeminarBinding
import com.tnmeta.torymeta.main.model.RoomInfoDto
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.seminar.adapter.SeminarRoomViewAdapter
import com.tnmeta.torymeta.seminar.dialog.SeminarAlertDialog
import com.tnmeta.torymeta.seminar.dialog.SeminarPasswordBottomDialogFragment
import com.tnmeta.torymeta.seminar.model.SeminarParam
import com.tnmeta.torymeta.seminar.viewmodel.SeminarViewModel
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.DateFormatter
import com.tomergoldst.tooltips.ToolTip
import com.tomergoldst.tooltips.ToolTip.ALIGN_LEFT
import com.tomergoldst.tooltips.ToolTipsManager
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date


class CreateSeminarActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH),
                                View.OnClickListener {
    companion object {
        val TAG : String = CreateSeminarActivity::class.java.simpleName

        fun createIntent(context: Context): Intent {
            return Intent(context, CreateSeminarActivity::class.java)
        }
    }

    private val viewBinding by viewBinding(ActivityCreateSeminarBinding::inflate)
    private lateinit var viewModel: SeminarViewModel
    private val mSeminarRoomArrayList = ArrayList<RoomInfoDto>()
    private lateinit var mRoomAdapter : SeminarRoomViewAdapter

    private var password = ""
    private var startTimeValue = ""
    private var endTimeValue  = ""
    private var selectButtonIndex = 0
    private lateinit var selectRoomInfoDto    : RoomInfoDto
    private var createRoomCount = 0
    private var startHour = 0
    private var startMinute = 0

    private var selectedPosition = -1

    var mToolTipsManager: ToolTipsManager? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)
            viewModel = ViewModelProvider(this@CreateSeminarActivity)[SeminarViewModel::class.java]
            init()
            setButton(selectButtonIndex)

            mRoomAdapter = SeminarRoomViewAdapter(
                mSeminarRoomArrayList,
                onItemClick = { _, position  ->
                    selectedPosition = position
                    isEnableCheck(true)
                },
                selectedPosition
            )
            roomListView.apply {
                layoutManager = LinearLayoutManager(this@CreateSeminarActivity, RecyclerView.HORIZONTAL, false)
                adapter = mRoomAdapter
            }

            val pagerSnapHelper = PagerSnapHelper()
            pagerSnapHelper.attachToRecyclerView(roomListView)
            indicator.attachToRecyclerView(roomListView, pagerSnapHelper)
            mRoomAdapter.registerAdapterDataObserver(indicator.adapterDataObserver);

            viewModel.apply {
                seminarRoomList.observe(this@CreateSeminarActivity) { list ->
                    mSeminarRoomArrayList.apply {
                        clear()
                        addAll(list)
                    }

                    seminarRoomCount.text = getString(R.string.room_count_text, "${0}")
                    seminarCapacityCount.text = getString(R.string.people_total_count_text, "${0}")
                    seminarTotalCount.text = getString(R.string.people_total_count_text, "${0}")

                    selectedPosition = -1
                    mRoomAdapter.apply {
                        setSelectPosition(selectedPosition)
                        notifyDataSetChanged()
                    }
                }
            }

            openSwitch.setOnCheckedChangeListener { _, isChecked ->
                if(isChecked) {
                    SeminarPasswordBottomDialogFragment(this@CreateSeminarActivity).apply {
                        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                        onClickListener = { data ->
                            if(data.toString().isEmpty()) {
                                openSwitch.isChecked = false
                            }else {
                                Timber.d("" + data.toString())
                                password = data.toString()
                            }
                        }
                        show(this@CreateSeminarActivity.supportFragmentManager, Constants.SeminarPasswordBottomDialogFragmentTag)
                    }
                }
            }

            arrayOf(totalRoom, smallRoom, smallCount, middleRoom, middleCount, largeRoom, largeRoomCount,
                    startDateLayout, startTimeLayout, endTimeLayout, seminarCreate, seminarPlus, seminarMinus).forEach {
                it.setOnClickListener(this@CreateSeminarActivity)
            }

            editSeminarTitle.run{
                addTextChangedListener(object : TextWatcher {
                    override fun beforeTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {}
                    override fun onTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {
                        if(editSeminarTitle.text.toString().isNotEmpty()) {
                            isEnableCheck()
                        }
                    }
                    override fun afterTextChanged(editable: Editable?) {}
                })
            }
            seminarRoomCount.text = getString(R.string.room_count_text, "$createRoomCount")
            seminarCapacityCount.text = getString(R.string.people_total_count_text, "${0}")
            seminarTotalCount.text = getString(R.string.people_total_count_text, "${0}")

            seminarUrl.onFocusChangeListener = View.OnFocusChangeListener { _, hssFocus ->
                if(hssFocus) {
                    mToolTipsManager!!.dismissAll()
                }
            }

            mToolTipsManager = ToolTipsManager()
            val builder = ToolTip.Builder(this@CreateSeminarActivity, seminarUrl, tooltip, resources.getString(R.string.seminar_url_tooltip), ToolTip.POSITION_BELOW).apply {
                setBackgroundColor(ContextCompat.getColor(this@CreateSeminarActivity, R.color.tory_gray_01))
                setAlign(ALIGN_LEFT)
                setOffsetY(-10)
            }
            mToolTipsManager!!.show(builder.build())
        }
    }



    override fun onClick(view: View) {
        when(view.id) {
            R.id.close -> {
                SeminarAlertDialog.Builder(this)
                    .setCancelable(false)
                    .setTitle(R.string.seminar_create_cancel)
                    .setNegativeButton(R.string.seminar_apply_cancel) {}
                    .setPositiveButton(R.string.seminar_cancel_yes) {
                        finish()
                    }
                    .show()
            }
            R.id.total_room -> {
                selectButtonIndex = 0
                setButton(selectButtonIndex)
                viewModel.apply {
                    getRoomInfo("")
                }
            }
            R.id.small_room,
            R.id.small_count -> {
                selectButtonIndex = 1
                setButton(selectButtonIndex)
                viewModel.apply {
                    getRoomInfo(RoomSize.SMALL)
                }
            }
            R.id.middle_room,
            R.id.middle_count-> {
                selectButtonIndex = 2
                setButton(selectButtonIndex)
                viewModel.apply {
                    getRoomInfo(RoomSize.MEDIUM)
                }
            }
            R.id.large_room,
            R.id.large_room_count -> {
                setButton(3)
                viewModel.apply {
                    getRoomInfo(RoomSize.LARGE)
                }
            }

            R.id.start_date_layout -> {
                val cal = Calendar.getInstance()
                val data = DatePickerDialog.OnDateSetListener { _, year, month, day ->
                    val calendar = Calendar.getInstance()
                    val nowYear = calendar[Calendar.YEAR]
                    val nowMonth = calendar[Calendar.MONTH]
                    val nowDay = calendar[Calendar.DAY_OF_MONTH]

                    if(year <= nowYear && month <= nowMonth && day < nowDay) {
                        CommonAlertDialog.Builder(this)
                            .setCancelable(false)
                            .setMessage(R.string.select_date_error)
                            .setPositiveButton { }
                            .show()
                        return@OnDateSetListener
                    }
                    viewBinding.apply {
                        startDate.text = String.format("%d.%d.%d", year, month, day)
                        endDate.text = String.format("%d.%d.%d", year, month, day)
                    }
                }
                DatePickerDialog(this, R.style.Date_Dialog_Theme,  data, cal.get(Calendar.YEAR),
                                    cal.get(Calendar.MONTH),
                                    cal.get(Calendar.DAY_OF_MONTH)).show()
            }

            R.id.start_time_layout -> {
                val calendar = Calendar.getInstance()
                val hour = calendar.get(Calendar.HOUR_OF_DAY)
                val minute = calendar.get(Calendar.MINUTE)
                val timeSetListener = TimePickerDialog.OnTimeSetListener { _, hour, minute ->
                    calendar.set(Calendar.HOUR_OF_DAY, hour)
                    calendar.set(Calendar.MINUTE, minute)

                    val calendar1 = Calendar.getInstance()
                    val nowHour = calendar1[Calendar.HOUR_OF_DAY]
                    val nowMinute = calendar1[Calendar.MINUTE]

                    if(hour <= nowHour && minute < nowMinute) {
                        CommonAlertDialog.Builder(this)
                            .setCancelable(false)
                            .setMessage(R.string.select_time_error)
                            .setPositiveButton { }
                            .show()
                        return@OnTimeSetListener
                    }

                    startHour = hour
                    startMinute = minute
                    viewBinding.apply {
                        startTime.text = SimpleDateFormat("a hh:mm").format(calendar.time)
                        endTime.text = SimpleDateFormat("a hh:mm").format(calendar.time)

                        startTimeValue = SimpleDateFormat("HH:mm").format(calendar.time)
                        endTimeValue   = SimpleDateFormat("HH:mm").format(calendar.time)
                    }
                }
                val timePickerDialog = TimePickerDialog(this, AlertDialog.THEME_HOLO_LIGHT, timeSetListener, hour, minute,
                    DateFormat.is24HourFormat(this))
                timePickerDialog.show()
            }

            R.id.end_time_layout -> {
                val calendar = Calendar.getInstance()
                val hour = calendar.get(Calendar.HOUR_OF_DAY)
                val minute = calendar.get(Calendar.MINUTE)
                val timeSetListener = TimePickerDialog.OnTimeSetListener { _, hour, minute ->
                    calendar.set(Calendar.HOUR_OF_DAY, hour)
                    calendar.set(Calendar.MINUTE, minute)

                    val calendar1 = Calendar.getInstance()
                    val nowHour = calendar1[Calendar.HOUR_OF_DAY]
                    val nowMinute = calendar1[Calendar.MINUTE]

                    if(hour <= nowHour && minute < nowMinute) {
                        CommonAlertDialog.Builder(this)
                            .setCancelable(false)
                            .setMessage(R.string.select_time_error)
                            .setPositiveButton { }
                            .show()
                        return@OnTimeSetListener
                    }

                    if(startHour <= hour && startMinute < minute) {
                        CommonAlertDialog.Builder(this)
                            .setCancelable(false)
                            .setMessage(R.string.select_end_time_error)
                            .setPositiveButton { }
                            .show()
                        return@OnTimeSetListener
                    }

                    viewBinding.apply {
                        endTime.text = SimpleDateFormat("a hh:mm").format(calendar.time)
                        endTimeValue   = SimpleDateFormat("HH:mm").format(calendar.time)
                    }
                }
                val timePickerDialog = TimePickerDialog(this, AlertDialog.THEME_HOLO_LIGHT, timeSetListener, hour, minute,
                    DateFormat.is24HourFormat(this))
                timePickerDialog.show()
            }

            R.id.seminar_create -> {
                try {
                    viewBinding.apply {
                        val roomInfo = mSeminarRoomArrayList[selectedPosition]
                        val url = seminarUrl.text.toString()

                        val secretYn = if(openSwitch.isChecked) "Y" else "N"

                        val start = startDate.text.toString() + " " + startTimeValue + ":00"
                        var time  = DateFormatter.instance.fullDotted().parse(start)
                        val startValue = DateFormatter.instance.dateBarTimeFormatter().format(time)

                        val end = endDate.text.toString() + " " + endTimeValue + ":00"
                        time  = DateFormatter.instance.fullDotted().parse(end)
                        val endValue = DateFormatter.instance.dateBarTimeFormatter().format(time)

                        val seminar = SeminarParam(
                                            roomId = roomInfo.roomId,
                                            title = editSeminarTitle.text.toString().trim(),
                                            description = editSeminarExplanation.text.toString().trim(),
                                            teacherDescription = editSeminarTeacher.text.toString().trim(),
                                            startAt = startValue,
                                            endAt = endValue,
                                            curriculumImgUrl = roomInfo.roomImageUrl,
                                            seminarUrl = url,
                                            password = password,
                                            secretYn = secretYn,
                                            maxEnterCount = roomInfo.maxParticipation,
                                            createRoomCount = createRoomCount )
                        val params = BaseParam(seminar).parameter
                        Timber.d("param $params" )

                        viewModel.apply {
                            setSeminar(params).subscribeBy(onNext = {it->
                                    if(it.isSucceed) {
                                        SeminarAlertDialog.Builder(this@CreateSeminarActivity)
                                            .setCancelable(false)
                                            .setTitle(R.string.seminar_create_success_message)
                                            .setMessage(R.string.seminar_create_success_detail_message)
                                            .setPositiveButton(R.string.system_alert_btn_ok) {
                                                finish()
                                            }
                                            .show()
                                    }
                                }, onError = {})
                        }
                    }
                }catch (e : Exception){
                    Timber.d("error " + e.message)
                }
            }

            R.id.seminar_plus -> {
                if(selectedPosition == -1) {
                    CommonAlertDialog.Builder(this)
                        .setCancelable(false)
                        .setMessage(R.string.seminar_room_select_message)
                        .setPositiveButton {  }
                        .show()
                    return
                }

                Timber.tag(TAG).d("" + selectRoomInfoDto.maxParticipation)
                Timber.tag(TAG).d("createRoomCount $createRoomCount")

                when(selectRoomInfoDto.maxParticipation) {
                    18 -> if(createRoomCount < 12) createRoomCount += 1

                    32 -> if(createRoomCount < 7) createRoomCount += 1

                    50 -> if(createRoomCount < 4) createRoomCount += 1
                }
                viewBinding.apply {
                    seminarRoomCount.text = getString(R.string.room_count_text, "$createRoomCount")

                    val totalCount = if((createRoomCount * selectRoomInfoDto.maxParticipation) >= 200 ) 200 else   createRoomCount * selectRoomInfoDto.maxParticipation
                    seminarTotalCount.text = getString(R.string.people_total_count_text, "$totalCount")
                }

                isEnableCheck()
            }

            R.id.seminar_minus -> {
                if(selectedPosition == -1) {
                    CommonAlertDialog.Builder(this)
                        .setCancelable(false)
                        .setMessage(R.string.seminar_room_select_message)
                        .setPositiveButton { }
                        .show()

                    return
                }

                if(createRoomCount <= 0) {
                    createRoomCount = 0
                    return
                }
                createRoomCount -= 1
                viewBinding.apply {
                    //seminarRoomCount.text = String.format("%d", createRoomCount)
                    seminarRoomCount.text = getString(R.string.room_count_text, "$createRoomCount")
                    seminarTotalCount.text = getString(R.string.people_total_count_text, "${createRoomCount * selectRoomInfoDto.maxParticipation}")
                }
                isEnableCheck()
            }
        }
    }


    private fun init() = try {
        viewBinding.apply {
            seminarCreate.isEnabled = false

            val now: Long = System.currentTimeMillis()
            val mDate = Date(now)

            startDate.text = String.format("%s", DateFormatter.instance.simpleDotted().format(mDate))
            endDate.text = String.format("%s", DateFormatter.instance.simpleDotted().format(mDate))

            val calendar = Calendar.getInstance()

            viewBinding.apply {
                startTime.text  = SimpleDateFormat("a hh:mm").format(calendar.time)
                endTime.text    = SimpleDateFormat("a hh:mm").format(calendar.time)
                startTimeValue  = SimpleDateFormat("HH:mm").format(calendar.time)
                endTimeValue    = SimpleDateFormat("HH:mm").format(calendar.time)
            }

            editSeminarTeacher.text = repository.member.value!!.profileName

            viewModel.apply {
                getRoomInfo("")
            }

            startHour = calendar[Calendar.HOUR_OF_DAY]
            startMinute = calendar[Calendar.MINUTE]

        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

    override fun onResume() {
        super.onResume()
    }

    private fun setButton(index : Int) = viewBinding.apply {
        val roomInfoText = arrayOf(totalRoom, smallRoom, middleRoom, largeRoom)
        roomInfoText.forEach {
            it.setTextColor(ContextCompat.getColor(this@CreateSeminarActivity, R.color.tory_black))
        }
        roomInfoText[index].setTextColor(ContextCompat.getColor(this@CreateSeminarActivity, R.color.tory_purple))
    }



    private fun isEnableCheck(init : Boolean = false) = viewBinding.apply {
        if(selectedPosition != -1 && init) {
            createRoomCount = 0
            selectRoomInfoDto = mSeminarRoomArrayList[selectedPosition]

            seminarRoomCount.text = getString(R.string.room_count_text, "$createRoomCount")
            seminarCapacityCount.text = getString(R.string.people_total_count_text, "${selectRoomInfoDto.maxParticipation}")
            seminarTotalCount.text = getString(R.string.people_total_count_text, "${createRoomCount * selectRoomInfoDto.maxParticipation}")

        }

        seminarCreate.isEnabled =   editSeminarTitle.text.toString().isNotEmpty()           &&
                                    //editSeminarExplanation.text.toString().isNotEmpty()     &&
                                    editSeminarTeacher.text.toString().isNotEmpty()         &&
                                    //seminarUrl.text.toString().isNotEmpty()                 &&
                                    selectedPosition != -1                                  &&
                                    createRoomCount  != 0
    }

}