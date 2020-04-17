package com.dugang.ftim.dispatch

import com.dugang.ftim.response
import com.tencent.imsdk.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * 登录用户的MethodCall
 */
object SelfMethodCall {
    // 登录
    fun login(call: MethodCall, result: MethodChannel.Result) {
        val identifier = call.argument<String>("identifier")!!
        val userSig = call.argument<String>("userSig")!!

        TIMManager.getInstance().login(identifier, userSig, object : TIMCallBack {
            override fun onSuccess() {
                getSelfProfile(result)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 登出
    fun logout(result: MethodChannel.Result) {
        TIMManager.getInstance().logout(object : TIMCallBack {
            override fun onSuccess() {
                result.response()
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 获取服务端自己的资料
    fun getSelfProfile(result: MethodChannel.Result) {
        TIMFriendshipManager.getInstance().getSelfProfile(object : TIMValueCallBack<TIMUserProfile> {
            override fun onSuccess(p0: TIMUserProfile?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 获取本地缓存中自己的资料
    fun querySelfProfile(result: MethodChannel.Result) {
        val userProfile = TIMFriendshipManager.getInstance().querySelfProfile()
        result.success(userProfile)
    }

    // 修改自己的资料
    fun modifySelfProfile(call: MethodCall, result: MethodChannel.Result) {
        val profileMap = hashMapOf<String, Any>()
        call.argument<String>("nickName")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_NICK] = it
        }
        call.argument<String>("faceUrl")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_FACEURL] = it
        }
        call.argument<String>("allowType")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_ALLOWTYPE] = it
        }
        call.argument<Int>("gender")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_GENDER] = it
        }
        call.argument<Int>("birthday")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_BIRTHDAY] = it
        }
        call.argument<String>("location")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_LOCATION] = it
        }
        call.argument<String>("language")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_LANGUAGE] = it
        }
        call.argument<String>("level")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_LEVEL] = it
        }
        call.argument<String>("role")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_ROLE] = it
        }
        call.argument<String>("selfSignature")?.let {
            profileMap[TIMUserProfile.TIM_PROFILE_TYPE_KEY_SELFSIGNATURE] = it
        }
        call.argument<MutableMap<String, String>>("customInfo")?.let { map ->
            map.keys.forEach {
                profileMap["${TIMUserProfile.TIM_PROFILE_TYPE_KEY_NICK}$it"] = map[it]!!
            }
        }
        TIMFriendshipManager.getInstance().modifySelfProfile(profileMap, object : TIMCallBack {
            override fun onSuccess() {
                getSelfProfile(result)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }
}