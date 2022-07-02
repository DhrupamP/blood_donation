import 'package:blood_donation/Screens/edit_story_screen.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/story_screen.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/constants/color_constants.dart';
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
import 'number_input.dart';

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
                    Text(
                      userdata.name ?? 'N/A',
                      style: TextStyle(
                          fontSize: h * 2,
                          color: primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: h * 1,
                    ),
                    Text(
                      'Blood Group: ${userdata.bloodGroup ?? 'N/A'}',
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Container(
                      height: h * 12,
                      width: w * 100,
                      child: FutureBuilder(
                        future: FirebaseDatabase.instance
                            .ref()
                            .child('StorySection/$usercity/${userdata.uid}')
                            .once(),
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
                              stories.forEach((key, value) {
                                userstories.add(StoryModel.fromJson(value));
                              });

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: userstories.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           EditStoryScreen(
                                      //               description:
                                      //                   userstories[index]
                                      //                       .description,
                                      //               imageurl: userstories[index]
                                      //                   .photoURL,
                                      //               Title: userstories[index]
                                      //                   .title),
                                      //     ));
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
                      txt: 'Write Your Story',
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
