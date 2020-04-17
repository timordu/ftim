import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String susTag = '';

  void popupMenuButtonSelected(value) {
    switch (value) {
      case 1:
        StaticRouter.toSearchUser(context);
        break;
      case 2:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: Text('通讯录', style: TextStyle(fontSize: 20)), actions: <Widget>[
          PopupMenuButton<int>(
              icon: Icon(Icons.add),
              onSelected: (value) => popupMenuButtonSelected(value),
              itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                    PopupMenuItem(value: 1, child: Text('添加好友')),
                    PopupMenuItem(value: 2, child: Text('添加群里')),
                  ])
        ]),
        body: Store.connect<FtimProvider>(builder: (context, snapshot, child) {
          List<Contact> contactList = [];
          snapshot.friendList.forEach((f) {
            var name = f.remark.isEmpty ? f.timUserProfile.nickName : f.remark;
            String py = PinyinHelper.getShortPinyin(name.isEmpty ? '#' : name.substring(0, 1)).toUpperCase();
            contactList.add(Contact(tagIndex: RegExp("[A-Z]").hasMatch(py) ? py : '#', userInfo: f));
          });
          SuspensionUtil.sortListBySuspensionTag(contactList);
          if (contactList.length > 0) susTag = contactList[0].getSuspensionTag();

          return AzListView(
              data: contactList,
              isUseRealIndex: true,
              header: AzListViewHeader(height: 102, builder: (context) => listViewHeader(snapshot)),
              suspensionWidget: _buildSusWidget(susTag),
              onSusTagChanged: (tag) => setState(() => susTag = tag),
              itemBuilder: (context, contact) => itemBuilder(contact));
        }));
  }

  Widget listViewHeader(FtimProvider snapshot) {
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          FlatButton(
              onPressed: () => StaticRouter.toNewFriend(context),
              child: Container(
                  height: 40,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Row(children: <Widget>[
                      Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(color: Colors.orangeAccent, borderRadius: BorderRadius.circular(5)),
                          child: Image.asset(FileUtil.loadImage('new_friend.png'))),
                      Container(margin: EdgeInsets.only(left: 15), child: Text('新朋友')),
                    ]),
                    Offstage(
                        offstage: snapshot.timFriendPendency.unreadCnt == 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
                          child: Text(snapshot.timFriendPendency.unreadCnt.toString(), style: TextStyle(color: Colors.white)),
                        ))
                  ]))),
          Container(margin: EdgeInsets.only(left: 70), child: Divider(height: 1)),
          FlatButton(
              onPressed: () {},
              child: Container(
                  height: 40,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(children: <Widget>[
                    Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(color: Colors.greenAccent, borderRadius: BorderRadius.circular(5)),
                        child: Image.asset(FileUtil.loadImage('group_chat.png'))),
                    Container(margin: EdgeInsets.only(left: 15), child: Text('群聊'))
                  ]))),
          Divider(height: 1)
        ]));
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: 25,
      padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
      color: Colors.grey[200],
      width: double.infinity,
      child: Text('$susTag'),
    );
  }

  Widget itemBuilder(Contact contact) {
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          contact.isShowSuspension ? _buildSusWidget(contact.getSuspensionTag()) : Container(margin: EdgeInsets.only(left: 70), child: Divider(height: 1)),
          FlatButton(
            child: avatarBuilder(contact.userInfo),
            onPressed: () => StaticRouter.toUserInfo(context, contact.userInfo),
          )
        ]));
  }

  Widget avatarBuilder(TimFriend timFriend) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(children: <Widget>[
          Avatar.builder(timFriend.timUserProfile.faceUrl),
          Container(
              margin: EdgeInsets.only(left: 15),
              child: Text(timFriend.remark.isEmpty
                  ? (timFriend.timUserProfile.nickName.isEmpty ? timFriend.identifier : timFriend.timUserProfile.nickName)
                  : timFriend.remark))
        ]));
  }
}
