import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/number_input.dart';

String? reqid = '';
RequestModel currentuserRequest = RequestModel();
RequestModel acceptedRequest = RequestModel();
RequestModel confirmedRequest = RequestModel();
RequestModel sentRequest = RequestModel();

Map<dynamic, dynamic> createdmap = {};
String k = '';
String code = '';

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

  UpdateProfile(BuildContext context, RequestModel model) async {
    try {
      print('processing');
      final pref = await SharedPreferences.getInstance();
      String? cc = pref.getString('citycode');
      print('citycode' + cc!);

      await FirebaseDatabase.instance
          .ref()
          .child(
              "requestBloodSection/$cc/${FirebaseAuth.instance.currentUser!.uid}/$k")
          .update(model.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRequestData(BuildContext ctx) async {
    print('getting request data.....');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cc = pref.getString('citycode');
    DatabaseReference reqref = FirebaseDatabase.instance.ref(
        'requestBloodSection/$cc/${FirebaseAuth.instance.currentUser?.uid}');
    DatabaseEvent createdevt =
        await reqref.orderByChild('status').equalTo('created').once();
    DatabaseEvent sentevt =
        await reqref.orderByChild('status').equalTo('sent').once();
    DatabaseEvent acceptedevt =
        await reqref.orderByChild('status').equalTo('ACCEPTED').once();
    // DatabaseEvent cancelledevt =
    //     await reqref.orderByChild('status').equalTo('cancelled').once();
    DatabaseEvent confirmedevt =
        await reqref.orderByChild('status').equalTo('confirmed').once();
    // DatabaseEvent completedevt =
    //     await reqref.orderByChild('status').equalTo('completed').once();
    if (createdevt.snapshot.value != null) {
      print('created data');
      createdmap = createdevt.snapshot.value as Map<dynamic, dynamic>;
      k = createdmap.keys.toList().first;
      currentuserRequest = RequestModel.fromJson(createdmap[k]);
    } else {
      createdmap = {};
    }

    if (acceptedevt.snapshot.value != null) {
      Map<dynamic, dynamic> acceptedmap =
          acceptedevt.snapshot.value as Map<dynamic, dynamic>;
      k = acceptedmap.keys.toList().first;
      acceptedRequest = RequestModel.fromJson(acceptedmap[k]);
    } else {
      print('sent data is null');
    }
    if (sentevt.snapshot.value != null) {
      Map<dynamic, dynamic> sentmap =
          acceptedevt.snapshot.value as Map<dynamic, dynamic>;
      k = sentmap.keys.toList().first;
      sentRequest = RequestModel.fromJson(sentmap[k]);
    } else {
      print('sent data is null');
    }
    if (confirmedevt.snapshot.value != null) {
      Map<dynamic, dynamic> sentmap =
          confirmedevt.snapshot.value as Map<dynamic, dynamic>;
      k = sentmap.keys.toList().first;
      confirmedRequest = RequestModel.fromJson(sentmap[k]);
    } else {
      print('sent data is null');
    }

    // Map<dynamic, dynamic> acceptedmap =
    //     acceptedevt.snapshot.value as Map<dynamic, dynamic>;
    // Map<dynamic, dynamic> cancelledmap =
    //     cancelledevt.snapshot.value as Map<dynamic, dynamic>;
    // Map<dynamic, dynamic> confirmedmap =
    //     confirmedevt.snapshot.value as Map<dynamic, dynamic>;
    // Map<dynamic, dynamic> completedmap =
    //     completedevt.snapshot.value as Map<dynamic, dynamic>;
    // print('createdmap jsondata: .... ' + createdmap.toString());
    // print(createdmap.values.first['status']);

    // print('acceptedmap jsondata: .... ' + acceptedmap.toString());
    // print('cancelledmap jsondata: .... ' + cancelledmap.toString());
    // print('completedmap jsondata: .... ' + completedmap.toString());
    // print('confirmedmap jsondata: .... ' + confirmedmap.toString());

    print('data recieved');
  }

  Future<void> getCityCodeFromSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    code = pref.getString('citycode')!;
  }

  Future<void> acceptRequest(
      BuildContext context, String requestuid, String requestpushid) async {
    await FirebaseDatabase.instance
        .ref()
        .child('requestBloodSection/C1/$requestuid/$requestpushid')
        .update({'status': 'ACCEPTED'});
  }

  Future<void> confirmRequest(BuildContext context) async {
    await FirebaseDatabase.instance
        .ref()
        .child('requestBloodSection/C1/${userdata.uid}/$k')
        .update({'status': 'CONFIRMED'});
    print(k);
  }
}
