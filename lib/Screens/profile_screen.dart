import 'package:blood_donation/Providers/profile_page_provider.dart';
import 'package:blood_donation/Screens/all_user_stories.dart';
import 'package:blood_donation/Screens/edit_story_screen.dart';
import 'package:blood_donation/l10n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/Screens/story_screen.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/Widgets/profile_input_field.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/viewModels/download_viewmodel.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:blood_donation/viewModels/story_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/story_model.dart';
import '../Providers/profile_provider.dart';
import '../Size Config/size_config.dart';
import '../Widgets/dropdown_field.dart';
import '../constants/string_constants.dart';
import 'number_input.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool? editmode;
  bool status2 = true;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  FocusNode dobfn = FocusNode();
  DateTime? _selectedDate;

  selectDate(BuildContext context, DateTime? selected,
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selected ?? DateTime(2004),
        firstDate: DateTime(1920),
        lastDate: DateTime(2004));
    if (picked != null) {
      setState(() {
        selected = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        controller.text = date;
      });
    }
  }

  @override
  void initState() {
    editmode = false;
    namecontroller = TextEditingController();
    dobcontroller = TextEditingController();
    dobfn = FocusNode();
    contactcontroller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: h * 30,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryDesign,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(w * 30),
                              bottomRight: Radius.circular(w * 30))),
                      height: h * 30,
                      width: w * 100,
                    ),
                    top: -h * 10,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment(-0.9, -0.9),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            FontAwesomeIcons.arrowLeftLong,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, -0.9),
                        child: Text(
                          LocaleKeys.myprofiletxt.tr(),
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
                            child: Consumer<ProfilePageProvider>(
                              builder: (context, value, child) {
                                return GestureDetector(
                                  onTap: () {
                                    value.toggleEdit();
                                  },
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
                                  ),
                                );
                              },
                            )),
                      ),
                      Align(
                        alignment: const Alignment(0, 0.5),
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
                                    isProfileComplete ?? false
                                        ? context
                                            .watch<ProfileProvider>()
                                            .profilepicurl
                                        : defaultprofilepic),
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
                    Consumer<ProfilePageProvider>(
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<ProfileProvider>(
                              builder: (context, value, child) {
                                return Text(
                                  value.username ?? 'N/A',
                                  style: TextStyle(
                                      fontSize: h * 2,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700),
                                );
                              },
                            ),
                            value.editmode
                                ? EditProfileButton(
                                    onpressed: () {
                                      print('show dialog');
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            FocusNode namefn = FocusNode();
                                            namecontroller.text =
                                                Provider.of<ProfileProvider>(
                                                        context,
                                                        listen: false)
                                                    .username!;
                                            String? bg =
                                                Provider.of<ProfileProvider>(
                                                        context,
                                                        listen: false)
                                                    .userbloodgrp;
                                            return AlertDialog(
                                              actions: [
                                                Container(
                                                  width: w * 91.11,
                                                  height: h * 27.94,
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ProfileInputField(
                                                        focusnode: namefn,
                                                        hinttxt: LocaleKeys
                                                            .nametxt
                                                            .tr(),
                                                        controller:
                                                            namecontroller,
                                                      ),
                                                      DropDownField(
                                                        value: bg,
                                                        items: bloodgroups,
                                                        hinttext: LocaleKeys
                                                            .bloodgrouptxt
                                                            .tr(),
                                                        errortxt: LocaleKeys
                                                            .selectBloodGrouptxt
                                                            .tr(),
                                                        onchanged: (newitem) {
                                                          bg = newitem;
                                                        },
                                                      ),
                                                      ContinueButton(
                                                        onpressed: () {
                                                          Provider.of<ProfileProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .updatename(
                                                                  namecontroller
                                                                      .text,
                                                                  bg!);

                                                          ProfileFormVM.instance
                                                              .updatename(
                                                                  namecontroller
                                                                      .text,
                                                                  bg!);

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        txt: LocaleKeys.donetxt
                                                            .tr()
                                                            .tr(),
                                                        txtColor: white,
                                                        bgcolor: primaryDesign,
                                                        height: h * 5.38,
                                                        width: w * 85.37,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    },
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: h * 1,
                    ),
                    Consumer<ProfileProvider>(
                      builder: (context, value, child) {
                        return Text(
                          '${LocaleKeys.bloodgrouptxt.tr()}: ${value.userbloodgrp ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: h * 1.8,
                            color: primaryText,
                          ),
                        );
                      },
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
                      inactiveText: LocaleKeys.unavailabletxt.tr(),
                      activeText: LocaleKeys.availabletxt.tr(),
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
                        child: Consumer<ProfilePageProvider>(
                          builder: (context, value, child) {
                            return Row(
                              children: [
                                Text(
                                  LocaleKeys.basicdetailstxt.tr(),
                                  style: TextStyle(color: secondaryText),
                                ),
                                value.editmode
                                    ? EditProfileButton(
                                        onpressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              String? gender =
                                                  Provider.of<ProfileProvider>(
                                                          context,
                                                          listen: false)
                                                      .usergender;
                                              return AlertDialog(
                                                actions: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      selectDate(
                                                          context,
                                                          _selectedDate,
                                                          dobcontroller);
                                                    },
                                                    child: AbsorbPointer(
                                                      child: ProfileInputField(
                                                          validate: (value) {
                                                            if (value == null ||
                                                                value == '') {
                                                              return LocaleKeys
                                                                  .selectdobtxt;
                                                            }

                                                            return null;
                                                          },
                                                          isEnabled: true,
                                                          inputType:
                                                              TextInputType
                                                                  .datetime,
                                                          controller:
                                                              dobcontroller,
                                                          focusnode: dobfn,
                                                          hinttxt: LocaleKeys
                                                              .DOBtxt),
                                                    ),
                                                  ),
                                                  DropDownField(
                                                    value: gender,
                                                    items: bloodgroups,
                                                    hinttext: LocaleKeys
                                                        .gendertxt
                                                        .tr(),
                                                    errortxt: LocaleKeys
                                                        .selectgendertxt
                                                        .tr(),
                                                    onchanged: (newitem) {
                                                      setState(() {
                                                        gender = newitem;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : SizedBox()
                              ],
                            );
                          },
                        )),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  userdata.age.toString(),
                                  style: detailsStyle,
                                ),
                                Text(
                                  userdata.sex ?? 'N/A',
                                  style: detailsStyle,
                                ),
                                Text(
                                  userdata.contactNo.toString(),
                                  style: detailsStyle,
                                ),
                                Text(
                                  userdata.noOfBloodDonations.toString(),
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
                          'Donation Stories',
                          style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.w800),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllUserStories(),
                                ));
                          },
                          child: Text(
                            LocaleKeys.viewalltxt.tr(),
                            style: TextStyle(
                                color: secondaryText,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: h * 2,
                    // ),

                    Container(
                      height: h * 12,
                      width: w * 100,
                      child: StreamBuilder(
                        stream: FirebaseDatabase.instance
                            .ref()
                            .child('StorySection/$usercity/${userdata.uid}')
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if ((snapshot.data as DatabaseEvent)
                                    .snapshot
                                    .value !=
                                null) {
                              userstories.clear();
                              print((snapshot.data as DatabaseEvent)
                                  .snapshot
                                  .value
                                  .runtimeType);
                              Map<dynamic, dynamic> stories =
                                  (snapshot.data as DatabaseEvent)
                                      .snapshot
                                      .value as Map<dynamic, dynamic>;
                              List<String> userStoryPushIDs = [];
                              stories.forEach((key, value) {
                                userStoryPushIDs.add(key);
                                userstories.add(StoryModel.fromJson(value));
                              });

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: userstories.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print('$index' + userStoryPushIDs[index]);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditStoryScreen(
                                                    pushID:
                                                        userStoryPushIDs[index],
                                                    description:
                                                        userstories[index]
                                                            .description,
                                                    imageurl: userstories[index]
                                                        .photoURL,
                                                    Title: userstories[index]
                                                        .title),
                                          ));
                                    },
                                    child: StoryImage(
                                      url: userstories[index].photoURL,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text('No Story'),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: h * 2,
                    ),
                    ContinueButton(
                      txt: LocaleKeys.write_your_story_txt.tr(),
                      txtColor: primaryDesign,
                      bgcolor: Colors.white,
                      icon: Icons.upload_rounded,
                      iconColor: primaryDesign,
                      onpressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => StoryScreen()));
                      },
                    ),
                    SizedBox(
                      height: h * 3,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.myachievementstxt.tr(),
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
                        onpressed: () {
                          DownloadVM.instance.pdfGenerator(
                              userdata.name.toString(),
                              userdata.noOfBloodDonations!,
                              context);
                        },
                        txt: LocaleKeys.downloadCertitxt.tr(),
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
                      txt: LocaleKeys.shareapptxt.tr(),
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
      ),
    );
  }
}

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({Key? key, this.onpressed}) : super(key: key);
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.blockSizeVertical! * 3.46,
        width: SizeConfig.blockSizeHorizontal! * 16.11,
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(focusedTextField),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          onPressed: onpressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.edit_outlined,
                size: SizeConfig.blockSizeVertical! * 1.2,
                color: primaryText,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 1,
              ),
              Text(
                'Edit',
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical! * 1.1,
                    color: primaryText,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ));
  }
}

class StoryImage extends StatelessWidget {
  const StoryImage({Key? key, this.url}) : super(key: key);

  final String? url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          height: SizeConfig.blockSizeVertical! * 12,
          width: SizeConfig.blockSizeVertical! * 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        imageUrl: url!,
        fit: BoxFit.fill,
      ),
    );
  }
}

TextStyle detailsStyle =
    TextStyle(color: primaryText, fontWeight: FontWeight.w700);
