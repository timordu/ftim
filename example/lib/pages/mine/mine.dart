import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  void modifyAllowType() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              height: 160,
              child: Column(children: <Widget>[
                Container(
                    width: Config.screenWidth(context),
                    height: 40,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: FlatButton(
                      color: Colors.white,
                      child: Text('允许任何人'),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white)),
                      onPressed: () => allowTypeSelected(TimUserProfile.TIM_FRIEND_ALLOW_ANY),
                    )),
                Container(
                    width: Config.screenWidth(context),
                    height: 40,
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: FlatButton(
                      color: Colors.white,
                      child: Text('拒绝任何人'),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white)),
                      onPressed: () => allowTypeSelected(TimUserProfile.TIM_FRIEND_DENY_ANY),
                    )),
                Container(
                    width: Config.screenWidth(context),
                    height: 40,
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: FlatButton(
                      color: Colors.white,
                      child: Text('需要验证'),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white)),
                      onPressed: () => allowTypeSelected(TimUserProfile.TIM_FRIEND_NEED_CONFIRM),
                    )),
              ]));
        });
  }

  void allowTypeSelected(String value) {
    Navigator.of(context).pop();
    Ftim.get().modifySelfProfile(TimUserProfile(allowType: value), callback: (success, message, data) {
      if (success)
        Store.of<FtimProvider>(context).setMyProfile(data);
      else
        BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('我', style: TextStyle(fontSize: 20))),
      body: Column(children: <Widget>[
        buildAvatar(),
        buildInfo(),
        buildOperation(),
      ]),
    );
  }

  Widget buildAvatar() {
    return Store.connect<FtimProvider>(builder: (context, snapshot, child) {
      return Container(
        padding: EdgeInsets.all(40),
        child: Center(
            child: Column(children: <Widget>[
          Avatar.builder(snapshot.myProfile.faceUrl),
          Container(margin: EdgeInsets.only(top: 15), child: Text(snapshot.myProfile.nickName))
        ])),
      );
    });
  }

  Widget buildInfo() {
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => StaticRouter.toMyInfo(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('个人资料'), Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey)],
                  ))),
          Container(padding: EdgeInsets.only(left: 15, right: 15), child: Divider(height: 1)),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => modifyAllowType(),
                  child: Store.connect<FtimProvider>(builder: (context, snapshot, child) {
                    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      Text('加我好友时'),
                      Row(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(snapshot.myProfile.getAllowType(), style: TextStyle(color: Colors.grey[700]))),
                        Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
                      ])
                    ]);
                  }))),
          Container(padding: EdgeInsets.only(left: 15, right: 15), child: Divider(height: 1)),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Text('黑名单管理'),
                    Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
                  ]))),
        ]));
  }

  Widget buildOperation() {
    return Container(
        width: Config.screenWidth(context),
        padding: EdgeInsets.only(left: 15, right: 15),
        margin: EdgeInsets.only(top: 15),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text('退出登录', style: TextStyle(color: Colors.white)),
          onPressed: () => Ftim.get().logout(callback: (success, message, data) {
            if (success) {
              Store.of<GlobalProvider>(context).setHomeTabIndex(0);
              StaticRouter.toLogin(context);
            } else
              BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
          }),
        ));
  }
}
