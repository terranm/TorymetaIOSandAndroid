package com.tnmeta.torymeta.my_page.profile

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.model.dto.InfoDTO
import com.tnmeta.torymeta.model.dto.NFTCollectionDTO
import com.tnmeta.torymeta.ui.CommonAlertDialog
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber


/**
 * NFT 컬렉션 화면
 */
class NFTCollectionActivity: ImageCollectionActivity() {
    companion object {
        val TAG  : String         = NFTCollectionActivity::class.java.simpleName
        const val PARAM_URL    = "url"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        repository.getMyNFTCollectionList(ApiMode.UIMode.ONLY_LOADING, 1, 50)
            .subscribeBy(onNext = {
                initList(it.data, it.info)
            }, onError = {
                CommonAlertDialog.Builder(ToryApplication.activity!!)
                    .setCancelable(false)
                    .setMessage(ToryApplication.activity!!.getString(R.string.system_alert_network_warning))
                    .setPositiveButton(R.string.system_alert_btn_ok) {
                        finish()
                    }
                    .show()
             })
    }

    override fun onBindItemView(itemView: View, data: Any) {
        try {
            val collectionData = data as NFTCollectionDTO
            Glide.with(this).load(collectionData.imageURL).centerCrop().into(itemView as ImageView)
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onClickItem(data: Any) {
        try {
            val collectionData = data as NFTCollectionDTO

            val intent = Intent().apply {
                putExtra(PARAM_URL, collectionData.imageURL)
            }
            setResult(RESULT_OK, intent)
            finish()

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onScrolled(info: InfoDTO) {
        try {
            if(info.currentPage < info.lastPage) {

                val nextPage = if (info.currentPage + 1 < info.lastPage) info.currentPage + 1
                                else info.lastPage

                repository.getMyNFTCollectionList(ApiMode.UIMode.ONLY_LOADING, nextPage, 50)
                    .subscribeBy(onNext = {
                        initList(it.data)
                    }, onError = {
                        CommonAlertDialog.Builder(ToryApplication.activity!!)
                            .setCancelable(false)
                            .setMessage(ToryApplication.activity!!.getString(R.string.system_alert_network_warning))
                            .setPositiveButton(R.string.system_alert_btn_ok) {
                                finish()
                            }
                            .show()
                    })
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

}