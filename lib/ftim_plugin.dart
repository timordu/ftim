import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ftim/bean/bean.dart';

typedef Callback<T>(bool success, String message, T data);

class Ftim {
  Ftim._();

  static Ftim instance;

  static Ftim get() {
    if (instance == null) instance = Ftim._();
    return instance;
  }

  final MethodChannel _channel = const MethodChannel('ftim/method');

  void _handlerResult<T>(result, {Callback<T> callback}) {
    bool success = result['code'] == 0;
    String message = result['message'];
    var data = result['data'];
    if (data != null) {
      print(callback.runtimeType);
      switch (callback.runtimeType.toString()) {
        case '(bool, String, TimUserProfile) => Null':
          data = TimUserProfile.fromJson(json.decode(data));
          break;
        case '(bool, String, List<TimUserProfile>) => Null':
          data = getTimUserProfileList(json.decode(data));
          break;
        case '(bool, String, TimFriendResult) => Null':
          data = TimFriendResult.fromJson(json.decode(data));
          break;
        case '(bool, String, List<TimFriendResult>) => Null':
          data = getTimFriendResultList(json.decode(data));
          break;
        case '(bool, String, List<TimCheckFriend>) => Null':
          data = getTimCheckFriendList(json.decode(data));
          break;
      }
    }
    if (callback != null) callback(success, message, data);
  }

  /// 初始化
  ///
  /// @param sdkAppId
  void init(int sdkAppId) async {
    await _channel.invokeMethod('init', <String, dynamic>{
      'sdkAppId': sdkAppId,
    });
  }

  /// 登录
  ///
  /// @param identifier 用户名
  void login(String identifier, String userSig, {Callback<TimUserProfile> callback}) async {
    var result = await _channel.invokeMethod('login', <String, dynamic>{
      'identifier': identifier,
      'userSig': userSig,
    });
    _handlerResult(result, callback: callback);
  }

  /// 初始化本地存储
  ///
  /// @param identifier 用户名
  void initStorage(String identifier) async {
    await _channel.invokeMethod('initStorage', <String, dynamic>{
      'identifier': identifier,
    });
  }

  /// 登出
  void logout({Callback<TimUserProfile> callback}) async {
    var result = await _channel.invokeMethod('logout', <String, dynamic>{});
    _handlerResult(result, callback: callback);
  }

  /// 服务器端获取自己的资料
  void getSelfProfile({Callback<TimUserProfile> callback}) async {
    var result = await _channel.invokeMethod('getSelfProfile', <String, dynamic>{});
    _handlerResult(result, callback: callback);
  }

  /// 从缓存获取用户自己的资料
  Future<TimUserProfile> querySelfProfile() async {
    var result = await _channel.invokeMethod('querySelfProfile', <String, dynamic>{});
    return result == null ? null : TimUserProfile.fromJson(json.decode(result));
  }

  /// 服务器端获取用户的资料
  ///
  /// @param identifiers 要获取资料的用户列表
  ///
  /// @param forceUpdate true-强制从后台拉取数据，并把返回的数据缓存 false-先在本地查找，如果本地没有数据则再向后台请求数据
  void getUsersProfile(List<String> identifiers, {bool forceUpdate = false, Callback<List<TimUserProfile>> callback}) async {
    var result = await _channel.invokeMethod('getUsersProfile', <String, dynamic>{
      'identifiers': identifiers,
      'forceUpdate': forceUpdate,
    });
    _handlerResult(result, callback: callback);
  }

  /// 从缓存获取用户的资料
  ///
  /// @param identifier 要获取用户资料的identifier
  Future<TimUserProfile> queryUserProfile(String identifier) async {
    var result = await _channel.invokeMethod('queryUserProfile', <String, dynamic>{
      'identifier': identifier,
    });
    return result == null ? null : TimUserProfile.fromJson(json.decode(result));
  }

  /// 修改自己的资料
  ///
  /// @param userProfile 用户资料
  void modifySelfProfile(TimUserProfile userProfile, {Callback<TimUserProfile> callback}) async {
    var result = await _channel.invokeMethod('modifySelfProfile', userProfile.toJson());
    _handlerResult(result, callback: callback);
  }

  /// 获取好友列表
  Future<List<TimFriend>> getFriendList() async {
    var result = await _channel.invokeMethod('getFriendList', <String, dynamic>{});
    return result == null ? null : getTimFriendList(json.decode(result));
  }

  /// 修改好友资料
  ///
  /// @param identifier 用户id
  ///
  /// @param remark 备注
  ///
  /// @param groups 分组名
  ///
  /// @param customInfo 自定义信息
  void modifyFriend(
    String identifier, {
    String remark,
    List<String> groups,
    Map<String, String> customInfo,
    Callback<TimUserProfile> callback,
  }) async {
    var result = await _channel.invokeMethod('modifyFriend', <String, dynamic>{
      'identifier': identifier,
      'remark': remark,
      'groups': groups,
      'customInfo': customInfo,
    });
    _handlerResult(result, callback: callback);
  }

  /// 添加好友
  ///
  /// @param identifier 用户identifier
  ///
  /// @param remark 备注(最大96字节)
  ///
  /// @param addWording 请求说明(最大120字节)
  ///
  /// @param addSource 添加来源,8个字节
  ///
  /// @param friendGroup 分组名
  void addFriend(
    String identifier, {
    String remark,
    String addWording,
    String addSource,
    String friendGroup,
    Callback<TimFriendResult> callback,
  }) async {
    var result = await _channel.invokeMethod('addFriend', <String, dynamic>{
      'identifier': identifier,
      'remark': remark,
      'addWording': addWording,
      'addSource': addSource,
      'friendGroup': friendGroup,
    });
    _handlerResult(result, callback: callback);
  }

  /// 删除好友
  ///
  /// @param identifiers 好友列表
  ///
  /// @param delFriendType 1-单向删除 2-双向删除
  void deleteFriends(List<String> identifiers, int delFriendType, {Callback<List<TimFriendResult>> callback}) async {
    var result = await _channel.invokeMethod('deleteFriends', <String, dynamic>{
      'identifiers': identifiers,
      'delFriendType': delFriendType,
    });
    _handlerResult(result, callback: callback);
  }

  /// 同意/拒绝好友申请
  ///
  /// @param identifier
  ///
  /// @param responseType 0-同意加好友 1-同意并加对方好友 2-拒绝好友请求
  ///
  /// @param remark 备注
  void doResponse(String identifier, int responseType, {String remark, Callback<TimFriendResult> callback}) async {
    var result = await _channel.invokeMethod('doResponse', <String, dynamic>{
      'identifier': identifier,
      'responseType': responseType,
      'remark': remark,
    });
    _handlerResult(result, callback: callback);
  }

  /// 校验好友关系
  ///
  /// @param identifiers
  ///
  /// @param checkType 1-单向好友 2-双向好友
  void checkFriends(List<String> identifiers, {int checkType = 2, Callback<List<TimCheckFriend>> callback}) async {
    var result = await _channel.invokeMethod('checkFriends', <String, dynamic>{
      'identifiers': identifiers,
      'checkType': checkType,
    });
    _handlerResult(result, callback: callback);
  }

  /// 获取未决列表
  ///
  /// @param seq 未决列表序列号
  ///
  /// @param timestamp 翻页时间戳
  ///
  /// @param numPerPage 每页的数量,默认20
  ///
  /// @param timPendencyType 未决请求拉取类型 ,默认1
  ///
  /// * 1-别人发给我的未决请求
  /// * 2-我发给别人的未决请求
  /// * 3-别人发给我的以及我发给别人的所有未决请求，仅在拉取时有效
  Future<TimFriendPendencyResponse> getPendencyList({int seq, int timestamp, int numPerPage = 20, int timPendencyType = 1}) async {
    var result = await _channel.invokeMethod('getPendencyList', <String, dynamic>{
      'seq': seq,
      'timestamp': timestamp,
      'numPerPage': numPerPage,
      'timPendencyType': timPendencyType,
    });
    return result == null ? null : TimFriendPendencyResponse.fromJson(json.decode(result));
  }

  /// 未决删除
  ///
  /// @param users 要删除的未决用户 ID 列表
  ///
  /// @param pendencyType 未决类型,参见[ getPendencyList() ]中的[timPendencyType]定义,默认1
  void deletePendency(List<String> users, {int pendencyType = 1, Callback<List<TimFriendResult>> callback}) async {
    var result = await _channel.invokeMethod('deletePendency', <String, dynamic>{
      'pendencyType': pendencyType,
      'users': users,
    });
    _handlerResult(result, callback: callback);
  }

  /// 未决已读上报
  ///
  /// @param timestamp 已读时间戳
  void pendencyReport(int timestamp, {Callback callback}) async {
    var result = await _channel.invokeMethod('pendencyReport', <String, dynamic>{
      'timestamp': timestamp,
    });
    _handlerResult(result, callback: callback);
  }

  /// 获取黑名单列表
  Future<List<TimFriend>> getBlackList() async {
    var result = await _channel.invokeMethod('getBlackList', <String, dynamic>{});
    return result == null ? null : getTimFriendList(json.decode(result));
  }

  /// 添加用户到黑名单
  ///
  /// @param identifiers
  void addBlackList(List<String> identifiers, {Callback<List<TimFriendResult>> callback}) async {
    var result = await _channel.invokeMethod('addBlackList', <String, dynamic>{
      'identifiers': identifiers,
    });
    _handlerResult(result, callback: callback);
  }

  /// 把用户从黑名单删除
  ///
  /// @param identifiers
  void deleteBlackList(List<String> identifiers, {Callback<List<TimFriendResult>> callback}) async {
    var result = await _channel.invokeMethod('deleteBlackList', <String, dynamic>{
      'identifiers': identifiers,
    });
    _handlerResult(result, callback: callback);
  }

  ///创建好友分组
  ///
  ///@param groupNames
  ///
  ///@param identifiers
  void createFriendGroup(List<String> groupNames, List<String> identifiers, {Callback<List<TimFriendResult>> callback}) async {
    var result = await _channel.invokeMethod('createFriendGroup', <String, dynamic>{
      'groupNames': groupNames,
      'identifiers': identifiers,
    });
    _handlerResult(result, callback: callback);
  }

  /// 删除好友分组
  ///
  /// @param groupNames
  void deleteFriendGroup(String groupName, {Callback callback}) async {
    var result = await _channel.invokeMethod('deleteFriendGroup', <String, dynamic>{
      'groupName': groupName,
    });
    _handlerResult(result, callback: callback);
  }

  /// 添加好友到某分组
  ///
  /// @param groupName
  ///
  /// @param identifiers
  void addFriendsToFriendGroup(String groupName, List<String> identifiers, {Callback<List<TimFriendResult>> callback}) async {
    var result = await _channel.invokeMethod('addFriendsToFriendGroup', <String, dynamic>{
      'groupName': groupName,
      'identifiers': identifiers,
    });
    _handlerResult(result, callback: callback);
  }

  /// 从某分组删除好友
  ///
  /// @param groupName
  ///
  /// @param identifiers
  void deleteFriendsFromFriendGroup(String groupName, List<String> identifiers, {Callback<List<TimFriendResult>> callback}) async {
    var result = await _channel.invokeMethod('deleteFriendsFromFriendGroup', <String, dynamic>{
      'groupName': groupName,
      'identifiers': identifiers,
    });
    _handlerResult(result, callback: callback);
  }

  ///重命名好友分组
  ///
  /// @param oldName
  ///
  /// @param newName
  void renameFriendGroup(String oldName, String newName, {Callback callback}) async {
    var result = await _channel.invokeMethod('renameFriendGroup', <String, dynamic>{
      'oldName': oldName,
      'newName': newName,
    });
    _handlerResult(result, callback: callback);
  }

  ///获取好友分组
  Future<List<TimFriendGroup>> getFriendGroups() async {
    var result = await _channel.invokeMethod('getFriendGroups', <String, dynamic>{});
    return result == null ? null : getTimFriendGroupList(json.decode(result));
  }

  ///获取会话列表
  Future<List<TimConversation>> getConversationList() async {
    var result = await _channel.invokeMethod('getConversationList', <String, dynamic>{});
    return getTimConversationList(json.decode(result));
  }

  ///获取会话
  ///
  ///@param type [TimConversation.TYPE_C2C],[TimConversation.TYPE_GROUP]
  ///
  ///@param peer
  Future<TimConversation> getConversation(String peer, {String type = TimConversation.TYPE_C2C}) async {
    var result = await _channel.invokeMethod('getConversation', <String, dynamic>{
      'type': type,
      'peer': peer,
    });
    return TimConversation.fromJson(json.decode(result));
  }

  ///获取会话本地历史消息
  ///
  ///@param type 会话类型 [TimConversation.TYPE_C2C],[TimConversation.TYPE_GROUP]
  ///
  ///@param peer
  Future<List<TimMessage>> getLocalMessage(String peer, String type) async {
    var result = await _channel.invokeMethod('getLocalMessage', <String, dynamic>{
      'type': type,
      'peer': peer,
    });
    return getTimMessageList(json.decode(result));
  }

  ///发送文本消息
  ///
  ///@param type 会话类型 [TimConversation.TYPE_C2C],[TimConversation.TYPE_GROUP]
  ///
  ///@param peer
  void sendTextMessage(String content, String peer, String type) async {
    await _channel.invokeMethod('sendTextMessage', <String, dynamic>{
      'content': content,
      'peer': peer,
      'type': type,
    });
  }

  ///发送图片
  ///
  ///@param images 图片的路径
  ///
  ///@param type 会话类型 [TimConversation.TYPE_C2C],[TimConversation.TYPE_GROUP]
  ///
  ///@param peer
  void sendImageMessage(List<String> images, String peer, String type) async {
    await _channel.invokeMethod('sendImageMessage', <String, dynamic>{
      'images': images,
      'peer': peer,
      'type': type,
    });
  }
}
