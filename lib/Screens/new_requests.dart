import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Models/request_model.dart';
import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Providers/requests_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:blood_donation/Widgets/accepted_request.dart';
import 'package:blood_donation/Widgets/current_request.dart';
import 'package:blood_donation/Widgets/new_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../Widgets/loading_widget.dart';
import '../Widgets/sentRequest.dart';
import '../l10n/locale_keys.g.dart';
import '../viewModels/request_form_viewmodel.dart';
import 'package:provider/provider.dart';

class NewRequestsPage extends StatefulWidget {
  const NewRequestsPage({Key? key}) : super(key: key);

  @override
  _NewRequestsPageState createState() => _NewRequestsPageState();
}

class _NewRequestsPageState extends State<NewRequestsPage> {
  List<Request>? requestsdetails;
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void initState() {
    requestsdetails = [];
    RequestFormVM.instance.getCityCodeFromSharedPref();
    RequestFormVM.instance.getRequestData(context);
    print(code);
    print(acceptedRequest.patientName);
    super.initState();
  }

  @override
  void dispose() {
    requestsdetails!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        rebuildAllChildren(context);
      },
      child: ListView(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 3,
          ),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child(
                      'users/$usercity/${auth.currentUser!.uid}/requestList/')
                  .onValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  Map _map = snapshot.data.snapshot.value ?? {};

                  _map.forEach((key, value) {
                    requestsdetails!.add(Request.fromJson(value));
                  });
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: SizeConfig.blockSizeVertical! * 50,
                      maxWidth: 300.0,
                      minHeight: 0,
                      minWidth: 200.0,
                    ),
                    // width: SizeConfig.blockSizeHorizontal! * 100,
                    // height: SizeConfig.blockSizeVertical! * 14.63,

                    child: ListView.builder(
                        itemCount: requestsdetails!.length,
                        itemBuilder: (context, idx) {
                          String temprequid =
                              requestsdetails![idx].requestUid.toString();
                          String tempreqpushid =
                              requestsdetails![idx].requestId.toString();
                          return FutureBuilder(
                              future: getReqIdData(
                                  requestsdetails![idx].requestId!,
                                  requestsdetails![idx].requestUid!),
                              builder: (context, snapshot) {
                                if (idx == requestsdetails!.length - 1) {
                                  requestsdetails!.clear();
                                }
                                if (snapshot.hasData) {
                                  RequestModel temp =
                                      snapshot.data as RequestModel;
                                  print(temp.status);
                                  if (temp.status == 'SENT' ||
                                      temp.status == 'ACCEPTED') {
                                    return NewRequest(
                                      nearestbank: temp.nearByBloodBank,
                                      patientbloodgroup: temp.bloodGroup,
                                      patientname: temp.patientName,
                                      requestUid: temprequid,
                                      requestPushId: tempreqpushid,
                                      status: temp.status,
                                    );
                                  } else if (temp.status == 'CONFIRMED') {
                                    return AcceptedRequest(
                                      requestPushId: tempreqpushid,
                                      requestUid: temprequid,
                                      status: temp.status,
                                      patientname: temp.patientName,
                                      nearestbank: temp.nearByBloodBank,
                                    );
                                  } else if (temp.status == 'COMPLETED') {
                                    return AcceptedRequest(
                                      requestPushId: tempreqpushid,
                                      requestUid: temprequid,
                                      status: temp.status,
                                      patientname: temp.patientName,
                                      nearestbank: temp.nearByBloodBank,
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                } else {
                                  return Center(child: Container());
                                }
                              });
                        }),
                  );
                } else {
                  // if (requestsdetails!.isEmpty) {
                  //   return Center(child: Text('No Request'));
                  // }
                  return Center(child: MyCircularIndicator());
                }
              }),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child(
                      'requestBloodSection/$usercity/${auth.currentUser!.uid}/$k/status')
                  .onValue,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  print("data..............");
                  print((snapshot.data! as DatabaseEvent).snapshot.value);

                  if ((snapshot.data! as DatabaseEvent)
                          .snapshot
                          .value
                          .toString() ==
                      'COMPLETED') {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      Provider.of<RequestsProvider>(context, listen: false)
                          .requestcomplete();
                      RequestFormVM.instance.completeandmoveRequest();
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     content: Text(LocaleKeys.requestcompletedtxt.tr())));
                    });
                  }
                  print(k);

                  return CurrentRequest(
                    requestUid: userdata.uid,
                    status: (snapshot.data! as DatabaseEvent)
                        .snapshot
                        .value
                        .toString(),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ],
      ),
    );
  }
}

Future<RequestModel> getReqIdData(String reqid, String uid) async {
  DatabaseEvent evt = await FirebaseDatabase.instance
      .ref()
      .child('requestBloodSection/$usercity/$uid/$reqid')
      .once();
  Map<dynamic, dynamic> jsondata = evt.snapshot.value as Map<dynamic, dynamic>;
  RequestModel req = RequestModel.fromJson(jsondata);
  return req;
}

Future<void> delayedFunction(Duration time) async {
  await Future.delayed(time);
}
