import 'dart:io';

import 'package:blood_donation/Screens/number_input.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Size Config/size_config.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../viewModels/profile_form_viewmodel.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key, this.profilepicurl}) : super(key: key);
  final String? profilepicurl;
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
    return Container(
      height: SizeConfig.blockSizeVertical! * 17.5,
      width: SizeConfig.blockSizeVertical! * 19,
      child: Stack(children: [
        Align(
          child: CircleAvatar(
              radius: SizeConfig.blockSizeVertical! * 8,
              backgroundImage:
                  widget.profilepicurl == null || widget.profilepicurl == ''
                      ? NetworkImage(widget.profilepicurl!)
                      : NetworkImage(widget.profilepicurl!)),
          alignment: Alignment(0, -1),
        ),
        Align(
          alignment: Alignment(0, 1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: primaryDesign,
              width: SizeConfig.blockSizeHorizontal! * 6.39,
              height: SizeConfig.blockSizeVertical! * 2.88,
              child: GestureDetector(
                onTap: () async {
                  final profileresult = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'jpeg']);

                  if (profileresult == null) return;
                  File profilefile = File(profileresult.files.first.path!);
                  final storageref = FirebaseStorage.instance.ref();
                  final profileref = storageref.child('profile.jpg');
                  print('path::::::::' + profilefile.path);
                  try {
                    await profileref.putFile(
                        profilefile,
                        SettableMetadata(
                          contentType: "image/jpeg",
                        ));
                    print('done');
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    String? code = pref.getString('citycode');
                    print(code);
                    print(auth.currentUser!.uid);
                    String profileurl = await profileref.getDownloadURL();
                    await FirebaseDatabase.instance
                        .ref()
                        .child("users/$code/${auth.currentUser!.uid}/")
                        .update({'profilePhoto': profileurl});
                    print('profile pic updates');
                  } catch (e) {
                    print(e);
                  }
                },
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
