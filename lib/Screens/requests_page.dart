import 'package:blood_donation/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Size Config/size_config.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 20),
          child: TabBar(
            labelColor: primaryDesign,
            unselectedLabelColor: primaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w700),
            labelPadding: EdgeInsets.only(top: h * 4, bottom: h * 1),
            indicatorWeight: 3,
            indicator: UnderlineTabIndicator(
                insets: EdgeInsets.symmetric(horizontal: w * 10),
                borderSide: BorderSide(width: 3, color: primaryDesign!)),
            tabs: [
              Text(
                'New Requests',
              ),
              Text('All Requests'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: h * 2.88, left: w * 10, right: w * 10),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: h * 2),
                    child: Container(
                      width: w * 86.11,
                      height: h * 14.63,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: secondaryText!,
                          )),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment(-0.9, -0.9),
                              child: Text(
                                'Patient Name',
                                style: TextStyle(
                                    color: secondaryText, fontSize: h * 1.8),
                              )),
                          Align(
                            alignment: Alignment(-0.9, -0.5),
                            child: Text(
                              'Nishant Singh',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: h * 2),
                            ),
                          ),
                          Align(
                            alignment: Alignment(1, -0.9),
                            child: Container(
                              width: w * 30,
                              height: h * 4,
                              child: Text(
                                'Nearest blood bank ABC',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.9, 0.8),
                            child: Container(
                              width: w * 43.89,
                              height: h * 3.38,
                              decoration: BoxDecoration(
                                color: focusedTextField,
                                borderRadius: BorderRadius.circular(63),
                              ),
                              child: Center(
                                child: Text(
                                  'O+ blood requires',
                                  style: TextStyle(color: primaryDesign),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.9, 0.8),
                            child: Container(
                              width: w * 23.33,
                              height: h * 4.38,
                              decoration: BoxDecoration(
                                color: acceptColor,
                                borderRadius: BorderRadius.circular(63),
                              ),
                              child: Center(
                                child: Text(
                                  'Accept',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: h * 2.88, left: w * 10, right: w * 10),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: h * 1.5),
                    child: Container(
                      width: w * 86.11,
                      height: h * 8.63,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: secondaryText!,
                          )),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment(-0.9, -0.5),
                              child: Text(
                                'Patient Name',
                                style: TextStyle(
                                    color: secondaryText, fontSize: h * 1.8),
                              )),
                          Align(
                            alignment: Alignment(-0.9, 0.5),
                            child: Text(
                              'Nishant Singh',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: h * 1.8),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.8, 0),
                            child: Text(
                              'O+ blood required',
                              style: TextStyle(
                                  color: otpCursorColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
