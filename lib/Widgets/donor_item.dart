import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';

class DonorItem extends StatelessWidget {
  const DonorItem({Key? key, this.name, this.profilephoto}) : super(key: key);
  final String? name;
  final String? profilephoto;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), border: Border.all()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 15,
              width: w * 37.78,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(
                    profilephoto ?? defaultprofilepic,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: w * 2,
                ),
                Text(
                  'Name',
                  style: TextStyle(
                      color: secondaryText,
                      fontSize: h * 1.4,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: w * 2,
                ),
                Text(
                  name!,
                  style: TextStyle(
                      color: otpCursorColor,
                      fontSize: h * 2.05,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
