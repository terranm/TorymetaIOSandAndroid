package com.tnmeta.torymeta.model

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.JsonObject
import com.google.gson.JsonParser

class BaseParam(param: Any) {
    val parameter : JsonObject = JsonParser.parseString(Gson().toJson(param)).asJsonObject
}
