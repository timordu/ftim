import 'package:json_annotation/json_annotation.dart';

part 'tim_system_message.g.dart';

@JsonSerializable()
class TimSystemMessage extends Object {
  /// 增加好友消息
  static const int TIM_SNS_SYSTEM_ADD_FRIEND = 0x01;

  /// 删除好友消息
  static const int TIM_SNS_SYSTEM_DEL_FRIEND = 0x02;

  /// 增加好友申请
  static const int TIM_SNS_SYSTEM_ADD_FRIEND_REQ = 0x03;

  /// 删除未决申请
  static const int TIM_SNS_SYSTEM_DEL_FRIEND_REQ = 0x04;

  /// 黑名单添加
  static const int TIM_SNS_SYSTEM_ADD_BLACKLIST = 0x05;

  /// 黑名单删除
  static const int TIM_SNS_SYSTEM_DEL_BLACKLIST = 0x06;

  /// 未决已读上报
  static const int TIM_SNS_SYSTEM_PENDENCY_REPORT = 0x07;

  /// 关系链资料变更
  static const int TIM_SNS_SYSTEM_SNS_PROFILE_CHANGE = 0x08;

  @JsonKey(name: 'addBlacklistUserList')
  List<String> addBlacklistUserList;

  @JsonKey(name: 'addFriendGroupList')
  List<String> addFriendGroupList;

  @JsonKey(name: 'changeInfoList')
  List<String> changeInfoList;

  @JsonKey(name: 'decideReportTimestamp')
  int decideReportTimestamp;

  @JsonKey(name: 'delBlacklistUserList')
  List<String> delBlacklistUserList;

  @JsonKey(name: 'delFriendAddDecideList')
  List<String> delFriendAddDecideList;

  @JsonKey(name: 'delFriendAddPendencyList')
  List<String> delFriendAddPendencyList;

  @JsonKey(name: 'delFriendGroupList')
  List<String> delFriendGroupList;

  @JsonKey(name: 'delRecommendList')
  List<String> delRecommendList;

  @JsonKey(name: 'delRequestAddFriendUserList')
  List<String> delRequestAddFriendUserList;

  @JsonKey(name: 'friendAddDecideList')
  List<String> friendAddDecideList;

  @JsonKey(name: 'friendAddPendencyList')
  List<TimFriendPendencyInfo> friendAddPendencyList;

  @JsonKey(name: 'pendencyReportTimestamp')
  int pendencyReportTimestamp;

  @JsonKey(name: 'recommendList')
  List<String> recommendList;

  @JsonKey(name: 'recommendReportTimestamp')
  int recommendReportTimestamp;

  @JsonKey(name: 'requestAddFriendUserList')
  List<String> requestAddFriendUserList;

  @JsonKey(name: 'subType')
  int subType;

  @JsonKey(name: 'updateFriendGroupList')
  List<String> updateFriendGroupList;

  @JsonKey(name: 'type')
  String type;

  TimSystemMessage(
    this.addBlacklistUserList,
    this.addFriendGroupList,
    this.changeInfoList,
    this.decideReportTimestamp,
    this.delBlacklistUserList,
    this.delFriendAddDecideList,
    this.delFriendAddPendencyList,
    this.delFriendGroupList,
    this.delRecommendList,
    this.delRequestAddFriendUserList,
    this.friendAddDecideList,
    this.friendAddPendencyList,
    this.pendencyReportTimestamp,
    this.recommendList,
    this.recommendReportTimestamp,
    this.requestAddFriendUserList,
    this.subType,
    this.updateFriendGroupList,
    this.type,
  );

  factory TimSystemMessage.fromJson(Map<String, dynamic> srcJson) => _$TimSystemMessageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimSystemMessageToJson(this);
}

@JsonSerializable()
class TimFriendPendencyInfo extends Object {
  @JsonKey(name: 'addSource')
  String addSource;

  @JsonKey(name: 'addWording')
  String addWording;

  @JsonKey(name: 'fromUser')
  String fromUser;

  @JsonKey(name: 'fromUserNickName')
  String fromUserNickName;

  TimFriendPendencyInfo(
    this.addSource,
    this.addWording,
    this.fromUser,
    this.fromUserNickName,
  );

  factory TimFriendPendencyInfo.fromJson(Map<String, dynamic> srcJson) => _$TimFriendPendencyInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimFriendPendencyInfoToJson(this);
}
