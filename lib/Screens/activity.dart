import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/requests_page.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/viewModels/story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/requests_provider.dart';
import '../Size Config/size_config.dart';
import '../viewModels/profile_form_viewmodel.dart';
import '../viewModels/request_form_viewmodel.dart';

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
    // StoryViewModel.instance.getAllStories();

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
      body: Stack(
        children: [
          isHome! ? const HomePage() : const RequestsPage(),
          Align(
            alignment: const Alignment(0, 0.9),
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
                      // RequestFormVM.instance.check(context);
                      // RequestFormVM.instance.getRequestData(context);

                      // if()
                      // Provider.of<RequestsProvider>(context, listen: false)
                      //     .requestcomplete();

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
                            'Home',
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
                            'Requests',
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
