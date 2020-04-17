import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ftim_example/export.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var map = {
    '17711073421':
        'eJw1jc0KgkAURl9FZh1258dmDFq2iIqoJNFdNJNcLMfUQovePU3dnnP4vg8JNkf3ZQoydwhzgUycP0Ftsgqv2AsqJaUguWB0DEqdnvMcdaupAODAOPDBmTrHwnTG8zwGAAOv8N5Tqajf5v64hUn3EjOlVk9fNMn7ZKPqtg9jubWPqbnYnQrX6SEKllndzHQpFuT7A*rxM0w_',
    '18628096187':
        'eJw1jV0LgjAYRv*K7NaQd5vTLeiiLKIIusig24HTXqQYfqwk*u9p6u05h*f5kPR0CZypyNIjLACy8P4EM-NsMMdRUBkxCSqiMp6DOiu1tZj1moYAHBgHPjnztliZwQghGABMvMHHSGNJVZ*reQuL4eV6rtb8rlufJq*6DU3ilO42W9Ec0rIr6G23V-7RcZ7nxYp8f*-VMrM_'
  };

  void login(String identifier) {
    Ftim.get().login(identifier, map[identifier], callback: (success, message, data) {
      if (success) {
        Store.of<FtimProvider>(context)
          ..setMyProfile(data)
          ..init();
        StaticRouter.toHome(context);
      } else
        BotToast.showText(text: message, textStyle: TextStyle(fontSize: 12, color: Colors.white));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('登录')),
      body: Container(child: Center(child: loginForm())),
    );
  }

  Widget loginForm() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
          width: 225,
          child: FlatButton(
            child: Text('17711073421 登录', style: TextStyle(color: Config.color_primary)),
            color: Colors.lightBlueAccent,
            onPressed: () => login('17711073421'),
          )),
      Container(
          width: 225,
          child: FlatButton(
            child: Text('18628096187 登录', style: TextStyle(color: Config.color_primary)),
            color: Colors.lightBlueAccent,
            onPressed: () => login('18628096187'),
          )),
    ]);
  }
}
