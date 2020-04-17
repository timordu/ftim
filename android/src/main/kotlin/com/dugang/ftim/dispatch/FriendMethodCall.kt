package com.dugang.ftim.dispatch

import com.dugang.ftim.response
import com.dugang.ftim.toJson
import com.tencent.imsdk.TIMCallBack
import com.tencent.imsdk.TIMFriendshipManager
import com.tencent.imsdk.TIMUserProfile
import com.tencent.imsdk.TIMValueCallBack
import com.tencent.imsdk.friendship.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * 好友的MethodCall
 */
object FriendMethodCall {
    // 好友列表
    fun getFriendList(result: MethodChannel.Result) {
        TIMFriendshipManager.getInstance().getFriendList(object : TIMValueCallBack<List<TIMFriend>> {
            override fun onSuccess(p0: List<TIMFriend>?) {
                result.success(p0?.toJson())
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 获取服务端用户的资料
    fun getUsersProfile(call: MethodCall, result: MethodChannel.Result) {
        val list = call.argument<MutableList<String>>("identifiers")!!
        val forceUpdate = call.argument<Boolean>("forceUpdate") ?: false
        TIMFriendshipManager.getInstance().getUsersProfile(list, forceUpdate, object : TIMValueCallBack<List<TIMUserProfile>> {
            override fun onSuccess(p0: List<TIMUserProfile>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }


    // 获取本地缓存中的用户的资料
    fun queryUserProfile(call: MethodCall, result: MethodChannel.Result) {
        val identifier = call.argument<String>("identifier")!!
        val userProfile = TIMFriendshipManager.getInstance().queryUserProfile(identifier)
        result.success(userProfile.toJson())
    }

    // 修改好友
    fun modifyFriend(call: MethodCall, result: MethodChannel.Result) {
        val identifier = call.argument<String>("identifier")!!
        val profileMap = hashMapOf<String, Any>()
        call.argument<String>("remark")?.let {
            profileMap[TIMFriend.TIM_FRIEND_PROFILE_TYPE_KEY_REMARK] = it
        }
        call.argument<List<String>>("groups")?.let {
            profileMap[TIMFriend.TIM_FRIEND_PROFILE_TYPE_KEY_GROUP] = it
        }
        call.argument<MutableMap<String, String>>("customInfo")?.let { map ->
            map.keys.forEach {
                profileMap["${TIMFriend.TIM_FRIEND_PROFILE_TYPE_KEY_CUSTOM_PREFIX}$it"] = map[it]!!
            }
        }
        TIMFriendshipManager.getInstance().modifyFriend(identifier, profileMap, object : TIMCallBack {
            override fun onSuccess() {
                val list = mutableListOf(identifier)
                TIMFriendshipManager.getInstance().getUsersProfile(list, true, object : TIMValueCallBack<List<TIMUserProfile>> {
                    override fun onSuccess(p0: List<TIMUserProfile>?) {
                        result.response(data = p0?.get(0))
                    }

                    override fun onError(p0: Int, p1: String?) {
                        result.response(p0, p1)
                    }
                })
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 添加好友
    fun addFriend(call: MethodCall, result: MethodChannel.Result) {
        val identifier = call.argument<String>("identifier")!!
        val timFriendRequest = TIMFriendRequest(identifier)
        call.argument<String>("remark")?.let {
            timFriendRequest.remark = it
        }
        call.argument<String>("addWording")?.let {
            timFriendRequest.addWording = it
        }
        call.argument<String>("addSource")?.let {
            timFriendRequest.addSource = "AddSource_Type_$it"
        }
        call.argument<String>("friendGroup")?.let {
            timFriendRequest.friendGroup = it
        }
        TIMFriendshipManager.getInstance().addFriend(timFriendRequest, object : TIMValueCallBack<TIMFriendResult> {
            override fun onSuccess(p0: TIMFriendResult?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 删除好友
    fun deleteFriends(call: MethodCall, result: MethodChannel.Result) {
        val identifiers = call.argument<List<String>>("identifiers")!!
        val delFriendType = call.argument<Int>("delFriendType")!!
        TIMFriendshipManager.getInstance().deleteFriends(identifiers, delFriendType, object : TIMValueCallBack<List<TIMFriendResult>> {
            override fun onSuccess(p0: List<TIMFriendResult>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 同意/拒绝好友申请
    fun doResponse(call: MethodCall, result: MethodChannel.Result) {
        val timFriendResponse = TIMFriendResponse().apply {
            identifier = call.argument<String>("identifier")!!
            responseType = call.argument<Int>("responseType")!!
            remark = call.argument<String>("remark") ?: ""
        }
        TIMFriendshipManager.getInstance().doResponse(timFriendResponse, object : TIMValueCallBack<TIMFriendResult> {
            override fun onSuccess(p0: TIMFriendResult?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 校验好友关系
    fun checkFriends(call: MethodCall, result: MethodChannel.Result) {
        val timFriendCheckInfo = TIMFriendCheckInfo().apply {
            users = call.argument<List<String>>("identifiers")!!
            checkType = call.argument<Int>("checkType")!!
        }
        TIMFriendshipManager.getInstance().checkFriends(timFriendCheckInfo, object : TIMValueCallBack<List<TIMCheckFriendResult>> {
            override fun onSuccess(p0: List<TIMCheckFriendResult>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    // 创建好友分组
    fun createFriendGroup(call: MethodCall, result: MethodChannel.Result) {
        val groupNames = call.argument<List<String>>("groupNames")!!
        val identifiers = call.argument<List<String>>("identifiers")!!
        TIMFriendshipManager.getInstance().createFriendGroup(groupNames, identifiers, object : TIMValueCallBack<List<TIMFriendResult>> {
            override fun onSuccess(p0: List<TIMFriendResult>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    //删除好友分组
    fun deleteFriendGroup(call: MethodCall, result: MethodChannel.Result) {
        val groupNames = call.argument<List<String>>("groupNames")!!
        TIMFriendshipManager.getInstance().deleteFriendGroup(groupNames, object : TIMCallBack {
            override fun onSuccess() {
                result.response()
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    //添加好友到某分组
    fun addFriendsToFriendGroup(call: MethodCall, result: MethodChannel.Result) {
        val groupName = call.argument<String>("groupName")!!
        val identifiers = call.argument<List<String>>("identifiers")!!
        TIMFriendshipManager.getInstance().addFriendsToFriendGroup(groupName, identifiers, object : TIMValueCallBack<List<TIMFriendResult>> {
            override fun onSuccess(p0: List<TIMFriendResult>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    //从某分组删除好友
    fun deleteFriendsFromFriendGroup(call: MethodCall, result: MethodChannel.Result) {
        val groupName = call.argument<String>("groupName")!!
        val identifiers = call.argument<List<String>>("identifiers")!!
        TIMFriendshipManager.getInstance().deleteFriendsFromFriendGroup(groupName, identifiers, object : TIMValueCallBack<List<TIMFriendResult>> {
            override fun onSuccess(p0: List<TIMFriendResult>?) {
                result.response(data = p0)
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    //重命名好友分组
    fun renameFriendGroup(call: MethodCall, result: MethodChannel.Result) {
        val oldName = call.argument<String>("oldName")!!
        val newName = call.argument<String>("newName")!!
        TIMFriendshipManager.getInstance().renameFriendGroup(oldName, newName, object : TIMCallBack {
            override fun onSuccess() {
                result.response()
            }

            override fun onError(p0: Int, p1: String?) {
                result.response(p0, p1)
            }
        })
    }

    //获取好友分组
    fun getFriendGroups(call: MethodCall, result: MethodChannel.Result) {
        val groupNames = call.argument<List<String>>("groupNames")
        TIMFriendshipManager.getInstance().getFriendGroups(groupNames, object : TIMValueCallBack<List<TIMFriendGroup>> {
            override fun onSuccess(p0: List<TIMFriendGroup>?) {
                result.success(p0?.toJson())
            }

            override fun onError(p0: Int, p1: String?) {
                result.success(null)
            }
        })
    }
}