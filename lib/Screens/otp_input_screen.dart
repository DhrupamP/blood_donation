import 'package:blood_donation/Screens/activity.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/viewModels/login_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Size Config/size_config.dart';
import '../Widgets/continue_button.dart';
import '../Widgets/details_box.dart';
import '../Widgets/otp_textField.dart';
import '../Widgets/resend_code_button.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../l10n/locale_keys.g.dart';

bool isotpEmpty = true;
TextEditingController otpController = TextEditingController();

class OTPInputScreen extends StatefulWidget {
  const OTPInputScreen({Key? key, this.phoneNumber}) : super(key: key);
  final String? phoneNumber;

  @override
  _OTPInputScreenState createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  @override
  void initState() {
    otpController = TextEditingController();
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
            const BackButton(),
            SizedBox(
              height: h * 5.13,
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 3),
              child: DetailsBox(
                  title: LocaleKeys.enterOTPTitle.tr(),
                  details: LocaleKeys.enterOTPdetails.tr() +
                      "${widget.phoneNumber}"),
            ),
            SizedBox(
              height: h * 2.75,
            ),
            Center(
              child: OTPInput(focusnode: otpfocusnode),
            ),
            SizedBox(
              height: h * 47,
            ),
            ContinueButton(
              txt: LocaleKeys.continuetxt.tr(),
              bgcolor: isotpEmpty ? Colors.white : primaryDesign,
              txtColor: isotpEmpty ? primaryDesign : Colors.white,
              onpressed: () async {
                await LoginVM.instance
                    .SignInWithOTP(otpController.text, context);
                final pref = await SharedPreferences.getInstance();
                pref.setString('citycode', 'C1');
                pref.setBool('isloggedin', true);
                print("loggedin:  " + pref.getBool('isloggedin').toString());

                // String? code = pref.getString('citycode');
                // DatabaseEvent evt = await FirebaseDatabase.instance
                //     .ref()
                //     .child('users//${auth.currentUser!.uid}')
                //     .once();
                // Map temp = evt.snapshot.value as Map;
                // if (evt.snapshot.value == null) {}
              },
            ),
            Center(child: isotpEmpty ? const ResendCodeButton() : Container())
          ],
        ),
      ),
    ));
  }
}
