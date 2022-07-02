import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Providers/initial_profile_form_provider.dart';
import 'package:blood_donation/Screens/activity.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/Widgets/dropdown_field.dart';
import 'package:blood_donation/Widgets/initial_profile_pic.dart';
import 'package:blood_donation/Widgets/profile_input_field.dart';
import 'package:blood_donation/Widgets/skip_button.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Providers/profile_provider.dart';
import '../Size Config/size_config.dart';
import '../Widgets/profile_image.dart';
import 'package:provider/provider.dart';

import 'number_input.dart';

String? dobtxt;
String? citytxt;

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({Key? key}) : super(key: key);

  @override
  _ProfileFormScreenState createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _bloodgroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  List<String> genders = ['male', 'female', 'others'];
  FocusNode? namefn = FocusNode();
  FocusNode? dobfn = FocusNode();
  FocusNode? emailfn = FocusNode();
  FocusNode? addressfn = FocusNode();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController streetaddresscontroller = TextEditingController();
  String? bloodgroup;
  String? gender;
  String? city;
  String defaultpic =
      'https://firebasestorage.googleapis.com/v0/b/nmo-blood-donation.appspot.com/o/user1.png?alt=media&token=8c7b068f-29da-4beb-9df3-9141f990d343';

  @override
  void initState() {
    super.initState();
    check();
    print(
        FirebaseAuth.instance.currentUser?.phoneNumber.toString().substring(1));
    ProfileFormVM.instance.getCityNames();
    print('helloo');
    namefn = FocusNode();
    dobfn = FocusNode();
    emailfn = FocusNode();
    namecontroller = TextEditingController();
    dobcontroller = TextEditingController();
    emailcontroller = TextEditingController();
    streetaddresscontroller = TextEditingController();
  }

  DateTime? _selectedDate;
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? DateTime(2004) : _selectedDate!,
        firstDate: DateTime(1920),
        lastDate: DateTime(2004));
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        dobcontroller.text = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.blockSizeVertical!;
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          SkipButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return const HomePage();
              }));
            },
            hper: 2,
            wper: 85,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 3),
                  child: Center(
                      child: Text(
                    completeprofile,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: h * 2.5,
                        fontWeight: FontWeight.w800),
                  )),
                ),
                SizedBox(
                  height: h * 2.88,
                ),
                InitialProfileImage(
                  profilepicurl:
                      context.watch<InitialProfileProvider>().profilepicurl,
                  onpressed: () {
                    context
                        .read<InitialProfileProvider>()
                        .addupdateProfilePicture();
                  },
                ),
                SizedBox(
                  height: h * 1.75,
                ),
                ProfileInputField(
                  inputType: TextInputType.text,
                  controller: namecontroller,
                  focusnode: namefn,
                  validate: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  hinttxt: "Name",
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: ProfileInputField(
                        validate: (value) {
                          if (value == null || value == '') {
                            print("null" + value.toString());
                            return "Select DOB";
                          }

                          return null;
                        },
                        inputType: TextInputType.datetime,
                        controller: dobcontroller,
                        focusnode: dobfn,
                        hinttxt: 'Date Of Birth'),
                  ),
                ),
                SizedBox(
                  height: h * 0.75,
                ),
                DropDownField(
                  value: bloodgroup,
                  items: _bloodgroups,
                  hinttext: 'Blood Group',
                  errortxt: 'Select Blood Group',
                  onchanged: (newitem) {
                    setState(() {
                      bloodgroup = newitem;
                    });
                  },
                ),
                DropDownField(
                  value: gender,
                  items: genders,
                  hinttext: 'Gender',
                  errortxt: 'Select Gender',
                  onchanged: (newitem) {
                    setState(() {
                      gender = newitem;
                    });
                  },
                ),
                ProfileInputField(
                  inputType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  focusnode: emailfn,
                  hinttxt: "Email",
                  suffixIcon: Icons.email_outlined,
                  validate: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter name';
                    } else if (!EmailValidator.validate(val, false, true)) {
                      return 'invalid Email';
                    }
                    return null;
                  },
                ),
                DropDownField(
                  value: citytxt,
                  items: cities,
                  hinttext: 'Select City',
                  errortxt: 'Select City',
                  onchanged: (newitem) {
                    setState(() {
                      citytxt = newitem;
                      print(citytxt);
                    });
                  },
                ),
                ProfileInputField(
                  focusnode: addressfn,
                  controller: streetaddresscontroller,
                  hinttxt: 'Street address',
                  validate: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter Street Address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: h * 3,
                ),
                ContinueButton(
                  txt: "Done",
                  txtColor: Colors.white,
                  bgcolor: primaryDesign,
                  onpressed: () async {
                    if (_formKey.currentState!.validate() &&
                        EmailValidator.validate(
                            emailcontroller.text, false, true)) {
                      if (ProfileFormVM.instance.isCityAvailable()) {
                        ProfileFormVM.instance.getCityCode();
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();

                        pref.setString('citycode', citycode!);
                        print("stored locally");
                        context
                            .read<InitialProfileProvider>()
                            .submitimage(citycode!);
                        String? dpurl =
                            Provider.of<ProfileProvider>(context, listen: false)
                                .profilepicurl;
                        UserDetailModel usermodel = UserDetailModel(
                          age: DateTime.now().year - _selectedDate!.year,
                          address: streetaddresscontroller.text.trim(),
                          bloodGroup: bloodgroup,
                          city: ProfileFormVM.instance
                              .getFirstWord(citytxt!)
                              .trim(),
                          dateOfBirth: dobcontroller.text,
                          name: namecontroller.text.trim(),
                          sex: gender,
                          emailAddress: emailcontroller.text.trim(),
                          contactNo: int.parse(FirebaseAuth
                              .instance.currentUser?.phoneNumber
                              .toString()
                              .substring(1) as String),
                          dateOfLastDonationOfBlood: '',
                          isDonatedBloodBefore: false,
                          isMedico: false,
                          medicalCollege: '',
                          nearByBloodBank: '',
                          noOfAchievments: 0,
                          noOfBloodDonations: 0,
                          profilePhoto: dpurl,
                          isAvailable: true,
                        );
                        await ProfileFormVM.instance
                            .addUpdateProfile(context, usermodel);

                        pref.setBool('isinitialprofilecomplete', true);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('City not available')));
                      }
                    }
                  },
                ),
                SizedBox(
                  height: h * 2,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> check() async {
    DatabaseEvent evt = await FirebaseDatabase.instance
        .ref()
        .child('users/C1')
        .orderByKey()
        .equalTo(auth.currentUser!.uid)
        .once();
    print(evt.snapshot.value);
    if (evt.snapshot.value != null) {
      final pref = await SharedPreferences.getInstance();
      pref.setBool('isinitialprofilecomplete', true);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => ActivityPage()), (route) => false);
    }
  }
}
