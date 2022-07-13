import 'dart:io';

import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Screens/available_donors_page.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/Widgets/profile_input_field.dart';
import 'package:blood_donation/Widgets/profile_textarea.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:blood_donation/l10n/locale_keys.g.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:blood_donation/viewModels/request_form_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/request_form_provider.dart';
import '../Size Config/size_config.dart';
import '../Widgets/dropdown_field.dart';
import '../Widgets/upload_doc_row.dart';
import '../constants/color_constants.dart';
import 'complete_profile_sreen.dart';

class RequestForm extends StatefulWidget {
  const RequestForm({Key? key}) : super(key: key);

  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController patientnamecontroller = TextEditingController();
  TextEditingController patientagecontroller = TextEditingController();
  TextEditingController mainproblemcontroller = TextEditingController();
  FocusNode patientnamefn = FocusNode();
  FocusNode patientagefn = FocusNode();
  FocusNode mainproblemfn = FocusNode();
  String? reqbloodgroup;
  String? nearest;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: secondaryText,
          ),
          title: Text(
            LocaleKeys.requestformtxt.tr(),
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: h * 2.5),
          )),
      body: ListView(
        children: [
          SizedBox(
            height: h * 3.1,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  ProfileInputField(
                    focusnode: patientnamefn,
                    controller: patientnamecontroller,
                    hinttxt: LocaleKeys.patient_name_hint_txt.tr(),
                    inputType: TextInputType.name,
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return LocaleKeys.patient_name_error_txt.tr();
                      }
                      return null;
                    },
                  ),
                  ProfileInputField(
                    focusnode: patientagefn,
                    controller: patientagecontroller,
                    hinttxt: LocaleKeys.patient_age_hint_txt.tr(),
                    inputType: TextInputType.number,
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return LocaleKeys.patient_name_error_txt.tr();
                      }
                      return null;
                    },
                  ),
                  ProfileInputTextArea(
                    focusnode: mainproblemfn,
                    controller: mainproblemcontroller,
                    hinttxt: LocaleKeys.problemhintTxt.tr(),
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return LocaleKeys.problemErrortxt.tr();
                      }
                      return null;
                    },
                  ),
                  DropDownField(
                    value: reqbloodgroup,
                    items: bloodgroups,
                    hinttext: LocaleKeys.bloodgrphinttxt.tr(),
                    errortxt: LocaleKeys.bloodgrpErrortxt.tr(),
                    onchanged: (newitem) {
                      setState(() {
                        reqbloodgroup = newitem;
                      });
                    },
                  ),
                  UploadDocRow(
                    text: LocaleKeys.uploadidtxt.tr(),
                    onpressed: () {
                      context.read<RequestFormProvider>().Uploaded('id');
                    },
                    docname: 'id',
                  ),
                  SizedBox(
                    height: h * 1.3,
                  ),
                  UploadDocRow(
                    text: LocaleKeys.brftxt.tr(),
                    onpressed: () {
                      context.read<RequestFormProvider>().Uploaded('brf');
                    },
                    docname: 'brf',
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 1.4,
                  ),
                  DropDownField(
                    value: nearest,
                    items: ['abcd', 'xyz'],
                    hinttext: LocaleKeys.nearestbloodbanktxt.tr(),
                    errortxt: LocaleKeys.nearestbloodbankerrortxt.tr(),
                    onchanged: (newitem) {
                      setState(() {
                        nearest = newitem;
                      });
                    },
                  ),
                  ContinueButton(
                    txt: LocaleKeys.donetxt.tr(),
                    txtColor: white,
                    bgcolor: primaryDesign,
                    onpressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context.read<RequestFormProvider>().SubmitRequestForm();
                        String? patientidphoto =
                            Provider.of<RequestFormProvider>(context,
                                    listen: false)
                                .idurl;
                        String? brfphoto = Provider.of<RequestFormProvider>(
                                context,
                                listen: false)
                            .brfurl;
                        RequestModel reqdata = RequestModel(
                            nearByBloodBank: nearest,
                            bloodGroup: reqbloodgroup,
                            patientName: patientnamecontroller.text,
                            patientAge: int.parse(patientagecontroller.text),
                            mainProblem: mainproblemcontroller.text,
                            patientIDPhoto: patientidphoto,
                            bloodRequirementForm: brfphoto,
                            dateCreated: DateTime.now().toString(),
                            donorID: "",
                            donorName: "",
                            isResolved: false,
                            patientId: "",
                            requirementType: 'blood',
                            status: 'created',
                            yourLocation: "");
                        await RequestFormVM.instance
                            .addUpdateProfile(context, reqdata);
                        RequestFormVM.instance.getRequestData(context);
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (_) {
                          return AvailableDonors(
                            bloodgroup: reqbloodgroup,
                          );
                        }), (route) => false);
                      }
                    },
                  )
                ],
              ))
        ],
      ),
    ));
  }
} /*isavialable orderby .equalto */
