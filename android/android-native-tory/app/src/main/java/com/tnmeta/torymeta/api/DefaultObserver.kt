package com.tnmeta.torymeta.api

import android.util.Log
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.model.result.ApiResponse
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.ui.CommonLoadingView
import io.reactivex.rxjava3.core.Observer
import io.reactivex.rxjava3.disposables.Disposable
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class DefaultObserver(private val uiMode: ApiMode.UIMode): Observer<Any> {
    var loadingView: CommonLoadingView? = null

    override fun onSubscribe(d: Disposable) {
        if( uiMode != ApiMode.UIMode.NONE ) {
            CoroutineScope(Dispatchers.Main).launch {
                loadingView = CommonLoadingView.createInRootView(ToryApplication.activity!!)
                loadingView!!.show(true, 1000L)
            }
        }
    }

    override fun onComplete() {
        Log.e(Api.TAG, "onComplete")
        CoroutineScope(Dispatchers.Main).launch {
            loadingView?.dismiss()
        }
    }

    override fun onError(e: Throwable) {
        Log.e(Api.TAG, "onError: ${e}")

        CoroutineScope(Dispatchers.Main).launch {
            loadingView?.dismiss()

            // 알림창
            when( uiMode ) {
                ApiMode.UIMode.ALERT_RESTART-> {
                    CommonAlertDialog.Builder(ToryApplication.activity!!)
                        .setCancelable(false)
                        .setMessage(ToryApplication.activity!!.getString(R.string.system_alert_network_error_restart))
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                            ToryApplication.exitApp()
                        }
                        .show()
                }

                ApiMode.UIMode.ALERT_WARNING-> {
                    CommonAlertDialog.Builder(ToryApplication.activity!!)
                        .setCancelable(false)
                        .setMessage(ToryApplication.activity!!.getString(R.string.system_alert_network_warning))
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                        }
                        .show()
                }

                else -> {}
            }
        }
    }

    override fun onNext(data: Any) {
        // resultCode가 에러인 경우 알림창
        val apiResponse = data as? ApiResponse<*> ?: return

        Timber.d("DefaultObserver " + apiResponse.resultCode)

        if( apiResponse.isResultOK || apiResponse.resultCode!!.isNotEmpty()) {
            return
        }

        CoroutineScope(Dispatchers.Main).launch {
            when( uiMode ) {
                ApiMode.UIMode.ALERT_RESTART-> {
                    CommonAlertDialog.Builder(ToryApplication.activity!!)
                        .setCancelable(false)
                        .setTitle("Error ${apiResponse.resultCode}")
                        .setMessage(ToryApplication.activity!!.getString(R.string.system_alert_network_error_restart) + "\n${apiResponse.resultMessage}")
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                            ToryApplication.exitApp()
                        }
                        .show()
                }

                ApiMode.UIMode.ALERT_WARNING-> {
                    CommonAlertDialog.Builder(ToryApplication.activity!!)
                        .setCancelable(false)
                        .setTitle("Error ${apiResponse.resultCode}")
                        .setMessage(ToryApplication.activity!!.getString(R.string.system_alert_network_warning) + "\n${apiResponse.resultMessage}")
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                        }
                        .show()
                }

                else -> {}
            }
        }
    }
}