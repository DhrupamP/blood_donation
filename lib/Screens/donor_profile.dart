import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:blood_donation/viewModels/request_form_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/request_model.dart';
import '../Size Config/size_config.dart';

class DonorProfile extends StatefulWidget {
  const DonorProfile(
      {Key? key,
      this.donorname,
      this.donorage,
      this.profilepicurl,
      this.bloodgroup,
      this.donorsex,
      this.isAvailable,
      this.contact,
      this.donations,
      this.donorID})
      : super(key: key);
  final String? donorname;
  final int? donorage;
  final String? donorsex;
  final int? contact;
  final int? donations;
  final String? bloodgroup;
  final bool? isAvailable;
  final String? profilepicurl;
  final String? donorID;
  @override
  _DonorProfileState createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryDesign,
            child: Icon(Icons.phone),
            onPressed: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: widget.contact.toString(),
              );
              await launchUrl(launchUri);
            },
          ),
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'My Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: h * 2.3,
                  fontWeight: FontWeight.w900),
            ),
            centerTitle: true,
            backgroundColor: primaryDesign,
            leading: Icon(
              FontAwesomeIcons.arrowLeftLong,
              color: Colors.white,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: w * 5),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: white,
                        fontSize: h * 1.8,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              SizedBox(
                height: h * 25,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        color: primaryDesign,
                        height: h * 5,
                      ),
                      alignment: Alignment(0, -1),
                    ),
                    Positioned(
                      top: -h * 5,
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryDesign,
                          ),
                          height: h * 20,
                          width: w * 100,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.5),
                      child: Container(
                          height: h * 21.38,
                          width: h * 21.38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(w * 1),
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  widget.profilepicurl.toString()),
                            ),
                          )),
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
                        widget.donorname ?? 'N/A',
                        style: TextStyle(
                            fontSize: h * 2,
                            color: primaryColor,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: h * 1,
                      ),
                      Text(
                        'Blood Group: ${widget.bloodgroup ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: h * 1.8,
                          color: primaryText,
                        ),
                      ),
                      SizedBox(
                        height: h * 2.25,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await RequestFormVM.instance.getRequestData(context);
                          currentuserRequest.status = 'SENT';
                          currentuserRequest.donorName =
                              widget.donorname.toString();
                          currentuserRequest.donorID =
                              widget.donorID.toString();
                          Request newrequest = Request(
                              requestedBy: userdata.name,
                              requestUid: userdata.uid,
                              requestId: k);
                          await ProfileFormVM.instance
                              .addRequest(newrequest, widget.donorID!);
                          await RequestFormVM.instance
                              .UpdateProfile(context, currentuserRequest);
                          print(currentuserRequest.status);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: acceptColor,
                              borderRadius: BorderRadius.circular(36)),
                          height: h * 4.38,
                          width: w * 53.61,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.paperPlane,
                                color: white,
                                size: h * 2.05,
                              ),
                              SizedBox(
                                width: w * 4,
                              ),
                              Text(
                                'Send Request',
                                style: TextStyle(
                                    color: white, fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                        ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Age',
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    'Sex',
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    'Contact Number',
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    'Number of Donations',
                                    style: detailsStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    widget.donorname.toString(),
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    widget.donorsex ?? 'N/A',
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    widget.contact.toString(),
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    widget.donations.toString(),
                                    style: detailsStyle,
                                  )
                                ],
                              )
                            ],
                          )),
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
                      SizedBox(
                        height: h * 3,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'My Achievements',
                          style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.w800),
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
                      // Container(
                      //   child: ContinueButton(
                      //     txt: 'Download Certificate',
                      //     txtColor: Colors.white,
                      //     icon: FontAwesomeIcons.download,
                      //     iconColor: Colors.white,
                      //     bgcolor: primaryDesign,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: h * 2,
                      // ),
                      // ContinueButton(
                      //   txt: 'Share App',
                      //   txtColor: Colors.white,
                      //   icon: FontAwesomeIcons.shareNodes,
                      //   iconColor: Colors.white,
                      //   bgcolor: sharebg,
                      //   borderColor: Colors.transparent,
                      // ),
                      SizedBox(
                        height: h * 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

TextStyle detailsStyle =
    TextStyle(color: primaryText, fontWeight: FontWeight.w700);

class myclipper extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(1, 0, 200, 100);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
