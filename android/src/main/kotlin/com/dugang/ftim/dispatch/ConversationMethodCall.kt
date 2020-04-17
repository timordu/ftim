package com.dugang.ftim.dispatch

import android.util.Log
import com.dugang.ftim.response
import com.dugang.ftim.toConversationMap
import com.dugang.ftim.toJson
import com.dugang.ftim.toMessageMap
import com.tencent.imsdk.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * 会话的MethodCall
 */
object ConversationMethodCall {
    //分页条数
    private const val PAGE_SIZE = 10

    //获取会话列表
    fun getConversationList(result: MethodChannel.Result) {
        val list = TIMManager.getInstance().conversationList.map { it.toConversationMap() }.toList()
        result.success((list ?: mutableListOf()).toJson())
    }

    private fun getConversation(call: MethodCall): TIMConversation {
        val type = when (call.argument<String>("type")!!) {
            "C2C" -> TIMConversationType.C2C
            "Group" -> TIMConversationType.Group
            else -> TIMConversationType.Invalid
        }
        val peer = call.argument<String>("peer")!!
        return TIMManager.getInstance().getConversation(type, peer)
    }

    private fun sendMessage(call: MethodCall, result: MethodChannel.Result, message: TIMMessage) {
        getConversation(call).sendMessage(message, object : TIMValueCallBack<TIMMessage> {
            override fun onSuccess(p0: TIMMessage?) {
                result.response()
                Log.d("FtimPlugin", "${p0.toMessageMap().toJson()}")
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
                Log.d("FtimPlugin", "$p0,$p1")
            }
        })
    }

    //获取会话
    fun getConversation(call: MethodCall, result: MethodChannel.Result) {
        result.success(getConversation(call).toConversationMap().toJson())
    }

    //获取会话最近的20条消息
    fun getLocalMessage(call: MethodCall, result: MethodChannel.Result) {
        val conversation = getConversation(call)
        conversation.getLocalMessage(PAGE_SIZE, null, object : TIMValueCallBack<List<TIMMessage>> {
            override fun onSuccess(p0: List<TIMMessage>?) {
                val list = p0?.map { it.toMessageMap() }.toList()
                result.success((list ?: mutableListOf()).toJson())
            }

            override fun onError(p0: Int, p1: String?) {
                result.success(mutableListOf<TIMMessage>().toJson())
            }
        })
    }


    /**
     * 删除会话本地历史消息
     */
    fun deleteLocalMessage() {

    }


    //发送文本消息
    fun sendTextMessage(call: MethodCall, result: MethodChannel.Result) {
        val content = call.argument<String>("content")

        val msg = TIMMessage().apply {
            addElement(TIMTextElem().apply {
                text = content
            })
        }
        sendMessage(call, result, msg)
    }

    // 发送图片消息
    fun sendImageMessage(call: MethodCall, result: MethodChannel.Result) {
        val images = call.argument<List<String>>("images")

        val msg = TIMMessage().apply {
            images?.forEach {
                addElement(TIMImageElem().apply {
                    path = it
                })
            }
        }
        sendMessage(call, result, msg)

    }

}