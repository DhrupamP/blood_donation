import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Screens/complete_profile_sreen.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/Widgets/page_indicator.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Size Config/size_config.dart';
import '../Widgets/actiion_rectangle.dart';
import '../Widgets/action_square.dart';
import '../Widgets/drawer_share_icon.dart';
import '../Widgets/drawer_tile.dart';
import '../Widgets/quote_widget.dart';

GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
int? draweridx = 0;
UserDetailModel userdata = UserDetailModel();
bool isLoading = false;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
    });

    ProfileFormVM.instance.getProfileData();
    ProfileFormVM.instance.getCityNames();
    print(citytxt);
  }

  @override
  Widget build(BuildContext context) {
    PageController _mycontroller = PageController();
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 10, vertical: h * 5),
          child: ListView(
            children: [
              Text(
                'Nishant Singh',
                style: TextStyle(fontSize: h * 3, color: primaryColor),
              ),
              SizedBox(
                height: h * 1.26,
              ),
              Text(
                'Blood Group: O+',
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
                  Text('9328889873')
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
                text: 'Our Experts',
                icon: FontAwesomeIcons.peopleGroup,
              ),
              DrawerTile(
                index: 1,
                text: 'Suggestions',
                icon: FontAwesomeIcons.comment,
              ),
              DrawerTile(
                index: 2,
                text: 'About Us',
                icon: FontAwesomeIcons.circleInfo,
              ),
              DrawerTile(
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
              DrawerShare(
                icon: FontAwesomeIcons.shareNodes,
                text: 'Share the App',
              ),
              DrawerShare(
                icon: FontAwesomeIcons.circleQuestion,
                text: 'Help',
              )
            ],
          ),
        ),
      ),
      key: _scaffoldkey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: w * 4, top: w * 4),
                child: IconButton(
                    onPressed: () {
                      _scaffoldkey.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu)),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: w * 4, top: w * 4),
                child: Container(
                  height: h * 4,
                  width: w * 8.89,
                  child: Image.asset("assets/user1.png"),
                ),
              ),
            ],
          ),
          Container(
            height: h * 85,
            width: w * 86.11,
            child: ListView(
              children: [
                Container(
                  width: w * 100,
                  height: h * 6,
                  child: PageView(
                    controller: _mycontroller,
                    children: [
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
                Text(
                  'Actions',
                  style: TextStyle(
                      color: secondaryText, fontWeight: FontWeight.w800),
                ),
                //1.83
                SizedBox(
                  height: h * 1.83,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionSquare(
                      txt: 'Donate Blood',
                      img: Image.asset("assets/blood_donate.png"),
                      onpressed: () async {
                        print(cities);
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return CompleteProfileFormScreen();
                        }));
                      },
                    ),
                    ActionSquare(
                      txt: 'Send Request',
                      img: Image.asset("assets/send_request.png"),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stories',
                      style: TextStyle(
                          color: secondaryText, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(
                          color: secondaryText, fontWeight: FontWeight.w800),
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
                          height: h * 50,
                        ),
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
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            '10/12/2022',
                            style: TextStyle(color: secondaryText),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
