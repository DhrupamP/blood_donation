import 'package:blood_donation/Screens/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Size Config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/profile_provider.dart';
import '../constants/color_constants.dart';
import 'loading_widget.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage(
      {Key? key, this.profilepicurl, this.onpressed, this.height, this.width})
      : super(key: key);
  final String? profilepicurl;
  final VoidCallback? onpressed;
  final double? height;
  final double? width;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * widget.height!,
      width: SizeConfig.blockSizeVertical! * widget.width!,
      child: context.watch<ProfileProvider>().isloading
          ? Center(
              child: MyCircularIndicator(),
            )
          : Stack(children: [
              Align(
                child: CircleAvatar(
                  radius: SizeConfig.blockSizeVertical! * 8,
                  backgroundColor: Colors.transparent,
                  backgroundImage: (widget.profilepicurl == null ||
                          widget.profilepicurl == '')
                      ? CachedNetworkImageProvider(defaultprofilepic)
                      : CachedNetworkImageProvider(widget.profilepicurl!),
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
