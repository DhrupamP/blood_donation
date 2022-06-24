import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Screens/donor_profile.dart';
import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:blood_donation/Widgets/donor_item.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Providers/profile_provider.dart';
import 'activity.dart';

int temp = 0;

class AvailableDonors extends StatefulWidget {
  const AvailableDonors({Key? key}) : super(key: key);

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
              'Available Donors',
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: white,
          body: StreamBuilder(
              stream:
                  usersref.orderByChild('isAvailable').equalTo(true).onValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    Map _map = snapshot.data.snapshot.value;
                    _map.forEach((key, value) {
                      completedetails!
                          .add(UserDetailModel.fromJson(value, key));
                      temp = temp + completedetails!.length;
                    });
                    print(completedetails!.length);
                    if (temp == completedetails!.length - 1) {
                      completedetails!.clear();
                      temp = 0;
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
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return DonorProfile(
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
                    return CircularProgressIndicator();
                  }
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
