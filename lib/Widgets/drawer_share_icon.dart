import '../Size Config/size_config.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class DrawerShare extends StatefulWidget {
  const DrawerShare({Key? key, this.text, this.icon}) : super(key: key);
  final IconData? icon;
  final String? text;
  @override
  _DrawerShareState createState() => _DrawerShareState();
}

class _DrawerShareState extends State<DrawerShare> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: SizeConfig.blockSizeHorizontal! * 60,
        height: SizeConfig.blockSizeVertical! * 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.93),
        ),
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 2,
            ),
            Icon(widget.icon),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 5,
            ),
            Text(
              widget.text!,
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
