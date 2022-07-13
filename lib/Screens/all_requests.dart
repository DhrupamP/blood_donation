import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Models/request_model.dart';
import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood_donation/Providers/requests_provider.dart';

import '../Widgets/loading_widget.dart';
import '../constants/color_constants.dart';
import '../l10n/locale_keys.g.dart';

List<RequestModel> sentrequests = [];
List<Request> recievedrequests = [];
List<RequestModel> recievedrequestModels = [];
List<RequestModel> allrequests = [];

class AllRequests extends StatefulWidget {
  const AllRequests({Key? key}) : super(key: key);

  @override
  _AllRequestsState createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllRequestsList(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    allrequests.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return Padding(
      padding: EdgeInsets.only(top: h * 2.88, left: w * 10, right: w * 10),
      child: Provider.of<RequestsProvider>(context).isLoading
          ? Center(child: MyCircularIndicator())
          : ListView.builder(
              itemCount: allrequests.length,
              itemBuilder: (context, index) {
                if (allrequests.length == 0) {
                  return Center(
                    child: Text('No Data'),
                  );
                }
                print(allrequests.length);
                if (index == allrequests.length) {
                  allrequests.clear();
                }
                return CompletedRequest(
                    patientname: allrequests[index].patientName,
                    bloodgroup: allrequests[index].bloodGroup);
              },
            ),
    );
  }
}

Future<void> getAllRequestsList(BuildContext ctx) async {
  Provider.of<RequestsProvider>(ctx, listen: false).startloading();
  allrequests.clear();
  sentrequests.clear();
  recievedrequests.clear();
  recievedrequestModels.clear();
  DatabaseEvent evt1 = await FirebaseDatabase.instance
      .ref()
      .child('requestBloodSection/$usercity/${userdata.uid}')
      .once();
  print('evt1:  ' + evt1.snapshot.value.toString());
  if (evt1.snapshot.value != null) {
    Map map1 = evt1.snapshot.value as Map;
    map1.forEach((key, value) {
      sentrequests.add(RequestModel.fromJson(value));
    });
    sentrequests.forEach((element) {
      if (element.status == 'COMPLETED AND MOVED' ||
          element.status == 'CANCELLED') {
        allrequests.add(element);
      }
    });
  }

  DatabaseEvent evt2 = await FirebaseDatabase.instance
      .ref()
      .child('users/$usercity/${userdata.uid}/requestList')
      .once();
  print('evt2:  ' + evt2.snapshot.value.toString());
  if (evt2.snapshot.value != null) {
    Map map2 = evt2.snapshot.value as Map;
    map2.forEach((key, value) {
      recievedrequests.add(Request.fromJson(value));
    });
    await Future.forEach(recievedrequests, (element) async {
      Request e = element as Request;
      DatabaseEvent temp = await FirebaseDatabase.instance
          .ref()
          .child(
              'requestBloodSection/$usercity/${element.requestUid}/${element.requestId}')
          .once();
      print('tempevt:  ' + temp.snapshot.value.toString());
      Map tempmap = temp.snapshot.value as Map;
      RequestModel temprm = RequestModel.fromJson(tempmap);
      if (temprm.status == 'COMPLETED AND MOVED' ||
          temprm.status == 'CANCELLED') {
        allrequests.add(temprm);
      }
    });
  }
  if (evt1.snapshot.value == null && evt2.snapshot.value == null) {
    Provider.of<RequestsProvider>(ctx, listen: false).stoploading();
  }
  Provider.of<RequestsProvider>(ctx, listen: false).stoploading();
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
                  LocaleKeys.patientnametxt.tr(),
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
                '$bloodgroup ${LocaleKeys.bloodrequiredtxt.tr()}',
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
