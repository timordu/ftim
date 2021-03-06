import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ftim/bean/bean.dart';

/// 用以接收Native端主动发送的数据
///
abstract class FtimEventProvider extends ChangeNotifier {
  final EventChannel _event = EventChannel('ftim/event');

  FtimEventProvider() {
    _event.receiveBroadcastStream().listen(_onEvent);
  }

  void _onEvent(Object obj) {
    var msgMap = obj as Map;
    var msgType = msgMap['type'];
    var msgData = jsonDecode(msgMap['data']);

    switch (msgType) {
      case 'refresh_conversation':
        onRefreshConversation(getTimConversationList(msgData));
        break;
      case 'Message':
        timNewMessage(TimMessage.fromJson(msgData));
        break;
      case 'C2C':
      case 'Group':
        break;
      case 'System':
        _handlerSystemMessage(jsonDecode(msgMap['data']));
        break;
      default:
    }
  }

  /// 处理系统消息
  void _handlerSystemMessage(Map data) {
    switch (data['type']) {
      case 'SNSTips':
        TimSystemMessage msg = TimSystemMessage.fromJson(data);
        switch (msg.subType) {
          case TimSystemMessage.TIM_SNS_SYSTEM_ADD_FRIEND:
            timSystemAddFriend(msg.requestAddFriendUserList);
            break;
          case TimSystemMessage.TIM_SNS_SYSTEM_DEL_FRIEND:
            timSystemDelFriend(msg.delRequestAddFriendUserList);
            break;
          case TimSystemMessage.TIM_SNS_SYSTEM_ADD_FRIEND_REQ:
            timSystemAddFriendReq(msg.friendAddPendencyList);
            break;
          case TimSystemMessage.TIM_SNS_SYSTEM_DEL_FRIEND_REQ:
            timSystemDelFriendReq(msg.delFriendAddPendencyList);
            break;
          case TimSystemMessage.TIM_SNS_SYSTEM_ADD_BLACKLIST:
            timSystemAddBlacklist(msg.addBlacklistUserList);
            break;
          case TimSystemMessage.TIM_SNS_SYSTEM_DEL_BLACKLIST:
            timSystemDelBlacklist(msg.delBlacklistUserList);
            break;
          case TimSystemMessage.TIM_SNS_SYSTEM_PENDENCY_REPORT:
            timSystemPendencyReport();
            break;
          case TimSystemMessage.TIM_SNS_SYSTEM_SNS_PROFILE_CHANGE:
            timSystemProfileChange(msg.changeInfoList);
            break;
          default:
            print('invalid subType: ${msg.subType}');
        }
        break;
      case 'ProfileTips':
        break;
      default:
    }
  }

  /// 增加好友消息
  void timSystemAddFriend(List<String> list);

  /// 删除好友消息
  void timSystemDelFriend(List<String> list);

  /// 增加未决申请
  void timSystemAddFriendReq(List<TimFriendPendencyInfo> list);

  /// 删除未决申请
  void timSystemDelFriendReq(List<String> list);

  /// 黑名单添加
  void timSystemAddBlacklist(List<String> list);

  /// 黑名单删除
  void timSystemDelBlacklist(List<String> list);

  ///  未决已读上报
  void timSystemPendencyReport();

  ///  关系链资料变更
  void timSystemProfileChange(List<String> list);

  /// 会话刷新事件
  void onRefreshConversation(List<TimConversation> list);

  /// 收到新消息
  void timNewMessage(TimMessage message);
}
