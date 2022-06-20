import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Models/request_model.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:blood_donation/Widgets/current_request.dart';
import 'package:blood_donation/Widgets/new_request.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../viewModels/request_form_viewmodel.dart';

class NewRequestsPage extends StatefulWidget {
  const NewRequestsPage({Key? key}) : super(key: key);

  @override
  _NewRequestsPageState createState() => _NewRequestsPageState();
}

class _NewRequestsPageState extends State<NewRequestsPage> {
  List<Request>? requestsdetails;
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
    return ListView(
      children: [
        SizedBox(
          height: 400,
          child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child('users/C1/${auth.currentUser!.uid}/requestList/')
                  .onValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  Map _map = snapshot.data.snapshot.value ?? {};

                  _map.forEach((key, value) {
                    requestsdetails!.add(Request.fromJson(value));
                  });
                  return ListView.builder(
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
                                return NewRequest(
                                  nearestbank: temp.nearByBloodBank,
                                  patientbloodgroup: temp.bloodGroup,
                                  patientname: temp.patientName,
                                  requestUid: temprequid,
                                  requestPushId: tempreqpushid,
                                );
                              } else {
                                return Center(child: Container());
                              }
                            });
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
        acceptedRequest == null || acceptedRequest.patientName == null
            ? SizedBox()
            : CurrentRequest(requestUid: userdata.uid),
      ],
    );
  }
}

Future<RequestModel> getReqIdData(String reqid, String uid) async {
  DatabaseEvent evt = await FirebaseDatabase.instance
      .ref()
      .child('requestBloodSection/C1/$uid/$reqid')
      .once();
  Map<dynamic, dynamic> jsondata = evt.snapshot.value as Map<dynamic, dynamic>;
  RequestModel req = RequestModel.fromJson(jsondata);
  return req;
}
