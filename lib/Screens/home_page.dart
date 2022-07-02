import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Models/story_model.dart';
import 'package:blood_donation/Providers/homepage_provider.dart';
import 'package:blood_donation/Providers/requests_provider.dart';
import 'package:blood_donation/Screens/available_donors_page.dart';
import 'package:blood_donation/Screens/complete_profile_sreen.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/viewModels/login_viewmodel.dart';
import 'package:blood_donation/viewModels/story_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:blood_donation/Providers/requests_provider.dart';
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
import '../Size Config/size_config.dart';
import '../Widgets/actiion_rectangle.dart';
import '../Widgets/action_square.dart';
import '../Widgets/drawer_share_icon.dart';
import '../Widgets/drawer_tile.dart';
import '../Widgets/quote_widget.dart';
import 'package:provider/provider.dart';
import '../Providers/profile_provider.dart';
import '../viewModels/request_form_viewmodel.dart';

bool? isProfileComplete = false;
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
    // ProfileFormVM.instance.getProfileData(context);
    // RequestFormVM.instance.getRequestData(context);
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
                        GestureDetector(
                          onTap: () async {
                            print("signing out....");
                            await LoginVM.instance.signout();
                            print("logged out");
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
                                  'Log Out',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
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
                body: SizedBox(
                  height: h * 100,
                  width: w * 100,
                  child: ListView(
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
                              print(Provider.of<RequestsProvider>(context,
                                      listen: false)
                                  .pcreatedmap);
                              if (userRequest.status == 'created') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AvailableDonors()));
                              } else if (!Provider.of<RequestsProvider>(context,
                                      listen: false)
                                  .sendnewreq) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Only one request can be sent.')));
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 6.94),
                        child: ActionRectangle(
                          img: Image.asset('assets/urgent_req.png'),
                          txt: "Call for Urgent Requirement",
                        ),
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
                        height: 1000,
                        child: FutureBuilder(
                            future: StoryViewModel.instance.getAllStories(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.active:
                                case ConnectionState.waiting:
                                  return Center(
                                      child: CircularProgressIndicator());
                                case ConnectionState.done:
                                  print("DONE");
                                  if (snapshot.data != null) {
                                    List<StoryModel> all =
                                        snapshot.data as List<StoryModel>;

                                    print("snapdata:  " +
                                        snapshot.data.toString());

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: all.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Story(
                                              description:
                                                  all[index].description,
                                              date: all[index].postCreationDate,
                                              url: all[index].photoURL),
                                        );
                                      },
                                    );
                                  }
                              }
                              return SizedBox();
                            }),
                      )
                    ],
                  ),
                ),
              ));
  }
}

class Story extends StatelessWidget {
  const Story({
    Key? key,
    this.url,
    this.date,
    this.description,
  }) : super(key: key);
  final String? description;
  final String? date;
  final String? url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal! * 6.94),
      child: Container(
        height: SizeConfig.blockSizeVertical! * 13.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryText!)),
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 1,
            ),
            StoryImage(
              url: url,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 0.6,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 48.33,
                  child: Text(
                    description!,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical! * 1.54,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Spacer(),
                Text(
                  date!,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: SizeConfig.blockSizeVertical! * 1.54,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
