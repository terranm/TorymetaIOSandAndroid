package com.tnmeta.torymeta.model.result


data class ApiResponse<T> ( // null을 대비하여 디폴트 value?
    val resultCode: String?,
    val resultMessage: String?,
    var result: T?) {
    val isResultOK: Boolean
        get() = (resultCode == RESULT_CODE_OK)

    companion object {
        const val RESULT_CODE_OK        = "0000"
    }
}
