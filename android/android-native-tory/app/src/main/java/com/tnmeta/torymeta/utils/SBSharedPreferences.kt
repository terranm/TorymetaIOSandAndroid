package com.tnmeta.torymeta.utils

import android.content.Context
import android.content.SharedPreferences

class SBSharedPreferences(context: Context) {

    private val prefsFileName = "prefs"
    private val prefs: SharedPreferences = context.getSharedPreferences(prefsFileName, 0)

    fun getInt(key: String, defValue: Int=0): Int {
        return prefs.getInt(key, defValue)
    }

    fun setInt(key: String, value: Int) {
        prefs.edit().putInt(key, value).apply()
    }

    fun getLong(key: String, defValue: Long=0): Long {
        return prefs.getLong(key, defValue)
    }

    fun setLong(key: String, value: Long) {
        prefs.edit().putLong(key, value).apply()
    }

    fun getFloat(key: String, defValue: Float=0f): Float {
        return prefs.getFloat(key, defValue)
    }

    fun setFloat(key: String, value: Float) {
        prefs.edit().putFloat(key, value).apply()
    }

    fun getString(key: String, defValue: String=""): String {
        return prefs.getString(key, defValue)!!
    }

    fun setString(key: String, value: String) {
        prefs.edit().putString(key, value).apply()
    }

    fun getBoolean(key: String, defValue: Boolean=false): Boolean {
        return prefs.getBoolean(key, defValue)
    }

    fun setBoolean(key: String, value: Boolean) {
        prefs.edit().putBoolean(key, value).apply()
    }
}