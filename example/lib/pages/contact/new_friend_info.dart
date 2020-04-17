import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class NewFriendInfoPage extends StatefulWidget {
  NewFriendInfoPage(this.userProfile, {this.pendencyItem});

  final TimUserProfile userProfile;
  final TimFriendPendencyItem pendencyItem;

  @override
  _NewFriendInfoPageState createState() => _NewFriendInfoPageState();
}

class _NewFriendInfoPageState extends State<NewFriendInfoPage> {
  void moreOperation(String key) async {
    switch (key) {
      case 'add_friend':
        StaticRouter.toAddNewFriend(context, widget.userProfile);
        break;
      case 'add_to_black':
        Ftim.get().addBlackList([widget.userProfile.identifier]);
        break;
      case 'remove_from_black':
        Ftim.get().deleteBlackList([widget.userProfile.identifier]);
        break;
      default:
    }
  }

  void doResponse(String identifier, int type) {
    Ftim.get().doResponse(identifier, type, callback: (success, message, data) {
      if (success && data.resultCode == 0) {
        Navigator.of(context).pop();
      } else {
        BotToast.showText(text: message ?? data.resultInfo, textStyle: TextStyle(fontSize: 12, color: Colors.white));
      }
    });
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
        Avatar.builder(widget.userProfile.faceUrl),
        Container(margin: EdgeInsets.only(top: 15), child: Text(widget.userProfile.nickName))
      ])),
    );
  }

  Widget buildInfo() {
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Text('用户名'),
                Text(widget.userProfile.identifier),
              ])),
          Container(padding: EdgeInsets.only(left: 15, right: 15), child: Divider(height: 1)),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Text('性别'),
                Text(widget.userProfile.getGender()),
              ])),
          Container(padding: EdgeInsets.only(left: 15, right: 15), child: Divider(height: 1)),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Text('地区'),
                Text(widget.userProfile.location),
              ])),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Text('个性签名'),
                Text(widget.userProfile.selfSignature),
              ]))
        ]));
  }

  Widget buildOperation() {
    // 添加好友
    var addFriend = Container(
        width: Config.screenWidth(context),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: RaisedButton(
            color: Theme.of(context).primaryColor, child: Text('添加好友', style: TextStyle(color: Colors.white)), onPressed: () => moreOperation('add_friend')));

    // 同意
    var agree = Container(
        width: Config.screenWidth(context),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text('同意', style: TextStyle(color: Colors.white)),
            onPressed: () => doResponse(widget.userProfile.identifier, 1)));

    // 拒绝
    var refuse = Container(
        width: Config.screenWidth(context),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text('拒绝', style: TextStyle(color: Colors.white)),
            onPressed: () => doResponse(widget.userProfile.identifier, 2)));

    return Container(
      width: Config.screenWidth(context),
      margin: EdgeInsets.only(top: 25),
      child: Column(children: <Widget>[
        Offstage(offstage: widget.pendencyItem != null, child: addFriend),
        Offstage(offstage: widget.pendencyItem == null, child: agree),
        Offstage(offstage: widget.pendencyItem == null, child: refuse),
      ]),
    );
  }

  void showMoreOperation() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 85,
              color: Colors.black54,
              child: Column(children: <Widget>[
                Store.connect<FtimProvider>(builder: (context, snapshot, child) {
                  bool inBlackList = snapshot.isInBlackList(widget.userProfile.identifier);
                  return buildSheetItem(inBlackList ? 'remove_from_black' : 'add_to_black', inBlackList ? '移除黑名单' : '加入黑名单');
                }),
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
