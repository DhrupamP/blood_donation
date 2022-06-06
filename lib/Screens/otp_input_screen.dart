import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/auth/auth_functions.dart';
import 'package:blood_donation/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Size Config/size_config.dart';
import '../Widgets/continue_button.dart';
import '../Widgets/details_box.dart';
import '../Widgets/otp_textField.dart';
import '../Widgets/resend_code_button.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';

bool isotpEmpty = true;

class OTPInputScreen extends StatefulWidget {
  const OTPInputScreen({Key? key, this.phoneNumber}) : super(key: key);
  final String? phoneNumber;

  @override
  _OTPInputScreenState createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  @override
  void initState() {
    super.initState();
    LoginVM.instance
        .verifyPhone(context, '+91' + widget.phoneNumber.toString());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    FocusNode otpfocusnode = FocusNode();
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            SizedBox(
              height: h * 5.13,
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 3),
              child: DetailsBox(
                  title: enterOTPTitle,
                  details: enterOTPdetails + "${widget.phoneNumber}"),
            ),
            SizedBox(
              height: h * 2.75,
            ),
            Center(
              child:
                  OTPInput(focusnode: otpfocusnode, controller: otpController),
            ),
            SizedBox(
              height: h * 47,
            ),
            ContinueButton(
              txt: "Continue",
              bgcolor: isotpEmpty ? Colors.white : primaryDesign,
              txtColor: isotpEmpty ? primaryDesign : Colors.white,
              onpressed: () {
                LoginVM.instance.SignInWithOTP(otpController.text, context);
              },
            ),
            Center(child: isotpEmpty ? ResendCodeButton() : Container())
          ],
        ),
      ),
    ));
  }
}
