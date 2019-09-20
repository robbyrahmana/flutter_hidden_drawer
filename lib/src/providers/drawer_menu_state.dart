import 'package:flutter/foundation.dart';

class DrawerMenuState with ChangeNotifier {
  int _currentMenuIndex = 0;
  int get currentMenuIndex => _currentMenuIndex;

  void changeIndexState(int index) {
    _currentMenuIndex = index;
    notifyListeners();
  }
}
