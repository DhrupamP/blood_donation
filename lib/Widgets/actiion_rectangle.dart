import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class ActionRectangle extends StatelessWidget {
  const ActionRectangle({Key? key, this.txt, this.img}) : super(key: key);
  final Image? img;
  final String? txt;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: Container(
        height: SizeConfig.blockSizeVertical! * 14.7,
        width: SizeConfig.blockSizeHorizontal! * 86.11,
        decoration: BoxDecoration(
            border: Border.all(color: primaryText!),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(-0.8, 0),
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: focusedTextField,
                  ),
                  width: SizeConfig.blockSizeHorizontal! * 20.32,
                  height: SizeConfig.blockSizeVertical! * 8.86,
                  child: img),
            ),
            Align(
              alignment: const Alignment(0.1, 0),
              child: SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 30,
                child: Text(
                  txt!,
                  style: TextStyle(
                      color: primaryDesign,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical! * 2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
