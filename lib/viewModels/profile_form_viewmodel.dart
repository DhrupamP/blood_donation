import 'dart:io';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/profile_data_model.dart';
import '../Models/request_model.dart';
import '../Providers/homepage_provider.dart';
import '../Screens/home_page.dart';
import '../Screens/number_input.dart';

List<String> cities = [];
List<String> citycodes = [];
String? citycode;
List lst = [];
List<bool> citiesactive = [];
Map<String, String>? codename;

class ProfileFormVM {
  static ProfileFormVM instance = ProfileFormVM._();
  ProfileFormVM._();
  DatabaseReference cityref = FirebaseDatabase.instance.ref('cities');

  Future<void> getCityNames() async {
    DatabaseEvent event = await cityref.once();
    lst = event.snapshot.value as List;

    if (lst.length - 1 != cities.length) {
      for (int i = 1; i < lst.length; i++) {
        citiesactive.add(lst[i]['isActive']);
        citycodes.add(lst[i]['cityCode']);
        cities.add(
            lst[i]['cityName'] + ' ' + isActive(lst[i]['isActive'], i, lst));
      }
    }
  }

  Future<void> getProfileData(BuildContext ctx) async {
    final pref = await SharedPreferences.getInstance();

    isProfileComplete = pref.getBool('isinitialprofilecomplete');
    if (isProfileComplete == true) {
      Provider.of<HomePageProvider>(ctx, listen: false).Startloading();
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? cc = pref.getString('citycode');
      DatabaseReference profileref = FirebaseDatabase.instance
          .ref('users/$cc/${FirebaseAuth.instance.currentUser?.uid}');
      DatabaseEvent evt = await profileref.once();
      Map<dynamic, dynamic> jsondata =
          evt.snapshot.value as Map<dynamic, dynamic>;
      userdata = UserDetailModel.fromJson(jsondata, auth.currentUser!.uid);
      citytxt = userdata.city! + ' ';
      profilepic = userdata.profilePhoto!;
      Provider.of<HomePageProvider>(ctx, listen: false).Stoploading();
      print(userdata.requestList);
    }
  }

  /*
  custom claim(firebase).
  */
  String getFirstWord(String inputString) {
    List<String> wordList = inputString.split(" ");
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return ' ';
    }
  }

  String isActive(bool isactive, int j, List list) {
    if (isactive) {
      return '';
    } else {
      return '(${list[j]['message']})';
    }
  }

  getCityCode() {
    List<String> temp = [];
    for (int j = 0; j < cities.length; j++) {
      temp.add(getFirstWord(cities[j]).trim());
    }

    print(cities.indexOf(citytxt!));
    citycode = 'C' + (cities.indexOf(citytxt!) + 1).toString();
    print(citycode);
  }

  bool isCityAvailable() {
    List<String> temp = [];
    for (int j = 0; j < cities.length; j++) {
      temp.add(getFirstWord(cities[j]).trim());
    }
    int idx = temp.indexOf(getFirstWord(citytxt!).trim());
    print("cityavailabe?");
    return citiesactive[idx];
  }

  addUpdateProfile(BuildContext context, UserDetailModel model) async {
    try {
      print('processing');

      print('citycode' + citycode!);
      await FirebaseDatabase.instance
          .ref()
          .child("users/$citycode/${FirebaseAuth.instance.currentUser!.uid}/")
          .update(model.toJson());
      print('done!!');
    } catch (e) {
      print(e);
    }
  }

  Future<void> addRequest(Request req, String donoruid) async {
    print('adding request............');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cc = pref.getString('citycode');
    await FirebaseDatabase.instance
        .ref()
        .child('users/$cc/$donoruid/requestList')
        .push()
        .update(req.toJson());
  }

  getRequests() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cc = pref.getString('citycode');
    DatabaseEvent evt = await FirebaseDatabase.instance
        .ref()
        .child('users/$cc/${userdata.uid}/requestList')
        .once();
    print(evt.snapshot.value);
  }

  addupdateProfilePicture() async {
    final profileresult = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (profileresult == null) return;
    File profilefile = File(profileresult.files.first.path!);
    final storageref = FirebaseStorage.instance.ref();
    final profileref = storageref.child('profile.jpg');
    try {
      await profileref.putFile(
          profilefile,
          SettableMetadata(
            contentType: "image/jpeg",
          ));
      print('done');
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? code = pref.getString('citycode');
      print(code);
      print(auth.currentUser!.uid);
      String profileurl = await profileref.getDownloadURL();

      await FirebaseDatabase.instance
          .ref()
          .child("users/$code/${auth.currentUser!.uid}/")
          .update({'profilePhoto': profileurl});

      profilepic = profileurl;

      print('profile pic updates');
    } catch (e) {
      print(e);
    }
  }
}
