import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class Config {
  Config._();

  static const Color color_primary = Color(0xFFFFFFFF);

  /// 屏幕宽度
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  /// 屏幕高度
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
}

/// 静态路由
class StaticRouter {
  StaticRouter._();

  /// 路由表
  static Map<String, WidgetBuilder> routes(BuildContext context) => {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/mine/myInfo': (context) => MyInfoPage(),
        '/contact/friend': (context) => NewFriendPage(),
        '/contact/search': (context) => SearchUserPage(),
      };

  /// 登录
  static void toLogin(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil('/login', (router) => router == null);

  /// 主界面
  static void toHome(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil('/home', (router) => router == null);

  /// 个人用户信息
  static void toMyInfo(BuildContext context) => Navigator.of(context).pushNamed('/mine/myInfo');

  /// 编辑个人信息
  static Future toEditInfo(BuildContext context, String filed, String title, String value) async =>
      await Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditInfoPage(filed, title, value)));

  /// 用户信息
  static void toUserInfo(BuildContext context, TimFriend timFriend) =>
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => UserInfoPage(timFriend)), ModalRoute.withName('/home'));

  /// 搜索用户
  static void toSearchUser(BuildContext context) => Navigator.of(context).pushNamed('/contact/search');

  /// 新朋友
  static void toNewFriend(BuildContext context) => Navigator.of(context).pushNamed('/contact/friend');

  /// 新朋友信息
  static void toNewFriendInfo(BuildContext context, TimUserProfile userProfile, {TimFriendPendencyItem pendencyItem}) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewFriendInfoPage(userProfile, pendencyItem: pendencyItem)));

  /// 添加新朋友
  static void toAddNewFriend(BuildContext context, TimUserProfile userProfile) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewFriendAddPage(userProfile)));

  /// 单聊界面
  static void toSingleChat(BuildContext context, TimConversation conversation) {
    Store.of<GlobalProvider>(context).setHomeTabIndex(0);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => ChatPage(conversation)), ModalRoute.withName('/home'));
  }

  /// 位置搜索界面
  static void toChatLocation(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatAmapWidget()));
  }
}
