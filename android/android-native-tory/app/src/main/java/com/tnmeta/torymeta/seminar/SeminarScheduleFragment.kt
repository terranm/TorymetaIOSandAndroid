package com.tnmeta.torymeta.seminar

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.databinding.FragmentSeminarScheduleBinding
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.seminar.adapter.SeminarScheduleAdapter
import com.tnmeta.torymeta.seminar.viewmodel.SeminarScheduleViewModel
import com.tnmeta.torymeta.utils.DateFormatter
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.SimpleDateFormat
import java.util.Calendar


class SeminarScheduleFragment : BaseFragment(), View.OnClickListener {

    companion object {
        val TAG : String = SeminarScheduleFragment::class.java.simpleName
        fun newInstance() =
            SeminarScheduleFragment().apply {}
    }

    private var _viewBinding: FragmentSeminarScheduleBinding? = null
    private val viewBinding get() = _viewBinding!!

    private var dateCount = 0
    private val mSeminarArrayList = ArrayList<SeminarDto>()
    private lateinit var mSeminarAdapter : SeminarScheduleAdapter

    private lateinit var viewModel: SeminarScheduleViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentSeminarScheduleBinding.inflate(inflater, container, false)
        viewBinding.apply {
            viewModel = ViewModelProvider(this@SeminarScheduleFragment)[SeminarScheduleViewModel::class.java]
        }
        return viewBinding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {

            arrayOf(imgBeforeDay, imgNextDay, ivBack).forEach {
                it.setOnClickListener(this@SeminarScheduleFragment)
            }

            initSememinar()

            val day = Calendar.getInstance()
            day.add(Calendar.DATE, dateCount)
            val date = SimpleDateFormat("yy.MM.dd").format(day.time)
            txtToday.text = date.toString()

            txtDate.apply {
                if(dateCount == 0) {
                    text = resources.getText(R.string.seminar_today)
                    setTextColor(ContextCompat.getColor(requireContext(), R.color.tory_purple))
                }else {
                    if(dateCount < 0) {
                        text = resources.getText(R.string.seminar_end)
                        setTextColor(ContextCompat.getColor(requireContext(), R.color.color_d9d9d9d))
                    }else {
                        text = resources.getString(R.string.seminar_next)
                        setTextColor(ContextCompat.getColor(requireContext(), R.color.sub_purple_2))
                    }
                }
                mSeminarAdapter.setDateCount(dateCount = dateCount)
            }


            if(Constants.is_FirebaseAnalytics) {
                CoroutineScope(Dispatchers.Main).launch {
                    firebaseAnalyticsMember(FirebaseParam.mobile_seminaschedule)
                }
            }
        }
    }

    private fun initSememinar() = try {
        viewBinding.apply {
            mSeminarAdapter = SeminarScheduleAdapter(
                items = mSeminarArrayList,
                itemViewClick = {
                    val action = SeminarScheduleFragmentDirections.actionSeminarScheduleToApplySeminar(it)
                    findNavController().navigate(action)
                }
            )

            recyclerView.apply {
                layoutManager = LinearLayoutManager(requireContext())
                adapter = mSeminarAdapter
            }

            viewModel.seminarArray.observe(viewLifecycleOwner) { list ->
                mSeminarArrayList.apply {
                    clear()
                    addAll(list)
                }

                if (mSeminarArrayList.isEmpty()) {
                    emptyView.visibility = View.VISIBLE
                    recyclerView.visibility = View.GONE
                } else {
                    recyclerView.visibility = View.VISIBLE
                    emptyView.visibility = View.GONE
                }

                mSeminarAdapter.notifyDataSetChanged()
                loadingProgress.visibility = View.GONE
            }

            requestSeminarInfo()
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    override fun onResume() {
        super.onResume()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.ivBack -> findNavController().popBackStack()

            R.id.img_before_day -> {
                viewBinding.apply {
                    dateCount -= 1

                    val day = Calendar.getInstance()
                    day.add(Calendar.DATE, dateCount)
                    val date = SimpleDateFormat("yy.MM.dd").format(day.time)
                    txtToday.text = date.toString()

                    txtDate.apply {
                        if(dateCount == 0) {
                            text = resources.getText(R.string.seminar_today)
                            setTextColor(ContextCompat.getColor(requireContext(), R.color.tory_purple))
                        }else {
                            if(dateCount < 0) {
                                text = resources.getText(R.string.seminar_end)
                                setTextColor(ContextCompat.getColor(requireContext(), R.color.color_d9d9d9d))
                            }else {
                                text = resources.getString(R.string.seminar_next)
                                setTextColor(ContextCompat.getColor(requireContext(), R.color.sub_purple_2))
                            }
                        }
                    }
                }
                mSeminarAdapter.setDateCount(dateCount =  dateCount)
                requestSeminarInfo()
            }

            R.id.img_next_day -> {
                viewBinding.apply {
                    dateCount += 1

                    val day = Calendar.getInstance()
                    day.add(Calendar.DATE, dateCount)
                    val date = SimpleDateFormat("yy.MM.dd").format(day.time)
                    txtToday.text = date.toString()

                    txtDate.apply {
                        if(dateCount == 0) {
                            text = resources.getText(R.string.seminar_today)
                            setTextColor(ContextCompat.getColor(requireContext(), R.color.tory_purple))
                        }else {
                            if(dateCount < 0) {
                                text = resources.getText(R.string.seminar_end)
                                setTextColor(ContextCompat.getColor(requireContext(), R.color.color_d9d9d9d))
                            }else {
                                text = resources.getString(R.string.seminar_next)
                                setTextColor(ContextCompat.getColor(requireContext(), R.color.sub_purple_2))
                            }
                        }
                    }
                }
                mSeminarAdapter.setDateCount(dateCount =  dateCount)
                requestSeminarInfo()
            }
        }
    }

    private fun requestSeminarInfo() = viewBinding.apply {
        val day = Calendar.getInstance()
        day.add(Calendar.DATE, dateCount)
        val searchDate = DateFormatter.instance.dateFormatter().format(day.time)

        loadingProgress.visibility = View.VISIBLE
        viewModel.apply {
            getDateSeminar(searchDate)
        }
    }

}