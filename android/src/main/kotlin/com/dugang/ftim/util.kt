package com.dugang.ftim

import com.google.gson.Gson
import com.tencent.imsdk.*
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.reflect.ParameterizedType
import java.lang.reflect.Type
import kotlin.reflect.full.memberProperties
import kotlin.reflect.jvm.isAccessible


fun Any?.toJson(): String = Gson().toJson(this)

fun <T> String.jsonToObj(clazz: Class<T>): T = Gson().fromJson(this, clazz)

fun <T, E> String.jsonToMap(clazz1: Class<T>, clazz2: Class<E>): Map<T, E> = Gson().fromJson(this, type(Map::class.java, clazz1, clazz2))

fun <T> String.jsonToyList(clazz: Class<T>): List<T> = Gson().fromJson(this, type(List::class.java, clazz))

private fun type(raw: Class<*>, vararg args: Type): ParameterizedType {
    return object : ParameterizedType {
        override fun getRawType(): Type = raw

        override fun getOwnerType(): Type? = null

        override fun getActualTypeArguments(): Array<out Type> = args
    }
}

fun Any.toMap(): MutableMap<String, Any?> {
    val map = mutableMapOf<String, Any?>()
    javaClass.kotlin.memberProperties.forEach {
        it.isAccessible = true
        map[it.name] = it.get(this)
    }
    return map
}

fun Result.response(code: Int = 0, message: String? = null, data: Any? = null) {
    success(mapOf("code" to code, "message" to message, "data" to data?.toJson()))
}

fun EventChannel.EventSink.success(type: String, data: Any) {
    success(mapOf("type" to type, "data" to data.toJson()))
}

fun TIMConversation.toConversationMap(): MutableMap<String, Any?> {
    var faceUrl: String? = null
    var title: String? = null
    if (type == TIMConversationType.C2C) {
        val obj = TIMFriendshipManager.getInstance().queryUserProfile(peer)
        obj.let {
            faceUrl = it.faceUrl
            title = it.nickName
        }
    } else if (type == TIMConversationType.Group) {

    }

    return mutableMapOf(
            "peer" to peer,
            "type" to type,
            "unRead" to unreadMessageNum,
            "lastMsg" to lastMsg.toMessageMap(),
            "faceUrl" to faceUrl,
            "title" to title
    )
}

fun TIMMessage.toMessageMap(): MutableMap<String, Any?> {
    return mutableMapOf(
            "peer" to conversation.peer,
            "type" to conversation.type,
            "msgId" to msgId,
            "msgUniqueId" to msgUniqueId,
            "sender" to sender.let { TIMFriendshipManager.getInstance().queryUserProfile(it).toMap() },
            "isSelf" to (sender == TIMManager.getInstance().loginUser),
            "msgTime" to timestamp(),
            "isPeerReaded" to isPeerReaded,
            "element" to getElement(0).toElemMap()
    )
}

fun TIMElem.toElemMap(): MutableMap<String, Any?> {
    return when (type) {
        TIMElemType.Text -> (this as TIMTextElem).toMap()
        TIMElemType.Image -> (this as TIMImageElem).toMap()
        TIMElemType.Sound -> (this as TIMSoundElem).toMap()
        TIMElemType.Custom -> (this as TIMCustomElem).toMap()
        TIMElemType.File -> (this as TIMFileElem).toMap()
        TIMElemType.GroupTips -> (this as TIMGroupTipsElem).toMap()
        TIMElemType.Face -> (this as TIMFaceElem).toMap()
        TIMElemType.Location -> (this as TIMLocationElem).toMap()
        TIMElemType.GroupSystem -> (this as TIMGroupSystemElem).toMap()
        TIMElemType.Video -> (this as TIMVideoElem).toMap()
        TIMElemType.SNSTips -> (this as TIMSNSSystemElem).toMap()
        TIMElemType.ProfileTips -> (this as TIMProfileSystemElem).toMap()
        else -> this.toMap()
    }
}
