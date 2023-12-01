package com.tnmeta.torymeta.model


enum class SeminarStatus(val origin: Int) {
    INVALID(-1), ENTER(0), NOT_STARTED(1), FINISHED(2);

    companion object {
        fun intToType(origin: Int): SeminarStatus {
            return values().find { it.origin == origin } ?: INVALID
        }
    }
}