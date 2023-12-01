package com.tnmeta.torymeta.database.step

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "daily_steps")
data class DailySteps(
    @PrimaryKey val day: Long,
    @ColumnInfo(name = "steps")     val steps: Long = Long.MIN_VALUE,

    @ColumnInfo(name = "insteps")   val insteps: Long = Long.MIN_VALUE,

    @ColumnInfo(name = "outsteps")  val outsteps: Long = Long.MIN_VALUE

)
