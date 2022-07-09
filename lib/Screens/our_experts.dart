import 'package:blood_donation/Widgets/expert_widget.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../l10n/locale_keys.g.dart';

class OurExperts extends StatelessWidget {
  const OurExperts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          LocaleKeys.ourexpertstxt.tr(),
          style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: h * 2.3),
        ),
        centerTitle: true,
        leading: BackButton(
          color: secondaryText,
        ),
      ),
      body: ListView(
        children: [
          Expert(
            description: 'Dr. Conrad',
            date: '4 years Experience',
          )
        ],
      ),
    ));
  }
}
