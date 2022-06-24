import 'package:blood_donation/Providers/homepage_provider.dart';
import 'package:blood_donation/Providers/initial_profile_form_provider.dart';
import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Providers/request_form_provider.dart';
import 'package:blood_donation/Screens/activity.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/onboarding_screen.dart';

int? initscreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initscreen = preferences.getInt('initScreen');
  bool? profileform = preferences.getBool('isinitialprofilecomplete');
  bool? loggedin = preferences.getBool('isloggedin');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ChangeNotifierProvider(create: (_) => InitialProfileProvider()),
      ChangeNotifierProvider(create: (_) => RequestFormProvider())
    ],
    child: MaterialApp(
        theme: ThemeData(fontFamily: 'SegoeUI'),
        home: initscreen == 0 || initscreen == null
            ? const OnBoardingScreen()
            : loggedin == false || loggedin == null
                ? NumberInputScreen()
                : profileform == false || profileform == null
                    ? const NumberInputScreen()
                    : const ActivityPage()),
  ));
}
// adb connect 192.168.1.4:5555
