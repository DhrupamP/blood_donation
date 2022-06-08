import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Widgets/otp_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void verifyNumber(BuildContext context, String number) {
  auth.verifyPhoneNumber(
      phoneNumber: '+91' + number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("logged in suc");
          // Navigator.push(context, MaterialPageRoute(builder: (_) {
          //   return OTPInputScreen();
          // }));
        });
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception.message);
      },
      codeSent: (String verificationID, int? resendToken) {
        verificationIDrecieved = verificationID;
      },
      codeAutoRetrievalTimeout: (String VerificationID) {});
}

void VerifyCode() async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIDrecieved,
      smsCode: otpController.text.toString());
  await auth.signInWithCredential(credential).then((value) {
    print("logged in successfully");
  });
}
