import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Models/story_model.dart';
import 'package:blood_donation/Providers/homepage_provider.dart';
import 'package:blood_donation/Providers/requests_provider.dart';
import 'package:blood_donation/Screens/about_screen.dart';
import 'package:blood_donation/Screens/available_donors_page.dart';
import 'package:blood_donation/Screens/complete_profile_sreen.dart';
import 'package:blood_donation/Screens/help_page.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Screens/our_experts.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:blood_donation/l10n/locale_keys.g.dart';
import 'package:blood_donation/viewModels/login_viewmodel.dart';
import 'package:blood_donation/viewModels/story_viewmodel.dart';
import 'package:blood_donation/viewModels/translateVM.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
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
import '../Widgets/story_widget.dart';
import '../viewModels/request_form_viewmodel.dart';
import 'activity.dart';

List<Widget> allScreens = [OurExperts(), Container(), AboutPage()];
bool? isProfileComplete = false;
int? draweridx = 0;
UserDetailModel userdata = UserDetailModel();
bool isLoading = false;
String profilepic = '';
String? usercitycode = '';
String defaultprofilepic =
    'https://firebasestorage.googleapis.com/v0/b/nmo-blood-donation.appspot.com/o/user1.png?alt=media&token=8c7b068f-29da-4beb-9df3-9141f990d343';
GlobalKey<ScaffoldState> homepagekey = GlobalKey<ScaffoldState>();

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

    print('userdata.uid:  ' + userdata.uid.toString());
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
                key: homepagekey,
                backgroundColor: white,
                appBar: AppBar(
                  backgroundColor: white,
                  elevation: 0,
                  leading: IconButton(
                      onPressed: () {
                        scaffoldkey.currentState?.openDrawer();
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
                            LocaleKeys.actionstxt.tr(),
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
                            txt: LocaleKeys.donateBloodtxt.tr(),
                            img: SvgPicture.asset(
                              "assets/blood_donation.svg",
                              fit: BoxFit.none,
                            ),
                            onpressed: () async {
                              print(cities);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const CompleteProfileFormScreen();
                              }));
                            },
                          ),
                          ActionSquare(
                            txt: LocaleKeys.sendRequesttxt.tr(),
                            img: SvgPicture.asset(
                              "assets/request.svg",
                              fit: BoxFit.none,
                            ),
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
                          img: SvgPicture.asset(
                            'assets/urgent_req.svg',
                            fit: BoxFit.none,
                          ),
                          txt: LocaleKeys.call_for_urgent_txt.tr(),
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
                            LocaleKeys.storiestxt.tr(),
                            style: TextStyle(
                                color: secondaryText,
                                fontWeight: FontWeight.w800),
                          ),
                          Spacer(),
                          Text(
                            LocaleKeys.viewalltxt.tr(),
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
