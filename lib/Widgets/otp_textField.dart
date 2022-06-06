import 'package:flutter/material.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Screens/otp_input_screen.dart';
import '../Size Config/size_config.dart';

TextEditingController otpController = TextEditingController();

class OTPInput extends StatelessWidget {
  const OTPInput({Key? key, this.focusnode, this.controller}) : super(key: key);
  final FocusNode? focusnode;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal! * 86.68,
      height: SizeConfig.blockSizeVertical! * 7,
      child: PinCodeTextField(
        validator: (value) {},
        controller: controller,
        hintCharacter: "0",
        length: 6,
        appContext: context,
        onChanged: (val) {
          isotpEmpty = val.isEmpty;
        },
        focusNode: focusnode,
        showCursor: true,
        enableActiveFill: true,
        cursorColor: otpCursorColor,
        cursorWidth: 2,
        cursorHeight: SizeConfig.blockSizeHorizontal! * 5.28,
        animationType: AnimationType.none,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            fieldHeight: SizeConfig.blockSizeVertical! * 7,
            fieldWidth: SizeConfig.blockSizeHorizontal! * 12,
            borderRadius: BorderRadius.circular(8),
            selectedColor: primaryDesign,
            activeColor: primaryDesign,
            inactiveColor: Colors.transparent,
            inactiveFillColor: background,
            activeFillColor: focusedTextField,
            selectedFillColor: focusedTextField),
      ),
    );
  }
}
