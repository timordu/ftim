import 'package:ftim/bean/bean.dart';

extension TimUserProfileExt on TimUserProfile {
  /// 获取性别
  ///
  String getGender() {
    switch (gender) {
      case 1:
        return '男';
        break;
      case 2:
        return '女';
        break;
      default:
        return '保密';
    }
  }

  /// 获取好友验证类型
  ///
  String getAllowType() {
    switch (allowType) {
      case TimUserProfile.TIM_FRIEND_ALLOW_ANY:
        return '允许任何人';
        break;
      case TimUserProfile.TIM_FRIEND_DENY_ANY:
        return '拒绝任何人';
        break;
      case TimUserProfile.TIM_FRIEND_NEED_CONFIRM:
        return '需要验证';
        break;
      default:
        return 'AllowType_Type_Invalid';
    }
  }
}
