import 'package:blood_donation/Widgets/profile_input_field.dart';
import 'package:blood_donation/Widgets/profile_textarea.dart';
import 'package:flutter/material.dart';

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
  TextEditingController patientnamecontroller = TextEditingController();
  TextEditingController patientagecontroller = TextEditingController();
  TextEditingController mainproblemcontroller = TextEditingController();
  FocusNode patientnamefn = FocusNode();
  FocusNode patientagefn = FocusNode();
  FocusNode mainproblemfn = FocusNode();
  String? bloodgroup;
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
            'Request Form',
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
              child: Column(
            children: [
              ProfileInputField(
                focusnode: patientnamefn,
                controller: patientnamecontroller,
                hinttxt: '  Patient Name',
                inputType: TextInputType.name,
              ),
              ProfileInputField(
                focusnode: patientagefn,
                controller: patientagecontroller,
                hinttxt: '  Patient Age',
                inputType: TextInputType.number,
              ),
              ProfileInputTextArea(
                focusnode: mainproblemfn,
                controller: mainproblemcontroller,
                hinttxt: '  Main Problem',
              ),
              DropDownField(
                value: bloodgroup,
                items: bloodgroups,
                hinttext: '  Blood Group',
                errortxt: 'Select Blood Group',
                onchanged: (newitem) {
                  setState(() {
                    bloodgroup = newitem;
                  });
                },
              ),
              const UploadDocRow(
                text: 'Upload ID',
              ),
              SizedBox(
                height: h * 1.3,
              ),
              const UploadDocRow(
                text: 'Blood Requirement Form',
              )
            ],
          ))
        ],
      ),
    ));
  }
}
