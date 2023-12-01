package com.tnmeta.torymeta.campus.model


enum class CategoryType() { HAIR, FACE, TOP, BOTTOM, SHOES; }

data class AvatarCategoryData(
    val type : CategoryType,
    val categoryName : String,
    val titleResId : Int,

    var isSelect  : Boolean = false
)


enum class ColorType() { HAIR, SKIN; }

data class ColorData (
    val type : ColorType,
    val colorName : String
)