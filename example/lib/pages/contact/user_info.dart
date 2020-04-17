import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage(this.timFriend);

  final TimFriend timFriend;

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String reason = '';

  void moreOperation(String key) async {
    switch (key) {
      case 'send_msg':
        TimConversation conversation = await Ftim.get().getConversation(widget.timFriend.identifier);
        StaticRouter.toSingleChat(context, conversation);
        break;
      case 'set_note':
        break;
      case 'add_to_black':
        Ftim.get().addBlackList([widget.timFriend.identifier]);
        break;
      case 'remove_from_black':
        Ftim.get().deleteBlackList([widget.timFriend.identifier]);
        break;
      case 'share':
        break;
      case 'delete':
        Ftim.get().deleteFriends([widget.timFriend.identifier], 2, callback: (success, message, data) {
          if (success && data.isNotEmpty && data[0].resultCode == 0) {
            Navigator.of(context).pop();
          } else {
            BotToast.showText(text: message ?? data[0].resultInfo, textStyle: TextStyle(fontSize: 12, color: Colors.white));
          }
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('详细资料', style: TextStyle(fontSize: 20)), actions: <Widget>[
        IconButton(icon: Icon(Icons.more_vert), onPressed: () => showMoreOperation()),
      ]),
      body: SingleChildScrollView(child: Column(children: <Widget>[buildAvatar(), buildInfo(), buildOperation()])),
    );
  }

  Widget buildAvatar() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Center(
          child: Column(children: <Widget>[
        Avatar.builder(widget.timFriend.timUserProfile.faceUrl),
        Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(widget.timFriend.remark.isEmpty
                ? (widget.timFriend.timUserProfile.nickName.isEmpty
                    ? widget.timFriend.identifier
                    : widget.timFriend.timUserProfile.nickName)
                : widget.timFriend.remark))
      ])),
    );
  }

  Widget buildInfo() {
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('性别'), Text(widget.timFriend.timUserProfile.getGender())])),
          Container(padding: EdgeInsets.only(left: 15, right: 15), child: Divider(height: 1)),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Text('生日'),
                Text(DateUtil.formatMicroseconds(widget.timFriend.timUserProfile.birthday * 1000, format: 'yyyy-MM-dd')),
              ])),
          Container(padding: EdgeInsets.only(left: 15, right: 15), child: Divider(height: 1)),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Text('地区'),
                Text(widget.timFriend.timUserProfile.location),
              ])),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Text('个性签名'),
                Text(widget.timFriend.timUserProfile.selfSignature),
              ]))
        ]));
  }

  Widget buildOperation() {
    return Container(
        width: Config.screenWidth(context),
        margin: EdgeInsets.only(top: 25),
        child: Column(children: <Widget>[
          Container(
              width: Config.screenWidth(context),
              padding: EdgeInsets.only(left: 15, right: 15),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('发消息', style: TextStyle(color: Colors.white)),
                onPressed: () => moreOperation('send_msg'),
              ))
        ]));
  }

  void showMoreOperation() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 207,
              color: Colors.black54,
              child: Column(children: <Widget>[
                buildSheetItem('set_not', '设置备注和标签', first: true),
                Divider(height: 0.5),
                buildSheetItem('share', '把他/她推荐给朋友'),
                Divider(height: 0.5),
                Store.connect<FtimProvider>(builder: (context, snapshot, child) {
                  bool inBlackList = snapshot.isInBlackList(widget.timFriend.timUserProfile.identifier);
                  return buildSheetItem(inBlackList ? 'remove_from_black' : 'add_to_black', inBlackList ? '移除黑名单' : '加入黑名单');
                }),
                Divider(height: 0.5),
                buildSheetItem('delete', '删除'),
                Container(margin: EdgeInsets.only(top: 5), color: Colors.black87, child: buildSheetItem('cancel', '取消')),
              ]));
        });
  }

  Widget buildSheetItem(String key, String title, {bool first = false}) {
    return GestureDetector(
        child: Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(first ? 10 : 0), topRight: Radius.circular(first ? 10 : 0)),
            ),
            child: Text(title)),
        onTap: () {
          Navigator.pop(context);
          moreOperation(key);
        });
  }
}
