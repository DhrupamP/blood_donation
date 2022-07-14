import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Screens/donor_profile.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:blood_donation/Widgets/donor_item.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:blood_donation/l10n/locale_keys.g.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation/viewModels/request_form_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Providers/profile_provider.dart';
import '../Widgets/loading_widget.dart';
import 'activity.dart';

int temp = 0;

class AvailableDonors extends StatefulWidget {
  const AvailableDonors(
      {Key? key, this.bloodgroup, this.requestid, this.currentreq})
      : super(key: key);
  final String? bloodgroup;
  final String? requestid;
  final RequestModel? currentreq;
  @override
  _AvailableDonorsState createState() => _AvailableDonorsState();
}

class _AvailableDonorsState extends State<AvailableDonors> {
  DatabaseReference usersref =
      FirebaseDatabase.instance.ref().child('users/$usercity');
  UserDetailModel? detail;
  List<UserDetailModel>? completedetails;
  @override
  void initState() {
    completedetails = [];
    super.initState();
  }

  @override
  void dispose() {
    completedetails!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: BackButton(
              color: secondaryText,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => ActivityPage()),
                    (route) => false);
              },
            ),
            title: Text(
              LocaleKeys.availabledonorstxt.tr(),
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: white,
          body: StreamBuilder(
              stream:
                  usersref.orderByChild('isAvailable').equalTo(true).onValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(userRequest.bloodGroup);
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    completedetails!.clear();
                    Map _map = snapshot.data.snapshot.value;
                    _map.forEach((key, value) {
                      UserDetailModel check =
                          UserDetailModel.fromJson(value, key);
                      if (check.uid == userdata.uid) {
                        return;
                      }
                      if (check.bloodGroup == widget.bloodgroup) {
                        completedetails!
                            .add(UserDetailModel.fromJson(value, key));
                      }
                    });
                    print(completedetails!.length);
                    if (completedetails!.length == 0 ||
                        completedetails == null) {
                      return Center(
                        child: Text('No Donor for required blood group.'),
                      );
                    }

                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.blockSizeHorizontal! * 7.5),
                            child: GridView.builder(
                              itemCount: completedetails!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 71 / 86,
                                mainAxisExtent:
                                    SizeConfig.blockSizeVertical! * 21,
                                crossAxisSpacing: 20,
                                mainAxisSpacing:
                                    SizeConfig.blockSizeVertical! * 3,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                if (completedetails![index].uid == userdata.uid)
                                  return SizedBox();
                                return GestureDetector(
                                    onTap: () {
                                      print('check k  again: ' +
                                          widget.requestid!);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return DonorProfile(
                                          userReq: widget.currentreq,
                                          requestid: widget.requestid,
                                          profilepicurl: completedetails![index]
                                              .profilePhoto,
                                          bloodgroup: completedetails![index]
                                              .bloodGroup,
                                          contact:
                                              completedetails![index].contactNo,
                                          donations: completedetails![index]
                                              .noOfBloodDonations,
                                          donorage: completedetails![index].age,
                                          donorname:
                                              completedetails![index].name,
                                          donorsex: completedetails![index].sex,
                                          donorID: completedetails![index].uid,
                                        );
                                      }));
                                    },
                                    child: DonorItem(
                                      name: completedetails![index].name,
                                      profilephoto:
                                          completedetails![index].profilePhoto,
                                    ));
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(child: MyCircularIndicator());
                  }
                } else {
                  return Center(child: MyCircularIndicator());
                }
              })),
    );
  }
}
