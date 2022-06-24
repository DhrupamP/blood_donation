import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class AllRequests extends StatefulWidget {
  const AllRequests({Key? key}) : super(key: key);

  @override
  _AllRequestsState createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {
  List<RequestModel> completedlist = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return Padding(
      padding: EdgeInsets.only(top: h * 2.88, left: w * 10, right: w * 10),
      child: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('requestBloodSection/$usercity/${userdata.uid}')
            .orderByChild('status')
            .equalTo('COMPLETED')
            .onValue,
        builder: ((context, snapshot1) {
          if (snapshot1.hasData &&
              (snapshot1.data as DatabaseEvent).snapshot.value != null) {
            print('..........//////////.................');
            print((snapshot1.data as DatabaseEvent).snapshot.value);
            Map _completed =
                (snapshot1.data as DatabaseEvent).snapshot.value as Map;
            _completed.forEach((key, value) {
              completedlist.add(RequestModel.fromJson(value));
            }); // List<RequestModel> completed = snapshot.data.snapshot.value;
            return ListView.builder(
                itemCount: completedlist.length,
                itemBuilder: (_, idx) {
                  if (idx == completedlist.length) {
                    completedlist.clear();
                  }
                  return CompletedRequest(
                      patientname: completedlist[idx].patientName,
                      bloodgroup: completedlist[idx].bloodGroup);
                });
          } else {
            if (completedlist.length == 0) {
              return Center(child: Text('No Data'));
            }
            return Center(child: CircularProgressIndicator());
            print('no data');
          }
        }),
      ),
    );
  }
}

class CompletedRequest extends StatelessWidget {
  const CompletedRequest({
    Key? key,
    required this.patientname,
    required this.bloodgroup,
  }) : super(key: key);

  final String? patientname;
  final String? bloodgroup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical! * 1.5),
      child: Container(
        width: SizeConfig.blockSizeHorizontal! * 86.11,
        height: SizeConfig.blockSizeVertical! * 8.63,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: secondaryText!,
            )),
        child: Stack(
          children: [
            Align(
                alignment: const Alignment(-0.9, -0.5),
                child: Text(
                  'Patient Name',
                  style: TextStyle(
                      color: secondaryText,
                      fontSize: SizeConfig.blockSizeVertical! * 1.8),
                )),
            Align(
              alignment: const Alignment(-0.9, 0.5),
              child: Text(
                patientname!,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: SizeConfig.blockSizeVertical! * 1.8),
              ),
            ),
            Align(
              alignment: const Alignment(0.8, 0),
              child: Text(
                '$bloodgroup blood required',
                style: TextStyle(
                    color: otpCursorColor, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
