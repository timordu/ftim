package com.dugang.ftim.dispatch

import com.dugang.ftim.response
import com.dugang.ftim.toJson
import com.tencent.imsdk.TIMFriendshipManager
import com.tencent.imsdk.TIMValueCallBack
import com.tencent.imsdk.friendship.TIMFriend
import com.tencent.imsdk.friendship.TIMFriendResult
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * 黑名单的MethodCall
 */
object BlackListMethodCall {
    // 获取黑名单列表
    fun getBlackList(result: MethodChannel.Result) {
        TIMFriendshipManager.getInstance().getBlackList(object : TIMValueCallBack<List<TIMFriend>> {
            override fun onSuccess(p0: List<TIMFriend>?) {
                result.success((p0 ?: mutableListOf()).toJson())
            }

            override fun onError(p0: Int, p1: String?) {
                result.success(mutableListOf<TIMFriend>().toJson())
            }
        })
    }

    // 添加用户到黑名单
    fun addBlackList(call: MethodCall, result: MethodChannel.Result) {
        val identifiers = call.argument<List<String>>("identifiers")!!
        TIMFriendshipManager.getInstance().addBlackList(identifiers, object : TIMValueCallBack<List<TIMFriendResult>> {
            override fun onSuccess(p0: List<TIMFriendResult>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 把用户从黑名单删除
    fun deleteBlackList(call: MethodCall, result: MethodChannel.Result) {
        val identifiers = call.argument<List<String>>("identifiers")!!
        TIMFriendshipManager.getInstance().deleteBlackList(identifiers, object : TIMValueCallBack<List<TIMFriendResult>> {
            override fun onSuccess(p0: List<TIMFriendResult>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }
}