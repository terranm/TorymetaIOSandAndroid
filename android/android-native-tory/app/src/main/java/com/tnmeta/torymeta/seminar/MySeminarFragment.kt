package com.tnmeta.torymeta.seminar

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.FragmentActivity
import androidx.navigation.fragment.findNavController
import androidx.viewpager2.adapter.FragmentStateAdapter
import com.google.android.material.tabs.TabLayoutMediator
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.databinding.FragmentMySeminarBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.VideoUrl
import com.tnmeta.torymeta.seminar.model.ToryLoungeInfo
import com.tnmeta.torymeta.seminar.myseminar.MyOpenedFragment
import com.tnmeta.torymeta.seminar.myseminar.MySubScriptionFragment
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.unity.UnityUtils
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber


class MySeminarFragment : BaseFragment(), View.OnClickListener {

    companion object {
        val TAG: String = MySeminarFragment::class.java.simpleName

    }

    private var _viewBinding: FragmentMySeminarBinding? = null
    private val viewBinding get() = _viewBinding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _viewBinding = FragmentMySeminarBinding.inflate(inflater, container, false)
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {

            serminarPager.apply {
                adapter = ViewpagerFragmentAdapter(requireActivity())
            }

            serminarTabs.apply {
                val titles = listOf(R.string.seminar_apply_title, R.string.seminar_participation_title)
                TabLayoutMediator(serminarTabs, serminarPager) { tab, position ->
                    tab.text = getString(titles[position])
                }.attach()
            }

            arrayOf(ivBack, toryLounge).forEach {
                it.setOnClickListener(this@MySeminarFragment)
            }

        }
    }

    /**
     * onResume
     */
    override fun onResume() {
        super.onResume()
        try {
            UnityUtils.resume()

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    /**
     * onPause
     */
    override fun onPause() {
        super.onPause()
        try {
            UnityUtils.pause()
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    /**
     * onDestroyView
     */
    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }

    /**
     * onClick
     */
    override fun onClick(view: View) {
        when(view.id) {
            R.id.ivBack -> findNavController().popBackStack()
            R.id.tory_lounge -> {
                //if(repository.myAvatar.value!!.id == 0) {
                if(repository.hasAvatarAttrYn == Constants.NoValue) {
                    CommonAlertDialog.Builder(requireContext())
                        .setCancelable(false)
                        .setMessage(R.string.avatar_make_message)
                        .setPositiveButton {}
                        .show()
                    return
                }

                repository.apply {
                    val params = BaseParam(
                        VideoUrl(
                            loungeType = "LOUNGE",
                            mediaType = "mp4"
                        )).parameter

                    getVideoUrl(params).subscribeBy(onNext = { it->
                        val infoData = enterToryLounge(
                            item = ToryLoungeInfo(videoUrl = it.videoUrl)
                        )

                        val action = MySeminarFragmentDirections.actionMySeminarToToryWorld(infoData)
                        findNavController().navigate(action)
                    }, onError = {})
                }
            }
        }
    }

    /**
     * ViewpagerFragmentAdapter
     */
    inner class ViewpagerFragmentAdapter(fragmentActivity: FragmentActivity): FragmentStateAdapter(fragmentActivity) {

        private val fragmentList = listOf(
                                        MySubScriptionFragment(),
                                        MyOpenedFragment()
                                    )

        override fun getItemCount(): Int {
            return fragmentList.size
        }

        override fun createFragment(position: Int): Fragment {
            return fragmentList[position]
        }
    }

}