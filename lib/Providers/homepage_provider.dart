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

  bool isStoryloading = false;

  void StopStoryloading() {
    isloading = false;
    notifyListeners();
  }

  void StartStoryloading() {
    isloading = true;
    notifyListeners();
  }
}
