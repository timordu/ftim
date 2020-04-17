import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class NewFriendAddPage extends StatefulWidget {
  NewFriendAddPage(this.userProfile);

  final TimUserProfile userProfile;

  @override
  _NewFriendAddPageState createState() => _NewFriendAddPageState();
}

class _NewFriendAddPageState extends State<NewFriendAddPage> {
  String addWording = '';
  String remark = '';

  @override
  void initState() {
    super.initState();
    addWording = '我是${Store.of<FtimProvider>(context).myProfile.nickName}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('申请添加朋友', style: TextStyle(fontSize: 20)), actions: <Widget>[
        FlatButton(
            child: Text('发送', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Ftim.get().addFriend(widget.userProfile.identifier, addWording: addWording, remark: remark, callback: (success, message, data) {
                if (success && data.resultCode == 0) {
                  Navigator.of(context).pop();
                } else {
                  BotToast.showText(text: message ?? data.resultInfo, textStyle: TextStyle(fontSize: 12, color: Colors.white));
                }
              });
            })
      ]),
      body: SingleChildScrollView(
          child: Container(
              width: Config.screenWidth(context),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 40, left: 30, right: 30),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Container(margin: EdgeInsets.only(top: 40, bottom: 10), child: Text('发送添加朋友申请', style: TextStyle(fontSize: 12))),
                      CupertinoTextField(
                          padding: EdgeInsets.all(10),
                          style: TextStyle(fontSize: 15),
                          maxLines: 5,
                          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                          controller: TextEditingController.fromValue(TextEditingValue(
                            text: addWording,
                            selection:
                                TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: addWording.length)),
                          )),
                          onChanged: (String str) => setState(() => addWording = str)),
                      Container(margin: EdgeInsets.only(top: 40, bottom: 10), child: Text('设置备注', style: TextStyle(fontSize: 12))),
                      CupertinoTextField(
                          padding: EdgeInsets.all(10),
                          style: TextStyle(fontSize: 15),
                          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                          placeholder: widget.userProfile.nickName,
                          controller: TextEditingController.fromValue(TextEditingValue(
                            text: remark,
                            selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: remark.length)),
                          )),
                          onChanged: (String str) => setState(() => remark = str),
                          onTap: () => setState(() => remark = widget.userProfile.nickName))
                    ]))
              ]))),
    );
  }
}
