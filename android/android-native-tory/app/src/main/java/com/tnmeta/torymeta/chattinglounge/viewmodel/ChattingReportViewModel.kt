package com.tnmeta.torymeta.chattinglounge.viewmodel

import com.google.gson.JsonObject
import com.tnmeta.torymeta.base.BaseViewModel

class ChattingReportViewModel : BaseViewModel() {
    companion object {
        val TAG = ChattingReportViewModel::class.java
    }

    /**
     * reportMember()
     */
    fun reportMember(jsonObject: JsonObject) = repository.setChattingReport(jsonObject)


    /**
     * reportChattingRoom()
     */
    fun reportChattingRoom(jsonObject: JsonObject) = repository.setChattingReport(jsonObject)

}