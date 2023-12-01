package com.tnmeta.torymeta.base

import androidx.lifecycle.ViewModel
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.api.ToryRepository


/**
 * ViewModel Super Class
 */
open class BaseViewModel: ViewModel() {
    companion object {
        private const val TAG = "BaseViewModel"
    }

    protected val repository: ToryRepository by lazy { ToryApplication.getRepository(ToryApplication.activity!!) }

    val member = repository.member

    val universityList = repository.universityList
    fun getCampus(code: String) = repository.getCampus(code)
    fun getMyCampus() = repository.getMyCampus()
    fun getCampusBuildingMarker(code: String) = repository.getCampusBuildingMarker(code)
    fun getMyCampusBuildingMarker() = repository.getMyCampusBuildingMarker()

    fun getMarkerDetail(markerId: Int) = repository.getMarkerDetail(markerId)

    init {
    }
}