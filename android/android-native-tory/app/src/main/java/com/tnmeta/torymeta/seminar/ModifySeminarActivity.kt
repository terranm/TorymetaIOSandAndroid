package com.tnmeta.torymeta.seminar


import android.app.AlertDialog
import android.app.DatePickerDialog
import android.app.TimePickerDialog
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.text.format.DateFormat
import android.view.View
import androidx.core.content.ContextCompat
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.PagerSnapHelper
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.common.RoomSize
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityModifySeminarBinding
import com.tnmeta.torymeta.main.model.RoomInfoDto
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.result.ApiResponse
import com.tnmeta.torymeta.seminar.adapter.SeminarRoomViewAdapter
import com.tnmeta.torymeta.seminar.dialog.SeminarPasswordBottomDialogFragment
import com.tnmeta.torymeta.seminar.model.SeminarParam
import com.tnmeta.torymeta.seminar.model.detail.SeminarDetailDto
import com.tnmeta.torymeta.seminar.viewmodel.SeminarViewModel
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.SimpleDateFormat
import java.util.Calendar


class ModifySeminarActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH),
                                View.OnClickListener {
    companion object {
        val TAG : String = ModifySeminarActivity::class.java.simpleName
    }

    private val viewBinding by viewBinding(ActivityModifySeminarBinding::inflate)
    private lateinit var viewModel: SeminarViewModel

    private val mSeminarRoomArrayList = ArrayList<RoomInfoDto>()
    private var selectedPosition = -1
    //private lateinit var mRoomAdapter : RecyclerViewAdapter
    private lateinit var mRoomAdapter : SeminarRoomViewAdapter

    private lateinit var mSeminarDetailInfo : SeminarDetailDto

    private var startTimeValue = ""
    private var endTimeValue  = ""
    private var password = ""
    private var seminarID = -1


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

            viewModel = ViewModelProvider(this@ModifySeminarActivity)[SeminarViewModel::class.java]

            seminarModify.isEnabled = false

            mRoomAdapter = SeminarRoomViewAdapter(
                mSeminarRoomArrayList,
                onItemClick = { _, position  ->
                    selectedPosition = position
                    isEnableCheck()
                },
                selectedPosition
            )

            listView.apply {
                layoutManager = LinearLayoutManager(this@ModifySeminarActivity, RecyclerView.HORIZONTAL, false)
                adapter = mRoomAdapter
            }

            val pagerSnapHelper = PagerSnapHelper()
            pagerSnapHelper.attachToRecyclerView(listView)
            indicator.attachToRecyclerView(listView, pagerSnapHelper)
            mRoomAdapter.registerAdapterDataObserver(indicator.adapterDataObserver);

            if(intent.hasExtra(Params.SEMINAR_ID)){
                seminarID = intent.getIntExtra(Params.SEMINAR_ID, 0)
                CoroutineScope(Dispatchers.Main).launch {
                    getSeminarDetailInfo(seminarID)
                }
            }

            arrayOf(totalRoom, smallRoom, smallCount, middleRoom, middleCount, largeRoom, largeRoomCount,
                            startDateLayout, startTimeLayout, endTimeLayout).forEach {
                it.setOnClickListener(this@ModifySeminarActivity)
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
            editSeminarExplanation.run {
                addTextChangedListener(object : TextWatcher {
                    override fun beforeTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {}
                    override fun onTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {
                        if(editSeminarExplanation.text.toString().isNotEmpty()) {
                            isEnableCheck()
                        }
                    }
                    override fun afterTextChanged(editable: Editable?) {}
                })
            }

            seminarUrl.run {
                addTextChangedListener(object : TextWatcher {
                    override fun beforeTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {}
                    override fun onTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {

                        if(seminarUrl.text.toString().isNotEmpty()) {
                            isEnableCheck()
                        }
                    }
                    override fun afterTextChanged(editable: Editable?) {}
                })
            }

            openSwitch.setOnClickListener{
                if(openSwitch.isChecked) {
                    SeminarPasswordBottomDialogFragment(this@ModifySeminarActivity).apply {
                        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                        onClickListener = { data ->
                            if(data.toString().isEmpty()) {
                                openSwitch.isChecked = false
                            }else {
                                Timber.d("" + data.toString())
                                password = data.toString()
                            }
                        }
                        show(this@ModifySeminarActivity.supportFragmentManager, Constants.SeminarPasswordBottomDialogFragmentTag)
                    }
                }
            }

            seminarModify.setOnClickListener(this@ModifySeminarActivity)
         }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.close -> {
                CommonAlertDialog.Builder(this)
                    .setCancelable(false)
                    .setMessage(R.string.seminar_modify_cancel_message)
                    .setPositiveButton(R.string.system_alert_btn_close) {
                        finish()
                    }
                    .setNegativeButton(R.string.modeify) {}
                    .show()
            }

            R.id.total_room -> {
                setButton(0)
                viewModel.apply {
                    getRoomInfo("")
                }
            }
            R.id.small_room,
            R.id.small_count -> {
                setButton(1)
                viewModel.apply {
                    getRoomInfo(RoomSize.SMALL)
                }
            }
            R.id.middle_room,
            R.id.middle_count -> {
                setButton(2)
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
                val data = DatePickerDialog.OnDateSetListener { view, year, month, day ->
                    viewBinding.apply {

                        val selectTime = String.format("%d.%d.%d", year, month, day)
                        if(startDate.text.toString() != selectTime ) {
                            viewBinding.seminarModify.isEnabled = true
                            startDate.text = selectTime
                            endDate.text = String.format("%d.%d.%d", year, month, day)
                        }else {
                            viewBinding.seminarModify.isEnabled = false
                        }
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
                val timeSetListener = TimePickerDialog.OnTimeSetListener { timePicker, hour, minute ->
                    calendar.set(Calendar.HOUR_OF_DAY, hour)
                    calendar.set(Calendar.MINUTE, minute)

                    viewBinding.apply {
                        startTime.text = SimpleDateFormat("a hh:mm").format(calendar.time)
                        endTime.text = SimpleDateFormat("a hh:mm").format(calendar.time)

                        startTimeValue = SimpleDateFormat("HH:mm").format(calendar.time)
                        endTimeValue   = SimpleDateFormat("HH:mm").format(calendar.time)

                        val startDateTime = DateFormatter.instance.dateBarTimeFormatter().parse(mSeminarDetailInfo.startAt)
                        val timeValue = DateFormatter.instance.hourTimeFormatter().format(startDateTime)
                        viewBinding.seminarModify.isEnabled = startTimeValue != timeValue

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
                val timeSetListener = TimePickerDialog.OnTimeSetListener { timePicker, hour, minute ->
                    calendar.set(Calendar.HOUR_OF_DAY, hour)
                    calendar.set(Calendar.MINUTE, minute)

                    viewBinding.apply {
                        endTime.text = SimpleDateFormat("a hh:mm").format(calendar.time)
                        endTimeValue   = SimpleDateFormat("HH:mm").format(calendar.time)

                        val endDateTime = DateFormatter.instance.dateBarTimeFormatter().parse(mSeminarDetailInfo.endAt)
                        val timeValue = DateFormatter.instance.hourTimeFormatter().format(endDateTime)
                        viewBinding.seminarModify.isEnabled = endTimeValue != timeValue
                    }
                }
                val timePickerDialog = TimePickerDialog(this, AlertDialog.THEME_HOLO_LIGHT, timeSetListener, hour, minute,
                    DateFormat.is24HourFormat(this))
                timePickerDialog.show()
            }

            R.id.seminar_modify -> {
                try {
                    CommonAlertDialog.Builder(this)
                        .setCancelable(false)
                        .setMessage(R.string.seminar_modify_update_message)
                        .setPositiveButton(R.string.seminar_cancel_yes) {
                            CoroutineScope(Dispatchers.Main).launch {
                                updateSeminarInfo()
                            }
                        }
                        .setNegativeButton(R.string.seminar_apply_cancel) {}
                        .show()
                }catch (e : Exception){
                    Timber.d(e.message)
                }
            }
        }
    }

    private fun updateSeminarInfo() = try {
        Timber.tag(TAG).d("updateSeminarInfo ")

        viewBinding.apply {
            if(selectedPosition == -1) selectedPosition = 0
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
                createRoomCount = 0)
            val params = BaseParam(seminar).parameter

            //Timber.tag(TAG).d("updateSeminarInfo param " + seminarID +""+ params)

            viewModel.apply {
                updateSeminar(seminarID, params)
                    .subscribeBy(onNext = {
                        if(it.resultCode == ApiResponse.RESULT_CODE_OK && it.result!!.isSucceed) {
                            CommonAlertDialog.Builder(this@ModifySeminarActivity)
                                .setCancelable(false)
                                .setMessage(R.string.seminar_modify_success_message)
                                .setPositiveButton(R.string.system_alert_btn_ok) {
                                    setResult(RESULT_OK)
                                    finish()
                                }
                                .show()
                        }else {
                            CommonAlertDialog.Builder(this@ModifySeminarActivity)
                                .setMessage(it.resultMessage.toString())
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                        }

                    }, onError = {})
            }
        }

    }catch (e : Exception){
        Timber.d("updateSeminarInfo "  + e.message)
    }



    private fun getSeminarDetailInfo(id : Int) = try {
        Timber.tag(TAG).d("getSeminarDetailInfo $id" )
        viewBinding.apply {
            repository.getSeminarDetail(id).apply {
                subscribeBy(onNext = { item ->
                    mSeminarDetailInfo = item

                    setButton(0)
                    val roomValue = ""

                    editSeminarTitle.setText(item.title)
                    editSeminarExplanation.setText(item.description)
                    editSeminarTeacher.setText(item.teacherName)
                    seminarUrl.setText(item.seminarUrl)
                    openSwitch.isChecked = item.secretYn == "Y"

                    val startDateTime = DateFormatter.instance.dateBarTimeFormatter().parse(item.startAt)
                    startDate.text = DateFormatter.instance.simpleDotted().format(startDateTime)
                    startTime.text = DateFormatter.instance.dateTimeFormatter().format(startDateTime)
                    startTimeValue = DateFormatter.instance.hourTimeFormatter().format(startDateTime)

                    val endDateTime = DateFormatter.instance.dateBarTimeFormatter().parse(item.endAt)
                    endDate.text = DateFormatter.instance.simpleDotted().format(endDateTime)
                    endTime.text = DateFormatter.instance.dateTimeFormatter().format(endDateTime)
                    endTimeValue = DateFormatter.instance.hourTimeFormatter().format(endDateTime)

                    Timber.tag(TAG).d("getRoomInfo $roomValue")
                    viewModel.apply {
                        getRoomInfo(roomValue)
                        seminarRoomList.observe(this@ModifySeminarActivity) { list ->
                            mSeminarRoomArrayList.apply {
                                clear()
                                addAll(list)
                            }

                            val roomInfo = mSeminarRoomArrayList.filter {
                                it.roomId == mSeminarDetailInfo.roomId
                            }

                            if(roomInfo.isNotEmpty()) {
                                val position = mSeminarRoomArrayList.indexOf(roomInfo[0])
                                roomInfo[0].isSelect = true

                                selectedPosition = position

                                if(position != -1)
                                    mSeminarRoomArrayList[position] = roomInfo[0]

                            }else {
                                selectedPosition = -1
                            }

                            mRoomAdapter.notifyDataSetChanged()

                            if(selectedPosition != -1)
                                listView.scrollToPosition(selectedPosition)

                        }
                    }
                }, onError = {}, onComplete = {})
            }
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun setButton(index : Int) = viewBinding.apply {
        val roomInfoText = arrayOf(totalRoom, smallRoom, middleRoom, largeRoom)
        roomInfoText.forEach {
            it.setTextColor(ContextCompat.getColor(this@ModifySeminarActivity, R.color.tory_black))
        }
        roomInfoText[index].setTextColor(ContextCompat.getColor(this@ModifySeminarActivity, R.color.tory_purple))
    }


    private fun isEnableCheck() = viewBinding.apply {

        val titleValue = mSeminarDetailInfo.title               != editSeminarTitle.text.toString()
        val descriptionValue = mSeminarDetailInfo.description   != editSeminarExplanation.text.toString()
        val urlValue = mSeminarDetailInfo.seminarUrl            != seminarUrl.text.toString()

        var roomValue = false

        if(selectedPosition != -1) {
            roomValue = mSeminarDetailInfo.roomId != mSeminarRoomArrayList[selectedPosition].roomId
        }

        if(mSeminarDetailInfo != null) {
            seminarModify.isEnabled = titleValue || descriptionValue || urlValue || roomValue
        }
    }


    /*
    inner class RecyclerViewAdapter : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = mSeminarRoomArrayList.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = RoominfoListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val itemValue = mSeminarRoomArrayList!![position]
                holder.run {
                    bind(itemValue)

                    itemView.setOnClickListener {

                        if(selectedPosition == position)
                            return@setOnClickListener

                        val prevPosition = selectedPosition
                        itemValue.isSelect = !itemValue.isSelect
                        selectedPosition = position
                        notifyItemChanged(selectedPosition)

                        if (prevPosition != -1 && selectedPosition != prevPosition) {
                            val itemInfo = mSeminarRoomArrayList!![prevPosition]
                            itemInfo.isSelect = false
                            notifyItemChanged(prevPosition)
                        }

                        isEnableCheck()
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: RoominfoListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: RoomInfoDto) {
                with(viewBinding) {
                    item.run {
                        Glide.with(root.context)
                            .load(roomImageUrl)
                            .transform(CenterCrop(), RoundedCorners(32))
                            .into(imgThumbnail)
                        seminarRoomName.text = roomName

                        val imageResouce = if (item.isSelect) R.drawable.common_corner_round_purple_01
                                            else R.drawable.common_corner_round_white_01

                        thumbnailLayout.setBackgroundResource(imageResouce)
                    }
                }
            }
        }
    }
    */

}