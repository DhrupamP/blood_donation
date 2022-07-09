import 'package:flutter/cupertino.dart';

class ProfilePageProvider extends ChangeNotifier {
  bool editmode = false;
  void toggleEdit() {
    editmode = !editmode;
    notifyListeners();
  }
}
