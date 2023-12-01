package com.tnmeta.torymeta.model


enum class UpdateType(val origin: Int) {
    INVALID(-1), NONE(0), UPDATE_OPTIONAL(1), UPDATE(2);

    companion object {
        fun intToType(origin: Int): UpdateType {
            return values().find { it.origin == origin } ?: INVALID
        }
    }
}
