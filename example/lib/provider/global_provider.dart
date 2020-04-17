import 'package:flutter/widgets.dart';

class GlobalProvider with ChangeNotifier {
  int homeTabIndex = 0;

  void setHomeTabIndex(int index) {
    homeTabIndex = index;
    notifyListeners();
  }
}
