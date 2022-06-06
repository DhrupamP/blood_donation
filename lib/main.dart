import 'package:blood_donation/Screens/about_screen.dart';
import 'package:blood_donation/Screens/activity.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Screens/otp_input_screen.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/Screens/profile_screen.dart';
import 'package:blood_donation/Screens/requests_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/onboarding_screen.dart';

int? initscreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initscreen = await preferences.getInt('initScreen');
  bool? profileform = await preferences.getBool('isinitialprofilecomplete');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'SegoeUI'),
      home: initscreen == 0 || initscreen == null
          ? OnBoardingScreen()
          : profileform == false || profileform == null
              ? ProfileFormScreen()
              : HomePage()));
}
// adb connect 192.168.1.9:5555
