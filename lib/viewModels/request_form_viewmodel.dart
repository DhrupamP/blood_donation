import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestFormVM {
  static RequestFormVM instance = RequestFormVM._();
  RequestFormVM._();

  addUpdateProfile(BuildContext context, RequestModel model) async {
    try {
      print('processing');
      final pref = await SharedPreferences.getInstance();
      String? cc = pref.getString('citycode');
      print('citycode' + cc!);
      await FirebaseDatabase.instance
          .ref()
          .child(
              "requestBloodSection/$cc/${FirebaseAuth.instance.currentUser!.uid}/")
          .push()
          .update(model.toJson());
      print('done!!');
    } catch (e) {
      print(e);
    }
  }
}
