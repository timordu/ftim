import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  /// 分类更新
  void operation(String key, String title, String value) async {
    switch (key) {
      case 'avatar':
        // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        var image = 'http://img12.3lian.com/gaoqing02/02/93/37.jpg';
        Ftim.get().modifySelfProfile(TimUserProfile(faceUrl: image), callback: (success, message, data) {
          if (success)
            Store.of<FtimProvider>(context).setMyProfile(data);
          else
            BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
        });
        break;
      case 'nickName':
        String nickName = await StaticRouter.toEditInfo(context, key, title, value);
        Ftim.get().modifySelfProfile(TimUserProfile(nickName: nickName), callback: (success, message, data) {
          if (success)
            Store.of<FtimProvider>(context).setMyProfile(data);
          else
            BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
        });
        break;
      case 'gender':
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
                          child: Text('男'),
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white)),
                          onPressed: () => genderSelected(1),
                        )),
                    Container(
                        width: Config.screenWidth(context),
                        height: 40,
                        margin: EdgeInsets.only(top: 10, bottom: 15),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: FlatButton(
                          color: Colors.white,
                          child: Text('女'),
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white)),
                          onPressed: () => genderSelected(2),
                        )),
                    Container(
                        width: Config.screenWidth(context),
                        height: 40,
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: FlatButton(
                          color: Colors.white,
                          child: Text('保密'),
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white)),
                          onPressed: () => genderSelected(0),
                        )),
                  ]));
            });
        break;
      case 'birthday':
        DateTimePicker.showDatePicker(context, currentTime: DateTime.now(), onConfirm: (datetime) {
          var birthday = datetime.millisecondsSinceEpoch / 1000;
          Ftim.get().modifySelfProfile(TimUserProfile(birthday: birthday.toInt()), callback: (success, message, data) {
            if (success)
              Store.of<FtimProvider>(context).setMyProfile(data);
            else
              BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
          });
        });
        break;
      case 'location':
        String location = await StaticRouter.toEditInfo(context, key, title, value);
        Ftim.get().modifySelfProfile(TimUserProfile(location: location), callback: (success, message, data) {
          if (success)
            Store.of<FtimProvider>(context).setMyProfile(data);
          else
            BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
        });
        break;
      case 'signature':
        String signature = await StaticRouter.toEditInfo(context, key, title, value);
        Ftim.get().modifySelfProfile(TimUserProfile(selfSignature: signature), callback: (success, message, data) {
          if (success)
            Store.of<FtimProvider>(context).setMyProfile(data);
          else
            BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
        });
        break;
      default:
    }
  }

  void genderSelected(int value) {
    Navigator.pop(context);
    Ftim.get().modifySelfProfile(TimUserProfile(gender: value), callback: (success, message, data) {
      if (success)
        Store.of<FtimProvider>(context).setMyProfile(data);
      else
        BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: Text('个人信息')),
        body: Store.connect<FtimProvider>(builder: (context, snapshot, child) {
          return Column(children: <Widget>[
            buildItem('avatar', '头像', snapshot.myProfile.faceUrl),
            Container(color: Colors.white, padding: EdgeInsets.only(left: 15), child: Divider(height: 1)),
            buildItem('nickName', '昵称', snapshot.myProfile.nickName),
            Container(color: Colors.white, padding: EdgeInsets.only(left: 15), child: Divider(height: 1)),
            buildItem('gender', '性别', snapshot.myProfile.getGender()),
            Container(color: Colors.white, padding: EdgeInsets.only(left: 15), child: Divider(height: 1)),
            buildItem('birthday', '生日',
                snapshot.myProfile.birthday == 0 ? '未设置' : DateUtil.formatMicroseconds(snapshot.myProfile.birthday * 1000, format: 'yyyy-MM-dd')),
            Container(color: Colors.white, padding: EdgeInsets.only(left: 15), child: Divider(height: 1)),
            buildItem('location', '区域', snapshot.myProfile.location),
            Container(color: Colors.white, padding: EdgeInsets.only(left: 15), child: Divider(height: 1)),
            buildItem('signature', '个性签名', snapshot.myProfile.selfSignature),
          ]);
        }));
  }

  Widget buildItem(String key, String title, String value) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => operation(key, title, value),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Text(title),
            Row(children: <Widget>[
              key == 'avatar' ? Avatar.builder(value) : Text(value ?? ''),
              Container(margin: EdgeInsets.only(left: 15), child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey))
            ])
          ])),
    );
  }
}
