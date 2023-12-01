package com.tnmeta.torymeta.utils

import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import org.json.JSONTokener
import java.util.*

object SBJSON {
    @JvmStatic
    fun getStringValue(map: Map<String, Any>, key: String, defaultValue: String = ""): String {

        if( map.containsKey(key) && map[key] is String ) {
            val value = map[key] as String
            if( value != null ) {
                return value
            }
        }

        return defaultValue
    }

    @JvmStatic
    fun parse(jsonString: String?): Any? {
        try {
            val json = JSONTokener(jsonString).nextValue()
            return parse(json)
        } catch(e: JSONException) {
            e.printStackTrace()
        }
        return null
    }

    @JvmStatic
    fun parse(json: Any?): Any? {
        try {
            // json object
            if( json is JSONObject ) {
                val map: MutableMap<String, Any?> = HashMap()
                val keyList = json.keys()

                while( keyList.hasNext() ) {
                    val key = keyList.next()
                    var value: Any? = null

                    if( !json.isNull(key) ) {
                        value = json[key]
                    }

                    if( value is JSONObject ||
                        value is JSONArray ) {
                        value = parse(value)
                    }

                    map[key] = value
                }

                return map
            }
            // json array
            else if( json is JSONArray ) {
                val list = ArrayList<Any?>()

                for( i in 0 until json.length() ) {
                    var value: Any? = json[i]

                    /*
                    var value: Any? = null

                    if( !json.isNull(i) ) {
                        value = json[i]
                    }
                     */

                    if( value is JSONObject ||
                        value is JSONArray) {
                        value = parse(value)
                    }

                    list.add(value)
                }

                return list
            }
        } catch(e: JSONException) {
            e.printStackTrace()
        }

        return json
    }

    @JvmStatic
    fun toJSONString(obj: Any?): String {
        return toJSONValue(obj).toString()
    }

    @JvmStatic
    fun toJSONValue(obj: Any?): Any? {

        if( obj is ArrayList<*> ) {
            val jsonArray = JSONArray()

            for( v in obj ) {
                jsonArray.put(toJSONValue(v))
            }

            return jsonArray
        }

        if( obj is Map<*, *> ) {
            val jsonObject = JSONObject()
            val keyList = obj.keys.iterator()

            while( keyList.hasNext() ) {
                val key: String = keyList.next() as String;
                val v = toJSONValue(obj[key])

                try {
                    jsonObject.put(key, v)
                } catch (e: JSONException) {}
            }

            return jsonObject
        }

        return obj
    }
}