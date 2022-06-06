import 'package:blood_donation/Screens/profile_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import '../Models/profile_data_model.dart';
import '../Screens/home_page.dart';

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

  Future<void> getProfileData() async {
    DatabaseReference profileref = FirebaseDatabase.instance
        .ref('users/C1/${FirebaseAuth.instance.currentUser?.uid}');
    DatabaseEvent evt = await profileref.once();
    Map<dynamic, dynamic> jsondata =
        evt.snapshot.value as Map<dynamic, dynamic>;
    userdata = UserDetailModel.fromJson(jsondata);
    print('citytxt = ' + userdata.city!);
    citytxt = userdata.city! + ' ';
    print('data recieved');
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
}
