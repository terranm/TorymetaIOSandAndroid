package com.tnmeta.torymeta.my_page.profile

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.model.dto.InfoDTO
import timber.log.Timber

/**
 * 기본 프로필 리스트 화면
 */
class DefaultCollectionActivity: ImageCollectionActivity() {
    companion object {
        val TAG  : String        = DefaultCollectionActivity::class.java.simpleName
        const val PARAM_URL    = "url"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initList(repository.defaultProfileList)
    }

    override fun onScrolled(info : InfoDTO) {
    }


    override fun onBindItemView(itemView: View, data: Any) {
        val url = data as String
        Glide.with(this)
            .load(url)
            .centerCrop()
            .into(itemView as ImageView)
    }

    override fun onClickItem(data: Any) {
        try {
            val url = data as String
            val intent = Intent().apply {
                putExtra(PARAM_URL, url)
            }
            setResult(RESULT_OK, intent)
            finish()
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }
}