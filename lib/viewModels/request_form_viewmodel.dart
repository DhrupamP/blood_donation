import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/homepage_provider.dart';
import '../Providers/profile_provider.dart';
import '../Providers/requests_provider.dart';
import '../Screens/number_input.dart';

String? reqid = '';
RequestModel currentuserRequest = RequestModel();
RequestModel acceptedRequest = RequestModel();
RequestModel confirmedRequest = RequestModel();
RequestModel sentRequest = RequestModel();
RequestModel userRequest = RequestModel();

Map<dynamic, dynamic> createdmap = {};
Map<dynamic, dynamic> sentmap = {};
Map<dynamic, dynamic> acceptedmap = {};
Map<dynamic, dynamic> confirmedmap = {};
Map<dynamic, dynamic> userrequestmap = {};

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
    // Provider.of<HomePageProvider>(ctx, listen: false).Startloading();
    print('getting request data.....');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cc = pref.getString('citycode');
    DatabaseReference reqref = FirebaseDatabase.instance.ref(
        'requestBloodSection/$cc/${FirebaseAuth.instance.currentUser?.uid}');
    DatabaseEvent createdevt =
        await reqref.orderByChild('status').equalTo('created').once();
    DatabaseEvent sentevt =
        await reqref.orderByChild('status').equalTo('SENT').once();
    DatabaseEvent acceptedevt =
        await reqref.orderByChild('status').equalTo('ACCEPTED').once();
    // DatabaseEvent cancelledevt =
    //     await reqref.orderByChild('status').equalTo('cancelled').once();
    DatabaseEvent confirmedevt =
        await reqref.orderByChild('status').equalTo('CONFIRMED').once();
    // DatabaseEvent completedevt =
    //     await reqref.orderByChild('status').equalTo('completed').once();

    if (createdevt.snapshot.value != null) {
      print('created data');
      createdmap = createdevt.snapshot.value as Map<dynamic, dynamic>;
      k = createdmap.keys.toList().last;
      currentuserRequest = RequestModel.fromJson(createdmap[k]);
      userRequest = currentuserRequest;
    } else {
      createdmap = {};
    }

    if (acceptedevt.snapshot.value != null) {
      acceptedmap = acceptedevt.snapshot.value as Map<dynamic, dynamic>;
      k = acceptedmap.keys.toList().last;
      acceptedRequest = RequestModel.fromJson(acceptedmap[k]);
      userRequest = acceptedRequest;
      ctx.read<RequestsProvider>().onerequestdone();
    } else {
      acceptedmap = {};
    }
    if (sentevt.snapshot.value != null) {
      sentmap = sentevt.snapshot.value as Map<dynamic, dynamic>;
      k = sentmap.keys.toList().last;
      sentRequest = RequestModel.fromJson(sentmap[k]);
      userRequest = sentRequest;
      ctx.read<RequestsProvider>().onerequestdone();
    } else {
      sentmap = {};
    }
    if (confirmedevt.snapshot.value != null) {
      confirmedmap = confirmedevt.snapshot.value as Map<dynamic, dynamic>;
      k = confirmedmap.keys.toList().last;
      confirmedRequest = RequestModel.fromJson(confirmedmap[k]);
      userRequest = confirmedRequest;
      ctx.read<RequestsProvider>().onerequestdone();
    } else {
      confirmedmap = {};
    }
    Provider.of<HomePageProvider>(ctx, listen: false).Stoploading();

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
    sentmap.clear();
  }

  Future<void> uploadDocument(
      BuildContext context, String requestuid, String requestpushid) async {
    DatabaseEvent databaseevt = await FirebaseDatabase.instance
        .ref()
        .child('users/$usercity/${userdata.uid}/noOfBloodDonations')
        .once();
    print('no of donations: ' + databaseevt.snapshot.value.toString());
    int noofdonations = databaseevt.snapshot.value as int;
    noofdonations++;
    Provider.of<ProfileProvider>(context).updateDonations(noofdonations);
    await FirebaseDatabase.instance
        .ref()
        .child('users/$usercity/${userdata.uid}')
        .update({'noOfBloodDonations': noofdonations});
    await FirebaseDatabase.instance
        .ref()
        .child('requestBloodSection/C1/$requestuid/$requestpushid')
        .update({'status': 'COMPLETED'});
  }

  Future<void> confirmRequest(BuildContext context) async {
    await FirebaseDatabase.instance
        .ref()
        .child('requestBloodSection/$usercity/${userdata.uid}/$k')
        .update({'status': 'CONFIRMED'});
    print(k);
  }

  Future<void> completeandmoveRequest() async {
    print('moved....');

    await FirebaseDatabase.instance
        .ref()
        .child('requestBloodSection/$usercity/${userdata.uid}/$k')
        .update({
      'status': 'COMPLETED AND MOVED',
    });
  }

  Future<void> cancelRequest(
      BuildContext context, String uid, String requestPushID) async {
    await FirebaseDatabase.instance
        .ref()
        .child('requestBloodSection/$usercity/$uid/$requestPushID')
        .update({'status': 'CANCELLED'});
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Request Cancelled')));
  }

  Future<void> cancelCurrentRequest(
      BuildContext context, String uid, String requestPushID) async {
    await FirebaseDatabase.instance
        .ref()
        .child('requestBloodSection/$usercity/$uid/$requestPushID')
        .update({'status': 'CANCELLED'});
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Request Cancelled')));

    print('all requests..................      ');
    context.read<RequestsProvider>().requestcancelled();
  }

  Future<void> check(BuildContext context) async {
    Provider.of<HomePageProvider>(context, listen: false).Startloading();
    DatabaseEvent completedevt = await FirebaseDatabase.instance
        .ref()
        .child('requestBloodSection/$usercity')
        .orderByChild('status')
        .equalTo('COMPLETED')
        .once();
    print(completedevt.snapshot.value);
    if (completedevt.snapshot.value == null) {
      Provider.of<RequestsProvider>(context, listen: false).requestcomplete();
    }
  }
}
