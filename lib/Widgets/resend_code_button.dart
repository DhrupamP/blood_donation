import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Resend Code",
          style: TextStyle(color: primaryText),
        ));
  }
}
