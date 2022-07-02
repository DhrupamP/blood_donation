import 'dart:io';

import 'package:flutter/cupertino.dart';

class StoryProvider extends ChangeNotifier {
  bool isLoading = false;
  File? storyimg;
  void showimage(File file) {
    storyimg = file;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }
}
