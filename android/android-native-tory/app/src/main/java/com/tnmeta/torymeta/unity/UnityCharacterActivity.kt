package com.tnmeta.torymeta.unity

import android.os.Bundle
import android.view.ViewGroup
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityUnityCharacterBinding
import com.unity3d.player.UnityPlayer
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch


class UnityCharacterActivity : BaseActivity() {

    private val viewBinding by viewBinding(ActivityUnityCharacterBinding::inflate)
    private var unityPlayer: UnityPlayer? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)


            unityPlayer = UnityPlayer(this@UnityCharacterActivity)
            window.clearFlags(1024)

            unity.addView(
                unityPlayer, ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
                )
            )

            unityPlayer?.requestFocus()

            CoroutineScope(Dispatchers.Main).launch {

                val params = "{\"member\":{\"birth\":\"19940809\",\"emailId\":\"testaos@torymeta.io\",\"imgUrl\":\"https://test-torymeta-member.s3.ap-northeast-2.amazonaws.com/229412182654_img_230213_161149.jpg\",\"locationExposeYn\":1,\"memberId\":229412182654,\"name\":\"안드로이드\",\"phoneNum\":\"01021976830\",\"profileName\":\"안드로이드\",\"universityCode\":\"CAU\"},\"scene\":\"university\",\"url\":\"null\"}";
                UnityPlayer.UnitySendMessage("Canvas", "SetText", params)

            }

        }
    }


    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        unityPlayer?.windowFocusChanged(hasFocus)
    }

    override fun onResume() {
        super.onResume()
        unityPlayer?.resume()
    }


}