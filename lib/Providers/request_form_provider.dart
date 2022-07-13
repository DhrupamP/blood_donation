import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/number_input.dart';

class RequestFormProvider extends ChangeNotifier {
  bool isUploadedid = false;
  bool isUploadedbrf = false;
  FilePickerResult? idresult;
  FilePickerResult? brfresult;
  File? brffile;
  String? idurl;
  String? brfurl;

  void uploaded(String docname) async {
    if (docname == 'id') {
      idresult = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf']);
      if (idresult == null) return;
      isUploadedid = true;
      notifyListeners();
    } else if (docname == 'brf') {
      brfresult = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf']);

      if (brfresult == null) return;
      isUploadedbrf = true;
      notifyListeners();
    }
  }

  void SubmitRequestForm() async {
    final storageref = FirebaseStorage.instance.ref();
    final pref = await SharedPreferences.getInstance();
    String? code = pref.getString('citycode');
    print("citycode" + code!);
    File idfile = File(idresult!.files.first.path!);
    final idref = storageref.child('$code/${auth.currentUser?.uid}/id.pdf');
    try {
      await idref.putFile(
          idfile,
          SettableMetadata(
            contentType: 'doc.pdf',
          ));
      idurl = await idref.getDownloadURL();
      notifyListeners();
    } catch (e) {
      print(e);
    }

    brffile = File(brfresult!.files.first.path!);
    final brfref = storageref
        .child('$code/${auth.currentUser?.uid}/blood_requirement_form.pdf');
    try {
      await brfref.putFile(
          brffile!,
          SettableMetadata(
            contentType: 'doc.pdf',
          ));
      brfurl = await brfref.getDownloadURL();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
