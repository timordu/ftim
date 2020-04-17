// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_system_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimSystemMessage _$TimSystemMessageFromJson(Map<String, dynamic> json) {
  return TimSystemMessage(
      (json['addBlacklistUserList'] as List)?.map((e) => e as String)?.toList(),
      (json['addFriendGroupList'] as List)?.map((e) => e as String)?.toList(),
      (json['changeInfoList'] as List)?.map((e) => e as String)?.toList(),
      json['decideReportTimestamp'] as int,
      (json['delBlacklistUserList'] as List)?.map((e) => e as String)?.toList(),
      (json['delFriendAddDecideList'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      (json['delFriendAddPendencyList'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      (json['delFriendGroupList'] as List)?.map((e) => e as String)?.toList(),
      (json['delRecommendList'] as List)?.map((e) => e as String)?.toList(),
      (json['delRequestAddFriendUserList'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      (json['friendAddDecideList'] as List)?.map((e) => e as String)?.toList(),
      (json['friendAddPendencyList'] as List)
          ?.map((e) => e == null
              ? null
              : TimFriendPendencyInfo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['pendencyReportTimestamp'] as int,
      (json['recommendList'] as List)?.map((e) => e as String)?.toList(),
      json['recommendReportTimestamp'] as int,
      (json['requestAddFriendUserList'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      json['subType'] as int,
      (json['updateFriendGroupList'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      json['type'] as String);
}

Map<String, dynamic> _$TimSystemMessageToJson(TimSystemMessage instance) =>
    <String, dynamic>{
      'addBlacklistUserList': instance.addBlacklistUserList,
      'addFriendGroupList': instance.addFriendGroupList,
      'changeInfoList': instance.changeInfoList,
      'decideReportTimestamp': instance.decideReportTimestamp,
      'delBlacklistUserList': instance.delBlacklistUserList,
      'delFriendAddDecideList': instance.delFriendAddDecideList,
      'delFriendAddPendencyList': instance.delFriendAddPendencyList,
      'delFriendGroupList': instance.delFriendGroupList,
      'delRecommendList': instance.delRecommendList,
      'delRequestAddFriendUserList': instance.delRequestAddFriendUserList,
      'friendAddDecideList': instance.friendAddDecideList,
      'friendAddPendencyList': instance.friendAddPendencyList,
      'pendencyReportTimestamp': instance.pendencyReportTimestamp,
      'recommendList': instance.recommendList,
      'recommendReportTimestamp': instance.recommendReportTimestamp,
      'requestAddFriendUserList': instance.requestAddFriendUserList,
      'subType': instance.subType,
      'updateFriendGroupList': instance.updateFriendGroupList,
      'type': instance.type
    };

TimFriendPendencyInfo _$TimFriendPendencyInfoFromJson(
    Map<String, dynamic> json) {
  return TimFriendPendencyInfo(
      json['addSource'] as String,
      json['addWording'] as String,
      json['fromUser'] as String,
      json['fromUserNickName'] as String);
}

Map<String, dynamic> _$TimFriendPendencyInfoToJson(
        TimFriendPendencyInfo instance) =>
    <String, dynamic>{
      'addSource': instance.addSource,
      'addWording': instance.addWording,
      'fromUser': instance.fromUser,
      'fromUserNickName': instance.fromUserNickName
    };
