package com.tnmeta.torymeta.utils

import com.tnmeta.torymeta.main.model.SeminarDto
import androidx.recyclerview.widget.DiffUtil

class DiffUtil : Any() {

    val seminarDtoDiffUtil = object: DiffUtil.ItemCallback<SeminarDto>() {
        override fun areContentsTheSame(oldItem: SeminarDto, newItem: SeminarDto) =
            oldItem == newItem

        override fun areItemsTheSame(oldItem: SeminarDto, newItem: SeminarDto) =
            oldItem.id == newItem.id
    }


    companion object {
        @JvmStatic
        val instance by lazy { DiffUtil() }
    }
}