package com.tnmeta.torymeta.model.dto

/**
 * NFTCollectionDTO
 */
data class NFTCollectionDTO (
    val nftIdx: String,
    val ownerId: String,
    val creatorId: String,
    val imageURL: String,
    val status: String
)
