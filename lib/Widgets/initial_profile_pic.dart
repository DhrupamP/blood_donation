import 'dart:io';

import 'package:blood_donation/Providers/initial_profile_form_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Size Config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/profile_provider.dart';
import '../constants/color_constants.dart';

class InitialProfileImage extends StatefulWidget {
  const InitialProfileImage({Key? key, this.profilepicurl, this.onpressed})
      : super(key: key);
  final String? profilepicurl;
  final VoidCallback? onpressed;
  @override
  State<InitialProfileImage> createState() => _InitialProfileImageState();
}

class _InitialProfileImageState extends State<InitialProfileImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    File tempfile;
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 17.5,
      width: SizeConfig.blockSizeVertical! * 19,
      child: Stack(children: [
        Align(
          child: CircleAvatar(
            radius: SizeConfig.blockSizeVertical! * 8,
            backgroundColor: Colors.transparent,
            backgroundImage: (widget.profilepicurl == null ||
                    widget.profilepicurl == '' ||
                    context.watch<InitialProfileProvider>().tempProfilePic ==
                        null)
                ? CachedNetworkImageProvider(defaultprofilepic)
                : FileImage(
                        context.watch<InitialProfileProvider>().tempProfilePic!)
                    as ImageProvider,
          ),
          alignment: const Alignment(0, -1),
        ),
        Align(
          alignment: const Alignment(0, 1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: primaryDesign,
              width: SizeConfig.blockSizeHorizontal! * 6.39,
              height: SizeConfig.blockSizeVertical! * 2.88,
              child: GestureDetector(
                onTap: widget.onpressed!,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: SizeConfig.blockSizeVertical! * 2,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
