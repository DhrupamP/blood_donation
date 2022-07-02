import 'package:blood_donation/Screens/home_page.dart';
import 'package:flutter/material.dart';

import '../Screens/profile_screen.dart';
import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class Expert extends StatelessWidget {
  const Expert({
    Key? key,
    this.url,
    this.date,
    this.description,
  }) : super(key: key);
  final String? description;
  final String? date;
  final String? url;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal! * 6.94),
      child: Container(
        height: SizeConfig.blockSizeVertical! * 13.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryText!)),
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 1,
            ),
            StoryImage(
              url: defaultprofilepic,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 0.6,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 48.33,
                  child: Text(
                    description!,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical! * 2.05,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: h * 0.2,
                ),
                Text(
                  'Orthopodiologists',
                  style: TextStyle(color: primaryText, fontSize: h * 1.54),
                ),
                Spacer(),
                Text(
                  date!,
                  style: TextStyle(
                    color: black,
                    fontSize: SizeConfig.blockSizeVertical! * 1.54,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
