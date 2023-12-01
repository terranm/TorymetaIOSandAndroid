package com.tnmeta.torymeta.model


/**
 * BoardType
 */
enum class BoardType(val origin: Int) {
    INVALID(0), TALK(1), GATHER(2), HELP(3), MARKET(4);

    companion object {
        fun intToType(origin: Int): BoardType {
            return values().find { it.origin == origin } ?: INVALID
        }
        fun typeToString(type: BoardType): String {
            return when( type ) {
                TALK-> "community"
                GATHER-> "meeting"
                HELP-> "errand"
                MARKET-> "market"
                else-> ""
            }
        }
    }
}