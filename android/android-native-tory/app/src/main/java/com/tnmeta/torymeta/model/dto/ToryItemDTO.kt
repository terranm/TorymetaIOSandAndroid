package com.tnmeta.torymeta.model.dto

/**
 * ToryItemDTO
 */
data class ToryItemDTO (
    val cashValue: Int,
    val itemId: String,
    val itemName: String,
    val itemValue: Int,
    val useYn: String) {
    val isEnabled: Boolean
        get() = (useYn == "Y")
}

