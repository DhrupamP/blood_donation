import '../Size Config/size_config.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key, required this.profileimg}) : super(key: key);

  final String profileimg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical! * 17.1,
      width: SizeConfig.blockSizeHorizontal! * 35.28,
      child: Stack(children: [
        Align(
          child: Image.asset(
            profileimg,
          ),
          alignment: Alignment(0, -1),
        ),
        Align(
          alignment: Alignment(0, 0.95),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: primaryDesign,
              width: SizeConfig.blockSizeHorizontal! * 6.39,
              height: SizeConfig.blockSizeVertical! * 2.88,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: SizeConfig.blockSizeVertical! * 2,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
