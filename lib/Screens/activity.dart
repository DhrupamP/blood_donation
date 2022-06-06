import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/requests_page.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool isHome = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          isHome ? HomePage() : RequestsPage(),
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
                          color: isHome ? primaryDesign : focusedTextField,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/home.png",
                            color: isHome ? Colors.white : primaryDesign,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                                color: isHome ? Colors.white : primaryDesign),
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
                          color: isHome ? focusedTextField : primaryDesign,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/request.png",
                            color: isHome ? primaryDesign : Colors.white,
                          ),
                          Text(
                            'Requests',
                            style: TextStyle(
                                color: isHome ? primaryDesign : Colors.white),
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