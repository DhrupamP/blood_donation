import 'package:blood_donation/Screens/profile_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginVM {
  static LoginVM instance = LoginVM._();
  LoginVM._();
  String verificationID = '';
  bool codeSent = false;

  void SignInWithOTP(String otpsms, BuildContext context) async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: otpsms,
    );

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (authResult != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const ProfileFormScreen();
      }));
    } else {
      print("failed");
    }
  }

  verifyPhone(context, String phoneNoWithCountryCode) async {
    verfiySuccess(cred) async {}

    verifyFailure(Exception error) {}

    smsCodeSent(String verid, int? forceCodeResend) {
      verificationID = verid;
    }

    autoRetrieve(String verid) {
      verificationID = verid;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNoWithCountryCode,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verfiySuccess,
        verificationFailed: verifyFailure,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }
}
