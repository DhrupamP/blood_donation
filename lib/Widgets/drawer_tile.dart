import 'package:flutter/material.dart';

import '../Screens/home_page.dart';
import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class DrawerTile extends StatefulWidget {
  const DrawerTile({Key? key, required this.index, this.text, this.icon})
      : super(key: key);
  final int index;
  final IconData? icon;
  final String? text;
  @override
  _DrawerTileState createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          draweridx = widget.index;
          Navigator.pop(context);
        });
      },
      child: Container(
        width: SizeConfig.blockSizeHorizontal! * 60,
        height: SizeConfig.blockSizeVertical! * 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.93),
          color: draweridx == widget.index ? focusedTextField : null,
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
