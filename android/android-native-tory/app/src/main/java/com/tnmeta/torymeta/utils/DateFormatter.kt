package com.tnmeta.torymeta.utils

import android.icu.text.SimpleDateFormat

class DateFormatter {
    fun dateFullFormat(): SimpleDateFormat {
        return SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
    }

    fun dateFormatter(): SimpleDateFormat {
        return SimpleDateFormat("yyyyMMdd")
    }

    fun simpleDotted() : SimpleDateFormat {
        return SimpleDateFormat("yyyy.MM.dd")
    }

    fun fullDotted() : SimpleDateFormat {
        return SimpleDateFormat("yyyy.MM.dd HH:mm:ss")
    }

    fun dateBarFormatter() : SimpleDateFormat {
        return SimpleDateFormat("yyyy-MM-dd")
    }

    fun dateBarTimeFormatter() : SimpleDateFormat {
        return SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
    }


    fun yearDayFormatter() : SimpleDateFormat {
        return SimpleDateFormat("yyyy-MM-dd (E) a hh:mm")
    }

    fun yearDayfullFormatter() : SimpleDateFormat {
        return SimpleDateFormat("yyyy-MM-dd (E) HH:mm")
    }


    fun dateDayFormatter() : SimpleDateFormat {
        return SimpleDateFormat("MM월dd일 (E) HH:mm")
    }

    fun dateDayFormatterA() : SimpleDateFormat {
        return SimpleDateFormat("MM월dd일 a hh:mm")
    }

    fun dateTimeFormatter() : SimpleDateFormat {
        return SimpleDateFormat("a hh:mm")
    }

    fun hourTimeFormatter() : SimpleDateFormat {
        return SimpleDateFormat("HH:mm")
    }

    companion object {
        @JvmStatic
        val instance by lazy { DateFormatter() }
    }
}