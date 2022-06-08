import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Size Config/size_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool status2 = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: h * 100,
        width: w * 100,
        child: ListView(
          children: [
            SizedBox(
              height: h * 30,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: h * 30,
                      width: w * 100,
                      color: primaryDesign,
                    ),
                    top: -h * 10,
                  ),
                  Stack(
                    children: [
                      const Align(
                        alignment: Alignment(-0.9, -0.9),
                        child: Icon(
                          FontAwesomeIcons.arrowLeftLong,
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, -0.9),
                        child: Text(
                          'My Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: h * 2,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(1, -0.9),
                        child: Container(
                            height: h * 3.38,
                            width: w * 21,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(h * 1.5),
                                    bottomLeft: Radius.circular(h * 1.5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: h * 1.5,
                                  color: primaryDesign,
                                ),
                                SizedBox(
                                  width: w * 1,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: primaryDesign,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            )),
                      ),
                      Align(
                        alignment: const Alignment(0, 0.5),
                        child: Container(
                            height: h * 21.38,
                            width: h * 21.38,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.all(w * 1),
                              child: Image.asset(
                                'assets/user.png',
                                height: h * 20,
                                width: w * 45,
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: h * 3.45),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Dhrupam Patel',
                      style: TextStyle(
                          fontSize: h * 2,
                          color: primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: h * 1,
                    ),
                    Text(
                      'Blood Group: NA',
                      style: TextStyle(
                        fontSize: h * 1.8,
                        color: primaryText,
                      ),
                    ),
                    SizedBox(
                      height: h * 2.25,
                    ),
                    FlutterSwitch(
                      height: h * 4.38,
                      width: w * 30.53,
                      value: status2,
                      onToggle: (val) {
                        setState(() {
                          status2 = val;
                        });
                      },
                      inactiveText: 'Unavailable',
                      activeText: 'Available',
                      activeTextColor: Colors.white,
                      inactiveTextColor: Colors.white,
                      activeColor: acceptColor!,
                      inactiveColor: unavailablecolor!,
                      showOnOff: true,
                    ),
                    SizedBox(
                      height: h * 4.63,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Basic Details',
                        style: TextStyle(color: secondaryText),
                      ),
                    ),
                    SizedBox(
                      height: h * 2,
                    ),
                    Container(
                      height: h * 17.5,
                      width: w * 86.11,
                      decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 10, right: w * 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Age',
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    'NA',
                                    style: detailsStyle,
                                  )
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sex',
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    'NA',
                                    style: detailsStyle,
                                  )
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Contact Number',
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    'NA',
                                    style: detailsStyle,
                                  )
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Number of Donations',
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    'NA',
                                    style: detailsStyle,
                                  )
                                ]),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 3.75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Donation Photos',
                          style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'View all',
                          style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 2,
                    ),
                    ContinueButton(
                      txt: 'Upload Recent Photo',
                      txtColor: primaryDesign,
                      bgcolor: Colors.white,
                      icon: Icons.upload_rounded,
                      iconColor: primaryDesign,
                    ),
                    SizedBox(
                      height: h * 3,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Achievements',
                        style: TextStyle(
                            color: secondaryText, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: h * 20.5,
                      width: w * 73.24,
                      child: const Center(child: Text("achievements")),
                    ),
                    SizedBox(
                      height: h * 3,
                    ),
                    Container(
                      child: ContinueButton(
                        txt: 'Download Certificate',
                        txtColor: Colors.white,
                        icon: FontAwesomeIcons.download,
                        iconColor: Colors.white,
                        bgcolor: primaryDesign,
                      ),
                    ),
                    SizedBox(
                      height: h * 2,
                    ),
                    ContinueButton(
                      txt: 'Share App',
                      txtColor: Colors.white,
                      icon: FontAwesomeIcons.shareNodes,
                      iconColor: Colors.white,
                      bgcolor: sharebg,
                      borderColor: Colors.transparent,
                    ),
                    SizedBox(
                      height: h * 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

TextStyle detailsStyle =
    TextStyle(color: primaryText, fontWeight: FontWeight.w700);
