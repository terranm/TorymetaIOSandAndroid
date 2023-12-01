package com.tnmeta.torymeta.utils

import java.text.NumberFormat
import java.time.format.DateTimeFormatter
import java.util.*

object FormatUtil {
    val numberFormat: NumberFormat
        get() = NumberFormat.getInstance(Locale.getDefault())

    val dateFormat: DateTimeFormatter
        get() = DateTimeFormatter.ofPattern("d MMM uuuu")
}
