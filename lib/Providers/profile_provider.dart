import 'dart:io';

import 'package:blood_donation/Screens/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/number_input.dart';

String? usercity;

class ProfileProvider extends ChangeNotifier {
  String? username;
  String? usergender;
  String? usercontactnumber;
  String? userbloodgrp;
  bool isloading = false;
  String profilepicurl = userdata.profilePhoto == null
      ? defaultprofilepic
      : userdata.profilePhoto!;
  File? tempProfilePic;

  void getdetails(
      String name, String gender, String contact, String bloodgroup) {
    username = name;
    userbloodgrp = bloodgroup;
    usergender = gender;
    usercontactnumber = contact;
    notifyListeners();
  }

  void updatename(String name, String bg) {
    username = name;
    userbloodgrp = bg;
    notifyListeners();
  }

  addupdateProfilePicture() async {
    final profileresult = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
    isloading = true;
    notifyListeners();
    if (profileresult == null) return;
    File profilefile = File(profileresult.files.first.path!);
    tempProfilePic = profilefile;
    notifyListeners();
    final storageref = FirebaseStorage.instance.ref();
    final profileref =
        storageref.child('users/C1/${auth.currentUser!.uid}/profile.jpg');
    try {
      await profileref.putFile(
          profilefile,
          SettableMetadata(
            contentType: "image/jpeg",
          ));
      print('done');
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? code = pref.getString('citycode');
      usercity = pref.getString('citycode');
      print(code);
      print(auth.currentUser!.uid);
      String profileurl = await profileref.getDownloadURL();

      await FirebaseDatabase.instance
          .ref()
          .child("users/$code/${auth.currentUser!.uid}/")
          .update({'profilePhoto': profileurl});

      profilepicurl = profileurl;

      isloading = false;
      notifyListeners();

      print('profile pic updates');
    } catch (e) {
      print(e);
    }
  }
}
