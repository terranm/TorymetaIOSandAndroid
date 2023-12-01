package com.tnmeta.torymeta.database.step

import com.tnmeta.torymeta.utils.DateUtil
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import timber.log.Timber
import javax.inject.Inject
import kotlin.math.max

class StepsRepository constructor(db: PedometerDatabase) {

    private val dailyStepsDao = db.dailyStepsDao()

    fun getAll(): List<DailySteps> {
        return dailyStepsDao.getAll()
    }

    fun getStepsToday(): Long {
        val today = DateUtil.getToday()
        return getSteps(today)
    }

    fun getStepsToday(viewIndex: Int): Long {
        val today = DateUtil.getToday()
        return if(viewIndex == 0) {
            getInSteps(today)
        }else {
            getOutSteps(today)
        }
    }

    fun getStepsTodayFlow(): Flow<Long> {
        val today = DateUtil.getToday()
        return getStepsFlow(today)
    }


    fun getRecord(): DailySteps {
        return dailyStepsDao.getRecord()
    }


    fun getLastEntries(num: Int): List<DailySteps> {
        return dailyStepsDao.getLastEntries(num)
    }

    fun getStepsFromDayRange(start: Long, end: Long): Long {
        return dailyStepsDao.getStepsFromDayRange(start, end) ?: 0L
    }

    suspend fun getTotalDays(): Long {
        return dailyStepsDao.getTotalDays()
    }

    /**
     * This method is probably the most important one here, its function is to update the stored
     * copy of steps since boot AND do some calculations to update today's steps count. If there is
     * no entry for today in the daily_steps db table, it means that it is a new day already, so
     * this method also creates a new entry with zero steps.
     *
     * @param stepsSinceBoot  the steps sensor steps since boot count.
     *
     * @return the updated steps for today
     */
    fun updateStepsSinceBoot(stepsSinceBoot: Long): Long {
        val today = DateUtil.getToday()
        val todaySteps = dailyStepsDao.getSteps(today)
        val storedStepsSinceBoot = getStepsSinceBoot()

        // Make sure stepsDiff is at least 0. The only time when stepsSinceBoot could be less than
        // storedStepsSinceBoot is when the device reboots.
        val stepsDiff = max(stepsSinceBoot - storedStepsSinceBoot, 0L)

        if (todaySteps == null) {
            // This is a new day, update last day and insert a new one
            addToLastEntry(stepsDiff)
            insertTodayEntry(today)
        } else {
            // Still same day, just add the steps diff
            addToLastEntry(stepsDiff)
        }

        // Update copy of steps since boot in db
        val newStepsSinceBoot = DailySteps(day = -1, steps = stepsSinceBoot, insteps = stepsSinceBoot, outsteps = stepsSinceBoot)
        dailyStepsDao.insert(newStepsSinceBoot)

        return getSteps(today)
    }


    fun updateStepsSinceBoot(stepsSinceBoot: Long, isLocation : Int, viewIndex : Int): Long {
        val today = DateUtil.getToday()

        val todaySteps = if(isLocation == 1) {
            dailyStepsDao.getInSteps(today)
        }else {
            dailyStepsDao.getOutSteps(today)
        }

        val storedStepsSinceBoot = getStepsSinceBoot(isLocation)
        val stepsDiff = max(stepsSinceBoot - storedStepsSinceBoot, 0L)

        if (todaySteps == null) {
            addToLastEntry(stepsDiff, isLocation)
            insertTodayEntry(today)
        } else {
            addToLastEntry(stepsDiff, isLocation)
        }

        val newStepsSinceBoot =  if(isLocation == 0) {
            DailySteps(day = -1, steps =  stepsSinceBoot, outsteps = stepsSinceBoot)
        }else {
            DailySteps(day = -1, steps =  stepsSinceBoot, insteps = stepsSinceBoot)
        }

        dailyStepsDao.insert(newStepsSinceBoot)

        return if(viewIndex == 0) {
            getInSteps(today)
        }else {
            getOutSteps(today)
        }
    }

    fun getUpdateStepInfo(viewIndex: Int) : Long {
        val today = DateUtil.getToday()
        return if(viewIndex == 0) {
            getInSteps(today)
        }else {
            getOutSteps(today)
        }
    }


    /**
     * Inserts a new entry in the database, overwriting any existing entry for the given date.
     * Use this method for restoring data from a backup.
     *
     * @param day   the Epoc Day, where day 0 is 1970-01-01
     * @param steps the step value for 'day'; must be >= 0
     * @return true if a new entry was created, false if there was already an
     * entry for 'day' (and it was overwritten)
     */
    fun insertDayFromBackup(day: Long, steps: Long): Boolean {
        val dailySteps = DailySteps(day = day, steps = steps)
        val updatedRows = dailyStepsDao.update(dailySteps)
        if (updatedRows == 0) {
            dailyStepsDao.insert(dailySteps)
            return true
        }
        return false
    }


    /**
     * Returns the steps taken on the given day, or 0 if day doesn't exist in the database.
     */
    private fun getSteps(day: Long): Long {
        return dailyStepsDao.getSteps(day) ?: 0
    }

    private fun getInSteps(day: Long): Long {
        return dailyStepsDao.getInSteps(day) ?: 0
    }

    private fun getOutSteps(day: Long): Long {
        return dailyStepsDao.getOutSteps(day) ?: 0
    }

    private fun getStepsFlow(day: Long): Flow<Long> {
        return dailyStepsDao.getStepsFlow(day).map { it ?: 0 }
    }


    private fun getStepsSinceBoot(): Long {
        return getSteps(-1)
    }

    private fun getStepsSinceBoot(isLocation: Int): Long {
        return if(isLocation == 1) {
            getInSteps(-1)
        }else {
            getOutSteps( -1)
        }
    }

    private fun addToLastEntry(steps: Long) {
        dailyStepsDao.addToLastEntry(steps)
    }


    private fun addToLastEntry(steps: Long, isLocation : Int) {
        if(isLocation == 1) {
            dailyStepsDao.addToLastEntryInStep(steps)
        }else {
            dailyStepsDao.addToLastEntryOutStep(steps)
        }
    }

    /**
     * Inserts a new entry in the db for today, initializing it with zero steps.
     *
     * @param today  the Epoc Day, where day 0 is 1970-01-01
     */
    private fun insertTodayEntry(today: Long) {
        if (dailyStepsDao.getSteps(today) == null) {
            val todaySteps = DailySteps(day = today, steps = 0, insteps = 0, outsteps = 0)
            dailyStepsDao.insert(todaySteps)
        }
    }

}
