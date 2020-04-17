package com.dugang.ftim.dispatch

import com.dugang.ftim.response
import com.dugang.ftim.toJson
import com.tencent.imsdk.TIMCallBack
import com.tencent.imsdk.TIMFriendshipManager
import com.tencent.imsdk.TIMValueCallBack
import com.tencent.imsdk.friendship.TIMFriendPendencyRequest
import com.tencent.imsdk.friendship.TIMFriendPendencyResponse
import com.tencent.imsdk.friendship.TIMFriendResult
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * 未决的MethodCall
 */
object PendencyMethodCall {
    // 获取未决列表
     fun getPendencyList(call: MethodCall, result: MethodChannel.Result) {
        val pendencyRequest = TIMFriendPendencyRequest()
        call.argument<Int>("seq")?.let {
            pendencyRequest.seq = it.toLong()
        }
        call.argument<Int>("timestamp")?.let {
            pendencyRequest.timestamp = it.toLong()
        }
        call.argument<Int>("numPerPage")?.let {
            pendencyRequest.numPerPage = it
        }
        call.argument<Int>("timPendencyType")?.let {
            pendencyRequest.timPendencyGetType = it
        }
        TIMFriendshipManager.getInstance().getPendencyList(pendencyRequest, object : TIMValueCallBack<TIMFriendPendencyResponse> {
            override fun onSuccess(p0: TIMFriendPendencyResponse?) {
                result.success(p0.toJson())
            }

            override fun onError(p0: Int, p1: String?) {
                result.success(null)
            }
        })
    }


    // 未决删除
     fun deletePendency(call: MethodCall, result: MethodChannel.Result) {
        val pendencyType = call.argument<Int>("pendencyType")!!
        val users = call.argument<List<String>>("users")!!
        TIMFriendshipManager.getInstance().deletePendency(pendencyType, users, object : TIMValueCallBack<List<TIMFriendResult>> {
            override fun onSuccess(p0: List<TIMFriendResult>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 未决已读上报
     fun pendencyReport(call: MethodCall, result: MethodChannel.Result) {
        val timestamp = call.argument<Long>("timestamp")!!
        TIMFriendshipManager.getInstance().pendencyReport(timestamp, object : TIMCallBack {
            override fun onSuccess() {
                result.response()
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

}