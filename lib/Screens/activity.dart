import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/requests_page.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:blood_donation/main.dart';
import 'package:blood_donation/viewModels/navigation_service.dart';
import 'package:blood_donation/viewModels/story_viewmodel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:restart_app/restart_app.dart';
import '../Providers/requests_provider.dart';
import '../Size Config/size_config.dart';
import '../Widgets/drawer_share_icon.dart';
import '../Widgets/drawer_tile.dart';
import '../l10n/locale_keys.g.dart';
import '../viewModels/login_viewmodel.dart';
import '../viewModels/profile_form_viewmodel.dart';
import '../viewModels/request_form_viewmodel.dart';
import 'help_page.dart';
import 'number_input.dart';
import 'onboarding_screen.dart';

String? lang;
GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

bool? isHome;

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    RequestFormVM.instance.getCityCodeFromSharedPref();
    ProfileFormVM.instance.getProfileData(context);
    RequestFormVM.instance.getRequestData(context);

    isHome = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: Scaffold(
      key: scaffoldkey,
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 10, vertical: h * 5),
          child: Consumer<ProfileProvider>(
            builder: (context, value, child) {
              return ListView(
                children: [
                  Text(
                    value.username ?? 'N/A',
                    style: TextStyle(fontSize: h * 3, color: primaryColor),
                  ),
                  SizedBox(
                    height: h * 1.26,
                  ),
                  Text(
                    '${LocaleKeys.bloodgrouptxt.tr()}: ${value.userbloodgrp ?? 'N/A'}',
                    style: TextStyle(
                      color: primaryText,
                    ),
                  ),
                  SizedBox(
                    height: h * 1.08,
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.phone,
                        color: primaryText,
                        size: h * 1.5,
                      ),
                      SizedBox(
                        width: w * 1,
                      ),
                      Text(value.usercontactnumber == null
                          ? 'N/A'
                          : value.usercontactnumber.toString())
                    ],
                  ),
                  SizedBox(
                    height: h * 1.88,
                  ),
                  Divider(
                    color: secondaryText,
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: h * 2.5,
                  ),
                  DrawerTile(
                    index: 0,
                    text: LocaleKeys.ourexpertstxt.tr(),
                    icon: FontAwesomeIcons.peopleGroup,
                  ),
                  DrawerTile(
                    index: 1,
                    text: LocaleKeys.suggestion.tr(),
                    icon: FontAwesomeIcons.comment,
                  ),
                  DrawerTile(
                    index: 2,
                    text: LocaleKeys.aboutus.tr(),
                    icon: FontAwesomeIcons.circleInfo,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await LoginVM.instance.signout();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => NumberInputScreen()),
                          (route) => false);
                    },
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal! * 60,
                      height: SizeConfig.blockSizeVertical! * 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.93),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 2,
                          ),
                          Icon(Icons.logout),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                          Text(
                            LocaleKeys.logout.tr(),
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Language',
                        maxLines: 1,
                        style: TextStyle(color: secondaryText),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 5,
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonWidth: SizeConfig.blockSizeHorizontal! * 15,
                            buttonHeight: SizeConfig.blockSizeVertical! * 3,
                            itemHeight: SizeConfig.blockSizeVertical! * 3.5,
                            dropdownWidth: SizeConfig.blockSizeHorizontal! * 25,
                            alignment: Alignment.center,
                            style: TextStyle(
                              color: secondaryText,
                            ),
                            offset:
                                Offset(0, SizeConfig.blockSizeVertical! * 8.5),
                            value: dropdownvalue,
                            isExpanded: true,
                            underline: const SizedBox(),
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: secondaryText,
                            ),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: items == 'divider'
                                    ? const Divider()
                                    : Text(
                                        items,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) async {
                              BuildContext? hpcontext =
                                  homepagekey.currentContext;
                              if (newValue == 'English') {
                                Navigator.pop(context);
                                await context.setLocale(Locale('en'));
                              } else if (newValue == 'हिन्दी') {
                                Navigator.pop(context);
                                await context.setLocale(Locale('hi'));
                              }
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                              await Restart.restartApp();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: secondaryText,
                    thickness: 1.5,
                  ),
                  DrawerShare(
                    icon: FontAwesomeIcons.shareNodes,
                    text: LocaleKeys.shareapptxt.tr(),
                  ),
                  DrawerShare(
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpPage(),
                          ));
                    },
                    icon: FontAwesomeIcons.circleQuestion,
                    text: LocaleKeys.helptxt.tr(),
                  )
                ],
              );
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          isHome! ? const HomePage() : const RequestsPage(),
          Align(
            alignment: Alignment(0, 0.9),
            child: Container(
              height: h * 8,
              width: w * 65.83,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryDesign!),
                  color: focusedTextField),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isHome = true;
                      });
                    },
                    child: Container(
                      height: h * 6.75,
                      width: w * 29.72,
                      decoration: BoxDecoration(
                          color: isHome! ? primaryDesign : focusedTextField,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/home.png",
                            color: isHome! ? Colors.white : primaryDesign,
                          ),
                          Text(
                            LocaleKeys.home.tr(),
                            style: TextStyle(
                                color: isHome! ? Colors.white : primaryDesign),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isHome = false;
                      });
                    },
                    child: Container(
                      height: h * 6.75,
                      width: w * 29.72,
                      decoration: BoxDecoration(
                          color: isHome! ? focusedTextField : primaryDesign,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/request.png",
                            color: isHome! ? primaryDesign : Colors.white,
                          ),
                          Text(
                            LocaleKeys.requeststxt.tr(),
                            style: TextStyle(
                                color: isHome! ? primaryDesign : Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
