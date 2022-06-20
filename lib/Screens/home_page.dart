import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Providers/homepage_provider.dart';
import 'package:blood_donation/Screens/available_donors_page.dart';
import 'package:blood_donation/Screens/complete_profile_sreen.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/Screens/profile_screen.dart';
import 'package:blood_donation/Screens/request_form.dart';
import 'package:blood_donation/Widgets/page_indicator.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:blood_donation/viewModels/request_form_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Size Config/size_config.dart';
import '../Widgets/actiion_rectangle.dart';
import '../Widgets/action_square.dart';
import '../Widgets/drawer_share_icon.dart';
import '../Widgets/drawer_tile.dart';
import '../Widgets/quote_widget.dart';
import 'package:provider/provider.dart';
import '../Providers/profile_provider.dart';
import '../viewModels/request_form_viewmodel.dart';

bool? isProfileComplete;
GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
int? draweridx = 0;
UserDetailModel userdata = UserDetailModel();
bool isLoading = false;
String profilepic = '';
String? usercitycode = '';
String defaultprofilepic =
    'https://firebasestorage.googleapis.com/v0/b/nmo-blood-donation.appspot.com/o/user1.png?alt=media&token=8c7b068f-29da-4beb-9df3-9141f990d343';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController _mycontroller = PageController();
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: context.watch<HomePageProvider>().isloading
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : Scaffold(
                backgroundColor: white,
                drawer: Drawer(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: w * 10, vertical: h * 5),
                    child: ListView(
                      children: [
                        Text(
                          userdata.name ?? 'N/A',
                          style:
                              TextStyle(fontSize: h * 3, color: primaryColor),
                        ),
                        SizedBox(
                          height: h * 1.26,
                        ),
                        Text(
                          'Blood Group: ${userdata.bloodGroup ?? 'N/A'}',
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
                            Text(userdata.contactNo == null
                                ? 'N/A'
                                : userdata.contactNo.toString())
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
                        const DrawerTile(
                          index: 0,
                          text: 'Our Experts',
                          icon: FontAwesomeIcons.peopleGroup,
                        ),
                        const DrawerTile(
                          index: 1,
                          text: 'Suggestions',
                          icon: FontAwesomeIcons.comment,
                        ),
                        const DrawerTile(
                          index: 2,
                          text: 'About Us',
                          icon: FontAwesomeIcons.circleInfo,
                        ),
                        const DrawerTile(
                          index: 3,
                          text: 'Log Out',
                          icon: FontAwesomeIcons.arrowRightFromBracket,
                        ),
                        SizedBox(
                          height: h * 32,
                        ),
                        Divider(
                          color: secondaryText,
                          thickness: 1.5,
                        ),
                        const DrawerShare(
                          icon: FontAwesomeIcons.shareNodes,
                          text: 'Share the App',
                        ),
                        const DrawerShare(
                          icon: FontAwesomeIcons.circleQuestion,
                          text: 'Help',
                        )
                      ],
                    ),
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: white,
                  elevation: 0,
                  leading: IconButton(
                      onPressed: () {
                        _scaffoldkey.currentState?.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: primaryText,
                      )),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: w * 4, top: w * 4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfileScreen()));
                        },
                        child: CircleAvatar(
                          radius: h * 2,
                          backgroundImage: (profilepic == '')
                              ? CachedNetworkImageProvider(defaultprofilepic)
                              : CachedNetworkImageProvider(context
                                  .watch<ProfileProvider>()
                                  .profilepicurl),
                        ),
                      ),
                    ),
                  ],
                ),
                key: _scaffoldkey,
                body: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: w * 100,
                          height: h * 6,
                          child: PageView(
                            controller: _mycontroller,
                            children: const [
                              QuoteWidget(),
                              QuoteWidget(),
                              QuoteWidget(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * 4,
                        ),
                        Center(
                          child: MyPageIndicator(
                            controller: _mycontroller,
                            dotwidth: w * 1.19,
                            dotheight: h * 0.53,
                          ),
                        ),
                        SizedBox(
                          height: h * 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 6.94,
                            ),
                            Text(
                              'Actions',
                              style: TextStyle(
                                  color: secondaryText,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        //1.83
                        SizedBox(
                          height: h * 1.83,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ActionSquare(
                              txt: 'Donate Blood',
                              img: Image.asset("assets/blood_donate.png"),
                              onpressed: () async {
                                print(cities);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return const CompleteProfileFormScreen();
                                }));
                              },
                            ),
                            ActionSquare(
                              txt: 'Send Request',
                              img: Image.asset("assets/send_request.png"),
                              onpressed: () async {
                                print(createdmap);
                                if (!createdmap.isEmpty) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AvailableDonors()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const RequestForm()));
                                }
                                // DatabaseEvent evt = await ref;
                                // print(evt.snapshot.value);
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: h * 3,
                        ),
                        ActionRectangle(
                          img: Image.asset('assets/urgent_req.png'),
                          txt: "Call for Urgent Requirement",
                        ),
                        SizedBox(
                          height: h * 2,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: w * 6.94,
                            ),
                            Text(
                              'Stories',
                              style: TextStyle(
                                  color: secondaryText,
                                  fontWeight: FontWeight.w800),
                            ),
                            Spacer(),
                            Text(
                              'View all',
                              style: TextStyle(
                                  color: secondaryText,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              width: w * 6.94,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 2,
                        ),
                        Container(
                          width: w * 86.11,
                          height: h * 13.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: primaryText!)),
                          child: Row(
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/news_img.png',
                                  height: h * 11.92,
                                ),
                                padding: EdgeInsets.all(h * 0.6),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: w * 48.33,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 4,
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electron",
                                      style: TextStyle(
                                          fontSize: h * 1.54,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    '10/12/2022',
                                    style: TextStyle(
                                      color: secondaryText,
                                      fontSize: h * 1.54,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
  }
}
