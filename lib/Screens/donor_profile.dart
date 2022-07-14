import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Screens/activity.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:blood_donation/viewModels/request_form_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../Models/request_model.dart';
import '../Providers/requests_provider.dart';
import '../Size Config/size_config.dart';
import '../l10n/locale_keys.g.dart';

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
      this.donorID,
      this.requestid,
      this.userReq})
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
  final String? requestid;
  final RequestModel? userReq;
  @override
  _DonorProfileState createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  bool ignoringSentBtn = false;
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
              'Donor Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: h * 2.3,
                  fontWeight: FontWeight.w900),
            ),
            centerTitle: true,
            backgroundColor: primaryDesign,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesomeIcons.arrowLeftLong,
                color: Colors.white,
              ),
            ),
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
                        '${LocaleKeys.bloodgrouptxt.tr()}: ${widget.bloodgroup ?? 'N/A'}',
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
                          setState(() {
                            ignoringSentBtn = true;
                          });
                          await RequestFormVM.instance.getRequestData(context);
                          widget.userReq!.status = 'SENT';
                          widget.userReq!.donorName =
                              widget.donorname.toString();
                          widget.userReq!.donorID = widget.donorID.toString();
                          Request newrequest = Request(
                              requestedBy: userdata.name,
                              requestUid: userdata.uid,
                              requestId: widget.requestid);
                          await ProfileFormVM.instance
                              .addRequest(newrequest, widget.donorID!);
                          await RequestFormVM.instance.UpdateProfile(
                              context, widget.userReq!, widget.requestid!);
                          context.read<RequestsProvider>().onerequestdone();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => ActivityPage()),
                              (route) => false);

                          print(widget.userReq!.status);
                        },
                        child: IgnorePointer(
                          ignoring: ignoringSentBtn,
                          child: Container(
                            decoration: BoxDecoration(
                                color:
                                    ignoringSentBtn ? Colors.grey : acceptColor,
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
                                  LocaleKeys.sendRequesttxt.tr(),
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 4.63,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocaleKeys.basicdetailstxt.tr(),
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
                                    LocaleKeys.agetxt.tr(),
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    LocaleKeys.sextxt.tr(),
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    LocaleKeys.contactnumbertxt.tr(),
                                    style: detailsStyle,
                                  ),
                                  Text(
                                    LocaleKeys.no_of_donation_txt.tr(),
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
                            LocaleKeys.donationphotostxt.tr(),
                            style: TextStyle(
                                color: secondaryText,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            LocaleKeys.viewalltxt.tr(),
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
                          LocaleKeys.achievementstxt.tr(),
                          style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: h * 20.5,
                        width: w * 73.24,
                        child: Center(
                            child: Text(LocaleKeys.achievementstxt.tr())),
                      ),
                      SizedBox(
                        height: h * 3,
                      ),
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
