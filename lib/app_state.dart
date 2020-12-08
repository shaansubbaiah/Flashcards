import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isNightModeOn = false;
  String mode = "Light Mode";

  void changeTheme() {
    isNightModeOn = isNightModeOn ? false : true;
    if (mode == "Light Mode") {
      mode = "Night Mode";
    } else {
      mode = "Light Mode";
    }
    notifyListeners();
  }
}
