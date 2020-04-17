import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class SearchUserPage extends StatefulWidget {
  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  String identifier = '';

  void search() async {
    if (identifier.isEmpty) return;
    if (KeyboardDetector.isShow(context)) KeyboardDetector.close(context);
    Ftim.get().getUsersProfile([identifier], callback: (success, message, data) {
      if (success && data != null && data.isNotEmpty) {
        check(data[0]);
      } else {
        BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
      }
    });
  }

  void check(TimUserProfile userProfile) {
    Ftim.get().checkFriends([userProfile.identifier], callback: (success, message, data) {
      if (success && data != null && data.isNotEmpty) {
        if (data[0].resultType == 0 || data[0].resultType == 2) {
          StaticRouter.toNewFriendInfo(context, userProfile);
        }
        // TODO resultType == 3 没处理 
      } else {
        BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: Text('搜索用户', style: TextStyle(fontSize: 20))),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Row(children: <Widget>[
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: CupertinoTextField(
                        padding: EdgeInsets.all(5),
                        style: TextStyle(fontSize: 15),
                        placeholder: '搜索用户名',
                        prefix: Container(padding: EdgeInsets.only(left: 5), child: Icon(Icons.search, size: 12)),
                        placeholderStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        controller: TextEditingController.fromValue(TextEditingValue(
                          text: identifier,
                          selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: identifier.length)),
                        )),
                        onChanged: (String str) => setState(() => identifier = str)))),
            GestureDetector(
              child: Text('搜索', style: TextStyle(color: Theme.of(context).primaryColor)),
              onTap: () => search(),
            )
          ]),
        ));
  }
}
