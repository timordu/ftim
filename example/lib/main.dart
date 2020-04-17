import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ftim_example/export.dart';

void main() {
  runApp(Store.init(child: MyApp(), providers: [
    ChangeNotifierProvider(create: (_) => FtimProvider()),
    ChangeNotifierProvider(create: (_) => GlobalProvider()),
  ]));
  // Sqflite.setDebugModeOn();
  //应用方向
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //安卓开启沉侵状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
          title: 'Ftim Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          navigatorObservers: [BotToastNavigatorObserver()],
          home: WelcomePage(),
          routes: StaticRouter.routes(context)),
    );
  }
}
