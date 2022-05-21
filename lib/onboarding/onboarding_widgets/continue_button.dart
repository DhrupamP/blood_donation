import 'package:flutter/material.dart';

import '../../Size Config/size_config.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';

//continue button
class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * 0.07,
      width: SizeConfig.screenWidth! * 0.8611,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.red))),
            backgroundColor: MaterialStateProperty.all(primaryDesign)),
        onPressed: () {},
        child: Text(continuetxt),
      ),
    );
  }
}
