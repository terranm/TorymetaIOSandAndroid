package com.tnmeta.torymeta.utils

import java.time.LocalDate

object DateUtil {

    /**
     * @return Today's Epoch Day, where day 0 is 1970-01-01
     */
    fun getToday(): Long {
        return LocalDate.now().toEpochDay()
    }

    /**
     * @return The LocalDate corresponding to the given day
     */
    fun dayToLocalDate(day: Long): LocalDate {
        return LocalDate.ofEpochDay(day)
    }

    /**
     * @return Day of the month, from 1 to 31
     */
    fun getDayOfMonth(): Int {
        return LocalDate.now().dayOfMonth
    }

    /**
     * @return Day of the year, from 1 to 365, or 366 in a leap year
     */
    fun getDayOfYear(): Int {
        return LocalDate.now().dayOfYear
    }
}