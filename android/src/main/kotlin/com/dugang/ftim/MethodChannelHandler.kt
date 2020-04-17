package com.dugang.ftim

import android.content.Context
import android.util.Log
import com.dugang.ftim.dispatch.*
import com.tencent.imsdk.*
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MethodChannelHandler(private val context: Context, binaryMessenger: BinaryMessenger) : MethodChannel.MethodCallHandler {
    companion object {
        const val TAG = "FtimPlugin"
        const val METHOD_CHANNEL = "ftim/method"
        const val EVENT_CHANNEL = "ftim/event"
    }

    private var eventSink: EventChannel.EventSink? = null

    init {
        MethodChannel(binaryMessenger, METHOD_CHANNEL).setMethodCallHandler(this)
        EventChannel(binaryMessenger, EVENT_CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
                eventSink = p1
            }

            override fun onCancel(p0: Any?) {

            }
        })
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG, "onMethodCall@${call.method}, arguments@${call.arguments.toJson()}")
        when (call.method) {
            "init" -> init(call)
            "initStorage" -> initStorage(call, result)

            //登录用户的相关操作
            "login" -> SelfMethodCall.login(call, result)
            "logout" -> SelfMethodCall.logout(result)
            "getSelfProfile" -> SelfMethodCall.getSelfProfile(result)
            "querySelfProfile" -> SelfMethodCall.querySelfProfile(result)
            "modifySelfProfile" -> SelfMethodCall.modifySelfProfile(call, result)

            //好友的相关操作
            "getFriendList" -> FriendMethodCall.getFriendList(result)
            "getUsersProfile" -> FriendMethodCall.getUsersProfile(call, result)
            "queryUserProfile" -> FriendMethodCall.queryUserProfile(call, result)
            "modifyFriend" -> FriendMethodCall.modifyFriend(call, result)
            "addFriend" -> FriendMethodCall.addFriend(call, result)
            "doResponse" -> FriendMethodCall.doResponse(call, result)
            "deleteFriends" -> FriendMethodCall.deleteFriends(call, result)
            "checkFriends" -> FriendMethodCall.checkFriends(call, result)
            "createFriendGroup" -> FriendMethodCall.createFriendGroup(call, result)
            "deleteFriendGroup" -> FriendMethodCall.deleteFriendGroup(call, result)
            "addFriendsToFriendGroup" -> FriendMethodCall.addFriendsToFriendGroup(call, result)
            "deleteFriendsFromFriendGroup" -> FriendMethodCall.deleteFriendsFromFriendGroup(call, result)
            "renameFriendGroup" -> FriendMethodCall.renameFriendGroup(call, result)
            "getFriendGroups" -> FriendMethodCall.getFriendGroups(call, result)

            //未决
            "getPendencyList" -> PendencyMethodCall.getPendencyList(call, result)
            "deletePendency" -> PendencyMethodCall.deletePendency(call, result)
            "pendencyReport" -> PendencyMethodCall.pendencyReport(call, result)

            //黑名单
            "getBlackList" -> BlackListMethodCall.getBlackList(result)
            "addBlackList" -> BlackListMethodCall.addBlackList(call, result)
            "deleteBlackList" -> BlackListMethodCall.deleteBlackList(call, result)

            //会话
            "getConversationList" -> ConversationMethodCall.getConversationList(result)
            "getConversation" -> ConversationMethodCall.getConversation(call, result)
            "getLocalMessage" -> ConversationMethodCall.getLocalMessage(call, result)

            "sendTextMessage" -> ConversationMethodCall.sendTextMessage(call, result)
            "sendImageMessage" -> ConversationMethodCall.sendImageMessage(call, result)

            else -> result.notImplemented()
        }
    }

    //初始化
    private fun init(call: MethodCall) {
        val sdkAppId = call.argument<Int>("sdkAppId")!!

        // sdk初始化及日志配置
        TIMManager.getInstance().init(context, TIMSdkConfig(sdkAppId)
                // 设置打印日志级别
                .setLogLevel(TIMLogLevel.DEBUG)
                // 是否在控制台打印日志
                .enableLogPrint(false)
                // 日志回调
                .setLogListener { level, tag, message ->
                    when (level) {
                        TIMLogLevel.VERBOSE -> Log.v(tag, message)
                        TIMLogLevel.INFO -> Log.i(tag, message)
                        TIMLogLevel.DEBUG -> Log.d(tag, message)
                        TIMLogLevel.WARN -> Log.w(tag, message)
                        TIMLogLevel.ERROR -> Log.e(tag, message)
                    }
                })
        // 用户配置
        TIMManager.getInstance().userConfig = TIMUserConfig()
                //开启消息已读回执
                .enableReadReceipt(true)
                .setUserStatusListener(object : TIMUserStatusListener {
                    // 用户签名过期,需要重新初始化
                    override fun onUserSigExpired() {
                        Log.d(TAG, "TIMUserStatusListener：onUserSigExpired")
                    }

                    // 被强制离线
                    override fun onForceOffline() {
                        Log.d(TAG, "TIMUserStatusListener：onForceOffline")
                    }
                })
                .setConnectionListener(object : TIMConnListener {
                    override fun onConnected() {
                        Log.d(TAG, "TIMConnListener：onConnected")
                    }

                    override fun onWifiNeedAuth(p0: String?) {
                        Log.d(TAG, "TIMConnListener：onWifiNeedAuth")
                    }

                    override fun onDisconnected(p0: Int, p1: String?) {
                        Log.d(TAG, "TIMConnListener：onDisconnected")
                    }
                })
                .setRefreshListener(object : TIMRefreshListener {
                    override fun onRefreshConversation(p0: MutableList<TIMConversation>?) {
//                        val list = mutableListOf<MutableMap<String, Any?>>()
//                        p0?.forEach {
//                            list.add(it.toConversationMap())
//                        }
//                        eventSink?.success(list.toJson())
//                        Log.d(TAG, "TIMRefreshListener：${list.toJson()}")
                        Log.d(TAG, "TIMRefreshListener：onRefreshConversation")
                    }

                    override fun onRefresh() {
                        Log.d(TAG, "TIMRefreshListener：onRefresh")
                    }
                })
                .setMessageRevokedListener {
                    Log.d(TAG, "TIMMessageRevokedListener：${it.toJson()}")
                }

        // 消息监听
        TIMManager.getInstance().addMessageListener {
            it.forEach { msg ->
                when (msg.conversation.type) {
                    TIMConversationType.System -> eventSink?.success("System", msg.getElement(0).toElemMap())
                    TIMConversationType.C2C -> eventSink?.success("C2C", msg.toMessageMap())
                    TIMConversationType.Group -> eventSink?.success("Group", msg.toMessageMap())
                    else -> eventSink?.success("Invalid", mutableMapOf())
                }
            }
            return@addMessageListener false
        }
    }

    //初始化本地存储
    private fun initStorage(call: MethodCall, result: MethodChannel.Result) {
        val identifier = call.argument<String>("identifier")!!

        TIMManager.getInstance().initStorage(identifier, object : TIMCallBack {
            override fun onSuccess() {
                result.response()
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }


}