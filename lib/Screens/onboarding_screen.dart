import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Widgets/continue_button.dart';
import '../Widgets/onboarding_page.dart';
import '../Widgets/page_indicator.dart';
import '../Widgets/skip_button.dart';
import '../l10n/locale_keys.g.dart';

var items = ['English', 'हिन्दी'];
String? dropdownvalue = 'English';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: white,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SkipButton(
                  hper: 5,
                  wper: 75,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const HomePage();
                    }));
                  },
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 11.88,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 45,
                  width: SizeConfig.screenWidth,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowIndicator();
                      return false;
                    },
                    child: PageView(
                      controller: controller,
                      children: [
                        OnBoardingPage(
                          img: 'assets/ob1.png',
                          title: LocaleKeys.title1txt.tr(),
                          subtitle: LocaleKeys.subtitle1.tr(),
                        ),
                        OnBoardingPage(
                          img: 'assets/ob2.png',
                          title: LocaleKeys.title2txt.tr(),
                          subtitle: LocaleKeys.subtitle2.tr(),
                        ),
                        OnBoardingPage(
                          img: 'assets/ob3.png',
                          title: LocaleKeys.title3txt.tr(),
                          subtitle: LocaleKeys.subtitle3.tr(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 7,
                ),
                MyPageIndicator(
                  dotheight: SizeConfig.blockSizeVertical! * 1.03,
                  dotwidth: SizeConfig.blockSizeHorizontal! * 2.3,
                  controller: controller,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 3.47,
                ),
                ContinueButton(
                  bgcolor: primaryDesign,
                  txt: LocaleKeys.continuewithnum.tr(),
                  txtColor: Colors.white,
                  onpressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const NumberInputScreen();
                    }));
                  },
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.languagetxt.tr(),
                      maxLines: 1,
                      style: TextStyle(color: secondaryText),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 5,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonWidth: SizeConfig.blockSizeHorizontal! * 15,
                          buttonHeight: SizeConfig.blockSizeVertical! * 3,
                          itemHeight: SizeConfig.blockSizeVertical! * 3.5,
                          dropdownWidth: SizeConfig.blockSizeHorizontal! * 25,
                          alignment: Alignment.center,
                          style: TextStyle(
                            color: secondaryText,
                          ),
                          offset:
                              Offset(0, SizeConfig.blockSizeVertical! * 8.5),
                          value: dropdownvalue,
                          isExpanded: true,
                          underline: const SizedBox(),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          icon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: secondaryText,
                          ),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: items == 'divider'
                                  ? const Divider()
                                  : Text(
                                      items,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) async {
                            if (newValue == 'English') {
                              await context.setLocale(Locale('en'));
                            } else if (newValue == 'हिन्दी') {
                              await context.setLocale(Locale('hi'));
                            }
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal! * 20),
                  child: Text(LocaleKeys.tandc.tr(),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 1.5,
                          color: secondaryText)),
                ),
              ],
            ),
          )),
    );
  }
}
