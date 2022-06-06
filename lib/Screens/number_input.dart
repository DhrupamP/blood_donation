import 'package:blood_donation/Screens/otp_input_screen.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Size Config/size_config.dart';
import '../Widgets/details_box.dart';
import '../Widgets/number_input_field.dart';

SnackBar invalidNumber = SnackBar(content: Text('Invalid Phone Number'));

FirebaseAuth auth = FirebaseAuth.instance;
String verificationIDrecieved = '';

bool isEmpty = true;

class NumberInputScreen extends StatefulWidget {
  const NumberInputScreen({Key? key}) : super(key: key);

  @override
  _NumberInputScreenState createState() => _NumberInputScreenState();
}

class _NumberInputScreenState extends State<NumberInputScreen> {
  FocusNode numberfocusnode = FocusNode();
  TextEditingController numbercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: h * 5.13,
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 3),
              child: DetailsBox(
                  title: numberInputTitle, details: numberInputDetails),
            ),
            SizedBox(
              height: h * 2.75,
            ),
            NumberInputField(
                controller: numbercontroller, focusnode: numberfocusnode),
            SizedBox(
              height: h * 51.88,
            ),
            ContinueButton(
              txt: "Send OTP",
              bgcolor: isEmpty ? Colors.white : primaryDesign,
              txtColor: isEmpty ? primaryDesign : Colors.white,
              onpressed: () {
                if (numbercontroller.text.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(invalidNumber);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return OTPInputScreen(
                      phoneNumber: numbercontroller.text,
                    );
                  }));
                }
              },
            )
          ],
        ),
      ),
    ));
  }
}
