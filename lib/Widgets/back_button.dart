import 'package:flutter/material.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key, this.onPressed}) : super(key: key);
  final VoidCallbackAction? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.arrowLeft,
        color: secondaryText,
      ),
      onPressed: () {
        onPressed;
      },
    );
  }
}
