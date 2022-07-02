import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController messagecontroller = TextEditingController();

  @override
  void initState() {
    emailcontroller = TextEditingController();
    messagecontroller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Help',
          style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: h * 2.3),
        ),
        centerTitle: true,
        leading: BackButton(
          color: secondaryText,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 5.27),
        child: ListView(
          children: [
            SizedBox(
              height: h * 4,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: primaryDesign,
                ),
                SizedBox(
                  width: w * 2.78,
                ),
                Text(
                  userdata.city!,
                  style: TextStyle(fontSize: h * 1.8, color: black),
                ),
              ],
            ),
            SizedBox(
              height: h * 1,
            ),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: primaryDesign,
                ),
                SizedBox(
                  width: w * 2.78,
                ),
                Text(
                  userdata.emailAddress!,
                  style: TextStyle(fontSize: h * 1.8, color: black),
                ),
              ],
            ),
            SizedBox(
              height: h * 6,
            ),
            Text(
              'Get In Touch',
              style: TextStyle(
                  fontSize: h * 2.56,
                  color: primaryColor,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: h * 2.5,
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(fontSize: h * 1.79, color: primaryText)),
            ),
            SizedBox(
              height: h * 2.5,
            ),
            Container(
              height: h * 20,
              decoration: BoxDecoration(border: Border.all(color: helpborder!)),
              child: TextField(
                controller: messagecontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: h * 1.79, color: primaryText),
                  hintText: '  Type your message here....',
                ),
              ),
            ),
            SizedBox(
              height: h * 6,
            ),
            ContinueButton(
              bgcolor: primaryDesign,
              txt: 'Send',
              txtColor: white,
            )
          ],
        ),
      ),
    ));
  }
}
