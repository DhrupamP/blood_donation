import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
  bool isloading = true;
  void Stoploading() {
    isloading = false;
    notifyListeners();
  }
}
