package com.tnmeta.torymeta.unity

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import androidx.navigation.fragment.navArgs
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.databinding.FragmentToryMetaWorldBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber

class ToryMetaWorldFragment : BaseFragment() {

    companion object {
        val TAG : String = ToryMetaWorldFragment::class.java.simpleName

    }


    private var _viewBinding: FragmentToryMetaWorldBinding? = null
    private val viewBinding get() = _viewBinding!!

    private val args by navArgs<ToryMetaWorldFragmentArgs>()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        ToryApplication.isToryWordBack = false
        requireActivity().window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        _viewBinding = FragmentToryMetaWorldBinding.inflate(inflater, container, false)
        return viewBinding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {
            try {
                repository.setIsShowBottomDialog(true)
                ToryApplication.isToryWordEnter = true

                if (UnityUtils.getPlayer() != null) {
                    (UnityUtils.getPlayer().parent as ViewGroup).removeAllViews()
                }

                UnityUtils.createPlayer(requireActivity()) {
                    UnityUtils.addUnityViewToGroup(unity)
                }

                if(Constants.is_FirebaseAnalytics) {
                    CoroutineScope(Dispatchers.Main).launch {

                        when(args.param.scene) {
                            ToryMetaSceneParam.lobby -> firebaseAnalyticsMember(FirebaseParam.mobile_torylounge)
                            ToryMetaSceneParam.world -> firebaseAnalyticsMember(FirebaseParam.mobile_3dcampus)
                        }
                    }
                }

                sendNativeUnityMessage(type = ToryMetaMessageType.SwitchScene,
                                        valueParam = args.param)


            }catch (e : Exception){
                Timber.d(e.message)
            }
        }
    }


    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
        
    }

    override fun onResume() {
        UnityUtils.resume()
        super.onResume()

    }


    override fun onPause() {
        UnityUtils.pause()
        super.onPause()

    }



}