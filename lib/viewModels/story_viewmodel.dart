import 'dart:io';
import 'dart:math';

import 'package:blood_donation/Models/story_model.dart';
import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:blood_donation/Providers/storyscreen_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<StoryModel> userstories = [];
// Future<List<StoryModel>> allStories = ;

class StoryViewModel {
  static StoryViewModel instance = StoryViewModel._();

  StoryViewModel._();

  Future<List<StoryModel>> getAllStories() async {
    List<StoryModel> temp = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? code = pref.getString('citycode');

    DatabaseEvent evt = await FirebaseDatabase.instance
        .ref()
        .child('StorySection/$code')
        .once();
    Map map1 = evt.snapshot.value as Map;
    List<Map> maps = [];
    map1.forEach((key, value) {
      maps.add(value);
    });
    maps.forEach((element) {
      element.forEach((key, value) {
        temp.add(StoryModel.fromJson(value));
      });
    });
    print(temp);
    // allStories = temp;
    return temp;
  }

  Future<List<StoryModel>> getUserStories() async {
    userstories.clear();
    List<StoryModel> templist = userstories;
    DatabaseEvent storyevt = await FirebaseDatabase.instance
        .ref()
        .child('StorySection/$usercity/${userdata.uid}')
        .once();
    Map stories = storyevt.snapshot.value as Map;
    stories.forEach((key, value) {
      templist.add(StoryModel.fromJson(value));
    });
    return templist;
  }

  Future<void> addStoryImage(BuildContext context) async {
    print('picking file//....');
    final storyimage = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
    if (storyimage == null) return;
    print('path:  ' + storyimage.files.first.path!.toString());
    Provider.of<StoryProvider>(context, listen: false)
        .showimage(File(storyimage.files.first.path!));
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  Future<void> addStory(BuildContext context, StoryModel story) async {
    try {
      print('storyimg:  ' +
          Provider.of<StoryProvider>(context, listen: false)
              .storyimg
              .toString());
      final storageref = FirebaseStorage.instance.ref();
      String randomID = generateRandomString(5);
      final storyref = storageref
          .child('StorySection/$usercity/${userdata.uid}/story$randomID.jpg');

      await storyref.putFile(
        Provider.of<StoryProvider>(context, listen: false).storyimg!,
        SettableMetadata(
          contentType: "image/jpeg",
        ),
      );
      String? storyurl = await storyref.getDownloadURL();
      story.photoURL = storyurl;
      await FirebaseDatabase.instance
          .ref()
          .child('StorySection/$usercity/${userdata.uid}')
          .push()
          .update(story.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteStory(
      String pushid, BuildContext context, String url) async {
    // print('deleting...');
    // String filename = url.split(RegExp(r'(%2F)..*(%2F)'))[1].split(".")[0];
    // final storageref = FirebaseStorage.instance.ref();
    // print('citycode: ' + usercity.toString());
    // print('uid: ' + userdata.uid.toString());
    // print('filename: ' + filename);
    //
    // final imgref = storageref
    //     .child('StorySection/$usercity/${userdata.uid}/$filename.jpg');
    // await imgref.delete();
    await FirebaseDatabase.instance
        .ref()
        .child('StorySection/$usercity/${userdata.uid}/$pushid')
        .remove()
        .then((value) => Navigator.pop(context));
    print('deleted!');
  }
}
