import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class ActionSquare extends StatelessWidget {
  const ActionSquare({Key? key, this.txt, this.img, this.onpressed})
      : super(key: key);
  final Image? img;
  final String? txt;
  final VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: GestureDetector(
        onTap: onpressed,
        child: Container(
          height: SizeConfig.blockSizeVertical! * 17.75,
          width: SizeConfig.blockSizeHorizontal! * 39.44,
          decoration: BoxDecoration(
              border: Border.all(color: primaryText!),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(0, -0.5),
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
                alignment: const Alignment(0, 0.6),
                child: Text(
                  txt!,
                  style: TextStyle(
                      color: primaryDesign,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical! * 2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
