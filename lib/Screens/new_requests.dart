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
import 'package:blood_donation/constants/color_constants.dart';
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
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return RefreshIndicator(
      onRefresh: () async {
        rebuildAllChildren(context);
      },
      child: SizedBox(
        height: h * 100,
        width: w * 100,
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
                  bool noreqs = true;
                  if (snapshot.data != null) {
                    Map _map = snapshot.data.snapshot.value ?? {};

                    _map.forEach((key, value) {
                      requestsdetails!.add(Request.fromJson(value));
                      if (RequestModel.fromJson(value).status == 'created' ||
                          RequestModel.fromJson(value).status == 'SENT' ||
                          RequestModel.fromJson(value).status == 'ACCEPTED' ||
                          RequestModel.fromJson(value).status == 'COMPLETED' ||
                          RequestModel.fromJson(value).status == 'CONFIRMED') {
                        noreqs = false;
                      } else {
                        noreqs = true;
                      }
                    });
                    return noreqs
                        ? Center(
                            child: Text('No Rquests for you'),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
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
                                      return SizedBox();
                                    }
                                  });
                            });
                  } else {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: MyCircularIndicator());
                    }
                    return Text("No requests");
                  }
                }),
            Divider(
              thickness: 2,
              color: primaryText,
              indent: w * 15,
              endIndent: w * 15,
            ),
            SizedBox(
              height: h * 2,
            ),
            StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child(
                      'requestBloodSection/$usercity/${auth.currentUser!.uid}')
                  .onValue,
              builder: (context, snapshot) {
                {
                  bool noRequests = true;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: MyCircularIndicator());
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      Map userreqs = (snapshot.data as DatabaseEvent)
                          .snapshot
                          .value as Map;
                      List<RequestModel> alluserreqs = [];
                      List<String> userreqids = [];
                      userreqs.forEach((key, value) {
                        userreqids.add(key);
                        alluserreqs.add(RequestModel.fromJson(value));
                        if (RequestModel.fromJson(value).status == 'created' ||
                            RequestModel.fromJson(value).status == 'SENT' ||
                            RequestModel.fromJson(value).status == 'ACCEPTED' ||
                            RequestModel.fromJson(value).status ==
                                'CONFIRMED') {
                          noRequests = false;
                        } else {
                          noRequests = true;
                        }
                      });
                      return noRequests
                          ? Center(child: Text('No Requests by You.'))
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: alluserreqs.length,
                              itemBuilder: (context, index) {
                                print(index);
                                print(alluserreqs[index].status);

                                return CurrentRequest(
                                  req: alluserreqs[index],
                                  k: userreqids[index],
                                );
                              },
                            );
                    } else {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MyCircularIndicator();
                      }
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }
              },
            )
          ],
        ),
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
