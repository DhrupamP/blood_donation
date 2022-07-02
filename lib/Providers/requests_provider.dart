import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../Models/request_form_model.dart';
import '../Models/request_model.dart';
import '../Screens/home_page.dart';

class RequestsProvider extends ChangeNotifier {
  Map<dynamic, dynamic> pcreatedmap = {};
  Map<dynamic, dynamic> psentmap = {};
  Map<dynamic, dynamic> pacceptedmap = {};
  bool isLoading = true;
  Map<dynamic, dynamic> pconfirmedmap = {};
  bool sendnewreq = true;
  void requestcomplete() {
    sendnewreq = true;
    notifyListeners();
  }

  void requestcancelled() {
    sendnewreq = true;
    notifyListeners();
  }

  void onerequestdone() {
    sendnewreq = false;
    notifyListeners();
  }

  void startloading() {
    isLoading = true;
    notifyListeners();
  }

  void stoploading() {
    isLoading = false;
    notifyListeners();
  }
}
