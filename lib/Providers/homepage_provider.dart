import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
  bool isloading = false;
  void Stoploading() {
    isloading = false;
    notifyListeners();
  }

  void Startloading() {
    isloading = true;
    notifyListeners();
  }
}
