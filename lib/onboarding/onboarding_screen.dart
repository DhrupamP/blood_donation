import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:blood_donation/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'onboarding_widgets/continue_button.dart';
import 'onboarding_widgets/onboarding_page.dart';
import 'onboarding_widgets/page_indicator.dart';
import 'onboarding_widgets/skip_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
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
          body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SkipButton(),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.1188,
            ),
            Container(
              height: SizeConfig.screenHeight! * 0.445,
              width: SizeConfig.screenWidth,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return false;
                },
                child: PageView(
                  controller: controller,
                  children: const [
                    OnBoardingPage(
                      img: 'assets/ob1.png',
                      title: 'We Save Lives',
                      subtitle: 'Connecting blood donors with recepients',
                    ),
                    OnBoardingPage(
                      img: 'assets/ob2.png',
                      title: 'Find Blood',
                      subtitle: 'We match and connect you with nearby donors',
                    ),
                    OnBoardingPage(
                      img: 'assets/ob3.png',
                      title: 'Always Free',
                      subtitle: 'You don' 't have to pay anything',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.07,
            ),
            MyPageIndicator(
              controller: controller,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.0347,
            ),
            const ContinueButton(),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.045,
            ),
            const Text('Language ENG'),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.0325,
            ),
            Text(tandc,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SizeConfig.screenHeight! * 0.013)),
          ],
        ),
      )),
    );
  }
}
