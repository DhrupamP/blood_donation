import 'dart:developer';

import 'package:blood_donation/Screens/available_donors_page.dart';
import 'package:translator/translator.dart';

class TranslateVM {
  Map<String, String> enjson = {
    "patient_name_hint_txt": "   Patient Name",
    "patient_age_hint_txt": "   Patient Age",
    "problemhintTxt": "   Main Problem",
    "bloodgrphinttxt": "   Blood Group",
    "patient_name_error_txt": "Please enter Patient name",
    "patient_age_error_txt": "Please enter Patient age",
    "problemErrortxt": "Please enter the problem",
    "bloodgrpErrortxt": "Select Blood Group",
    "uploadidtxt": "Upload ID",
    "brftxt": "Blood Requirement Form",
    "nearestbloodbanktxt": "Nearest Blood Bank",
    "nearestbloodbankerrortxt": "Please Select Nearest Blood Bank",
  };

  static TranslateVM instance = TranslateVM._();
  TranslateVM._();
  final translator = GoogleTranslator();
  void TranslateToHindi() async {
    Map<String, String> hindimap = {};
    // enjson.forEach((key, value) async {
    //   print('key:  ' + key);
    //   print('val:  ' + value);
    //   Translation temp =
    //       await translator.translate(value, from: 'en', to: 'hi');
    //   hindimap.addAll({key: temp.sourceLanguage.name});
    // });
    for (var entry in enjson.entries) {
      hindimap.addAll(
          await translatetohin(entry.key.toString(), entry.value.toString()));
    }

    // print(enjson.length);
    log(hindimap.toString());
    print(hindimap.length);
  }

  Future<Map<String, String>> translatetohin(String key, String val) async {
    print('started....');
    Map<String, String> temp = {};
    var t = await translator.translate(val, from: 'en', to: 'hi');
    temp = {key: t.text};
    print('done....');
    return temp;
  }
}

Map hindi = {
  "patient_name_hint_txt": "रोगी का नाम",
  "patient_age_hint_txt": "मरीज की आयु",
  "problemhintTxt": "मुख्य समस्या",
  "bloodgrphinttxt": "ब्लड ग्रुप",
  "patient_name_error_txt": "कृपया रोगी का नाम दर्ज करें",
  "patient_age_error_txt": "कृपया रोगी की आयु दर्ज करें",
  "problemErrortxt": "कृपया समस्या दर्ज करें",
  "bloodgrpErrortxt": "रक्त समूह का चयन करें",
  "uploadidtxt": "अपलोड आईडी",
  "brftxt": "रक्त आवश्यकता फार्म",
  "nearestbloodbanktxt": "निकटतम रक्त बैंक",
  "nearestbloodbankerrortxt": "कृपया निकटतम रक्त बैंक का चयन करें"
};
