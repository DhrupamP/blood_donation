import 'dart:io';
import 'package:blood_donation/Providers/profile_provider.dart';
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
      usercity = cc;
      print('city:    ' + usercity.toString());

      DatabaseReference profileref = FirebaseDatabase.instance
          .ref('users/$cc/${FirebaseAuth.instance.currentUser?.uid}');
      DatabaseEvent evt = await profileref.once();
      Map<dynamic, dynamic> jsondata =
          evt.snapshot.value as Map<dynamic, dynamic>;
      userdata = UserDetailModel.fromJson(jsondata, auth.currentUser!.uid);
      citytxt = userdata.city! + ' ';
      profilepic = userdata.profilePhoto!;
      Provider.of<ProfileProvider>(ctx, listen: false).profilepicurl =
          userdata.profilePhoto!;
      Provider.of<ProfileProvider>(ctx, listen: false).getdetails(
          userdata.name!,
          userdata.sex!,
          userdata.contactNo!.toString(),
          userdata.bloodGroup!,
          userdata.age!,
          userdata.noOfBloodDonations!);
      // Provider.of<HomePageProvider>(ctx, listen: false).Stoploading();
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

  Future<void> updatename(String name, String bloodgroup) async {
    await FirebaseDatabase.instance
        .ref()
        .child('users/${usercity}/${userdata.uid}')
        .update({'name': name, 'bloodGroup': bloodgroup});
  }

  Future<void> updatebasicdetails(
      int age, String gender, int contact, String dob) async {
    await FirebaseDatabase.instance
        .ref()
        .child('users/${usercity}/${userdata.uid}')
        .update({
      'dateOfBirth': dob,
      'sex': gender,
      'contactNo': contact,
      'age': age
    });
  }

  Future<void> updateBasicDetails(String gender, String dob) async {}

  getRequests() async {
    final pref = await SharedPreferences.getInstance();
    String cc = pref.getString('citycode')!;
    DatabaseEvent evt = await FirebaseDatabase.instance
        .ref()
        .child('users/$cc/${userdata.uid}/requestList')
        .once();
    print(evt.snapshot.value);
  }
}
