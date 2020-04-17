import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class NewFriendPage extends StatefulWidget {
  @override
  _NewFriendPageState createState() => _NewFriendPageState();
}

class _NewFriendPageState extends State<NewFriendPage> {
  void quickAccept(String identifier) {
    Ftim.get().doResponse(identifier, 1, callback: (success, message, data) {
      if (success && data.resultCode == 0) {
        Navigator.of(context).pop();
      } else {
        BotToast.showText(text: message ?? data.resultInfo, textStyle: TextStyle(fontSize: 12, color: Colors.white));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var timFriendPendency = Store.of<FtimProvider>(context).timFriendPendency;
    if (timFriendPendency.unreadCnt > 0) {
      Ftim.get().pendencyReport(timFriendPendency.timestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: Text('新朋友', style: TextStyle(fontSize: 20)), actions: <Widget>[
          IconButton(icon: Icon(Icons.add), color: Config.color_primary, onPressed: () => StaticRouter.toSearchUser(context)),
        ]),
        body: Store.connect<FtimProvider>(builder: (context, snapshot, child) {
          var list = snapshot.timFriendPendency.items;
          return list.isEmpty
              ? Center(child: Text('暂无好友申请'))
              : ListView.builder(itemCount: list.length, itemBuilder: (context, index) => itemBuilder(list[index]));
        }));
  }

  Widget itemBuilder(TimFriendPendencyItem item) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: FutureBuilder<TimUserProfile>(
            future: Ftim.get().queryUserProfile(item.identifier),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return buidlPendencyItem(item, snapshot.data);
              } else {
                return Container();
              }
            }));
  }

  Widget buidlPendencyItem(TimFriendPendencyItem item, TimUserProfile userProfile) {
    Widget userInfo = Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(children: <Widget>[
          Avatar.builder(userProfile.faceUrl),
          Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Text(userProfile.nickName.isEmpty ? userProfile.identifier : userProfile.nickName, style: TextStyle(fontSize: 16)),
                Text(item.addWording, style: TextStyle(color: Colors.grey, fontSize: 12))
              ]))
        ]));

    Widget action;
    bool isOverdue = true;

    TimFriend timFriend = Store.of<FtimProvider>(context).isInFriendList(userProfile.identifier);
    TimFriendPendencyItem pendencyItem = Store.of<FtimProvider>(context).isInFriendPendencyList(userProfile.identifier);

    if (timFriend != null) {
      action = Text('已添加', style: TextStyle(color: Colors.grey[300]));
    } else if (pendencyItem != null) {
      Duration d = DateUtil.parseInt(pendencyItem.addTime).difference(DateUtil.currentTime);
      if (d.inDays < 5) {
        isOverdue = false;
        action = FlatButton(
            padding: EdgeInsets.zero,
            child: Text('接受', style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () => quickAccept(item.identifier));
      }
    } else {
      action = Text('已过期', style: TextStyle(color: Theme.of(context).primaryColor));
    }

    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[userInfo, action]),
        onTap: () {
          if (timFriend != null) {
            StaticRouter.toUserInfo(context, timFriend);
          } else {
            isOverdue ? StaticRouter.toNewFriendInfo(context, userProfile) : StaticRouter.toNewFriendInfo(context, userProfile, pendencyItem: item);
          }
        });
  }
}
