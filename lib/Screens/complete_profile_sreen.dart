import 'package:blood_donation/Models/profile_data_model.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/Widgets/dropdown_field.dart';
import 'package:blood_donation/Widgets/profile_input_field.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:blood_donation/l10n/locale_keys.g.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:blood_donation/viewModels/request_form_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Size Config/size_config.dart';
import '../Widgets/edit_button.dart';
import '../Widgets/profile_image.dart';
import 'package:provider/provider.dart';
import '../Providers/profile_provider.dart';
import 'activity.dart';

final List<String> bloodgroups = [
  'A+',
  'A-',
  'B+',
  'B-',
  'O+',
  'O-',
  'AB+',
  'AB-'
];

class CompleteProfileFormScreen extends StatefulWidget {
  const CompleteProfileFormScreen({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormScreenState createState() =>
      _CompleteProfileFormScreenState();
}

class _CompleteProfileFormScreenState extends State<CompleteProfileFormScreen> {
  final _key = GlobalKey<FormState>();

  List<String> genders = ['male', 'female', 'others'];
  FocusNode? newnamefn = FocusNode();
  FocusNode? dobfn = FocusNode();
  FocusNode? emailfn = FocusNode();
  FocusNode? addressfn = FocusNode();
  bool? isnameEnabled;
  bool? isdobEnabled;
  bool? isbloodgroupEnabled;
  bool? isgenderEnabled;
  bool? isemailEnabled;
  bool? iscityEnabled;
  bool? isaddressEnabled;
  bool? isDonationDateEnabled;
  String? hasdonatedgroup;

  TextEditingController newnamecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController streetaddresscontroller = TextEditingController();
  TextEditingController hasDonatedController = TextEditingController();
  String? bloodgroup;
  String? gender;
  String? city;
  DateTime? hasDonatedDate;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    print('useruid:' + userdata.uid.toString());
    ProfileFormVM.instance.getCityNames();
    newnamefn = FocusNode();
    dobfn = FocusNode();
    emailfn = FocusNode();
    addressfn = FocusNode();
    newnamecontroller = TextEditingController();
    dobcontroller = TextEditingController();
    emailcontroller = TextEditingController();
    streetaddresscontroller = TextEditingController();
    hasDonatedController = TextEditingController();

    //setting data
    if (citytxt != null) {
      hasdonatedgroup = userdata.noOfBloodDonations == 0 ? 'No' : 'yes';
      newnamecontroller.text = userdata.name.toString();
      hasDonatedController.text = (userdata.noOfBloodDonations == 0
              ? ''
              : userdata.dateOfLastDonationOfBlood)
          .toString();
      dobcontroller.text = userdata.dateOfBirth.toString();
      bloodgroup = userdata.bloodGroup;
      gender = userdata.sex;
      print(profilepic);
      emailcontroller.text = userdata.emailAddress.toString();
      streetaddresscontroller.text = userdata.address.toString();
    }

    isnameEnabled = false;
    isdobEnabled = false;
    isbloodgroupEnabled = false;
    isgenderEnabled = false;
    isemailEnabled = false;
    iscityEnabled = false;
    isaddressEnabled = false;
    isDonationDateEnabled = false;
  }

  selectDate(BuildContext context, DateTime? selected,
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selected ?? DateTime(2004),
        firstDate: DateTime(1920),
        lastDate: DateTime(2004));
    if (picked != null) {
      setState(() {
        selected = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        controller.text = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.blockSizeVertical!;

    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: h * 100,
        width: SizeConfig.blockSizeHorizontal! * 100,
        child: ListView(
          children: [
            Stack(
              children: [
                EditButton(
                  onPressed: () {
                    setState(() {
                      isnameEnabled = true;
                      isdobEnabled = true;
                      isDonationDateEnabled = true;
                      isbloodgroupEnabled = true;
                      isgenderEnabled = true;
                      isemailEnabled = true;
                      iscityEnabled = true;
                      isaddressEnabled = true;
                    });
                  },
                  hper: 2,
                  wper: 85,
                ),
              ],
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: h * 3),
                    child: Center(
                        child: Text(
                      LocaleKeys.mydonorprofiletxt.tr(),
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: h * 2.5,
                          fontWeight: FontWeight.w800),
                    )),
                  ),
                  SizedBox(
                    height: h * 2.88,
                  ),
                  ProfileImage(
                      profilepicurl:
                          context.watch<ProfileProvider>().profilepicurl,
                      onpressed: () {
                        context
                            .read<ProfileProvider>()
                            .addupdateProfilePicture();
                      }),
                  SizedBox(
                    height: h * 1.75,
                  ),
                  ProfileInputField(
                    inputType: TextInputType.text,
                    controller: newnamecontroller,
                    focusnode: newnamefn,
                    isEnabled: isnameEnabled,
                    data: 'name',
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return LocaleKeys.pleaseenternametxt.tr();
                      }
                      return null;
                    },
                    hinttxt: LocaleKeys.nametxt.tr(),
                  ),
                  IgnorePointer(
                    ignoring: !isdobEnabled!,
                    child: GestureDetector(
                      onTap: () {
                        selectDate(context, _selectedDate, dobcontroller);
                      },
                      child: AbsorbPointer(
                        child: ProfileInputField(
                            validate: (value) {
                              if (value == null || value == '') {
                                return LocaleKeys.selectdobtxt.tr();
                              }

                              return null;
                            },
                            isEnabled: isdobEnabled,
                            inputType: TextInputType.datetime,
                            controller: dobcontroller,
                            focusnode: dobfn,
                            hinttxt: LocaleKeys.DOBtxt.tr()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.75,
                  ),
                  DropDownField(
                    value: bloodgroup,
                    items: bloodgroups,
                    isEnabled: isbloodgroupEnabled,
                    hinttext: LocaleKeys.bloodgrouptxt.tr(),
                    errortxt: LocaleKeys.selectBloodGrouptxt.tr(),
                    onchanged: (newitem) {
                      setState(() {
                        bloodgroup = newitem;
                      });
                    },
                  ),
                  DropDownField(
                    value: gender,
                    items: genders,
                    isEnabled: isgenderEnabled,
                    hinttext: LocaleKeys.gendertxt.tr(),
                    errortxt: LocaleKeys.selectgendertxt.tr(),
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
                    isEnabled: isemailEnabled,
                    hinttxt: LocaleKeys.emailtxt.tr(),
                    suffixIcon: Icons.email_outlined,
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return LocaleKeys.emailvalidationtxt.tr();
                      } else if (!EmailValidator.validate(val, false, true)) {
                        return LocaleKeys.invalidemail.tr();
                      }
                      return null;
                    },
                  ),
                  DropDownField(
                    value: citytxt,
                    items: cities,
                    isEnabled: iscityEnabled,
                    hinttext: LocaleKeys.cityHintText.tr(),
                    errortxt: LocaleKeys.cityHintText.tr(),
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
                    isEnabled: isaddressEnabled,
                    hinttxt: LocaleKeys.addressHintText.tr(),
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return LocaleKeys.addressvalidationtxt.tr();
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal! * 25),
                    child: Text(
                      LocaleKeys.havedonatedtxt.tr(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: secondaryText, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal! * 40),
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 53,
                      height: h * 3.07,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Row(
                                children: <Widget>[
                                  Transform.scale(
                                    child: Radio(
                                      activeColor: primaryDesign,
                                      value: 'Yes',
                                      groupValue: hasdonatedgroup,
                                      onChanged: (String? value) {
                                        setState(() {
                                          hasdonatedgroup = value;
                                          isDonationDateEnabled = true;
                                        });
                                      },
                                    ),
                                    scale: 1.2,
                                  ),
                                  Text(LocaleKeys.yestxt.tr()),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Row(
                                children: <Widget>[
                                  Transform.scale(
                                    child: Radio(
                                      activeColor: primaryDesign,
                                      value: "No",
                                      groupValue: hasdonatedgroup,
                                      onChanged: (String? value) {
                                        setState(() {
                                          hasdonatedgroup = value;
                                          isDonationDateEnabled = false;
                                        });
                                      },
                                    ),
                                    scale: 1.2,
                                  ),
                                  Text(LocaleKeys.notxt.tr()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 3,
                  ),
                  IgnorePointer(
                    ignoring: !isDonationDateEnabled!,
                    child: GestureDetector(
                      onTap: () {
                        selectDate(
                            context, hasDonatedDate, hasDonatedController);
                      },
                      child: AbsorbPointer(
                        child: ProfileInputField(
                            validate: (value) {
                              if (value == null || value == '') {
                                print("null" + value.toString());
                                return LocaleKeys.donationdatevalidationtxt
                                    .tr();
                              }

                              return null;
                            },
                            isEnabled: isDonationDateEnabled,
                            inputType: TextInputType.datetime,
                            controller: hasDonatedController,
                            focusnode: dobfn,
                            hinttxt: LocaleKeys.donationdate_hinttxt.tr()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 3,
                  ),
                  ContinueButton(
                    txt: LocaleKeys.donetxt.tr(),
                    txtColor: Colors.white,
                    bgcolor: primaryDesign,
                    onpressed: () async {
                      if (_key.currentState!.validate() &&
                          EmailValidator.validate(
                              emailcontroller.text, false, true)) {
                        if (ProfileFormVM.instance.isCityAvailable()) {
                          ProfileFormVM.instance.getCityCode();
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();

                          pref.setString('citycode', citycode!);
                          UserDetailModel usermodel = UserDetailModel(
                            address: streetaddresscontroller.text.trim(),
                            bloodGroup: bloodgroup,
                            city: ProfileFormVM.instance.getFirstWord(citytxt!),
                            dateOfBirth: dobcontroller.text,
                            name: newnamecontroller.text.trim(),
                            sex: gender,
                            emailAddress: emailcontroller.text.trim(),
                            contactNo: int.parse(FirebaseAuth
                                .instance.currentUser?.phoneNumber
                                .toString()
                                .substring(1) as String),
                            dateOfLastDonationOfBlood:
                                hasDonatedController.text,
                            isDonatedBloodBefore: false,
                            isMedico: false,
                            medicalCollege: '',
                            nearByBloodBank: '',
                            noOfAchievments: 0,
                            noOfBloodDonations: 0,
                            profilePhoto: Provider.of<ProfileProvider>(context,
                                    listen: false)
                                .profilepicurl,
                            isAvailable: true,
                          );
                          setState(() {
                            isProfileComplete = true;
                          });
                          await ProfileFormVM.instance
                              .addUpdateProfile(context, usermodel);
                          await ProfileFormVM.instance.getProfileData(context);

                          pref.setBool('isinitialprofilecomplete', true);

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ActivityPage(),
                            ),
                            (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(LocaleKeys.cityValidationtxt.tr())));
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
      ),
    ));
  }
}
