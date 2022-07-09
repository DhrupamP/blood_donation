import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../l10n/locale_keys.g.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key, this.hper, this.wper, this.onPressed})
      : super(key: key);
  final double? hper;
  final double? wper;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical! * hper!,
          left: SizeConfig.blockSizeHorizontal! * wper!),
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          LocaleKeys.skip.tr(),
          style: TextStyle(color: primaryDesign, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
