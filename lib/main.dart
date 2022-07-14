import 'package:blood_donation/Providers/homepage_provider.dart';
import 'package:blood_donation/Providers/initial_profile_form_provider.dart';
import 'package:blood_donation/Providers/profile_page_provider.dart';
import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Providers/request_form_provider.dart';
import 'package:blood_donation/Providers/requests_provider.dart';
import 'package:blood_donation/Providers/storyscreen_provider.dart';
import 'package:blood_donation/Screens/activity.dart';
import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Screens/profile_form.dart';
import 'package:blood_donation/viewModels/navigation_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/onboarding_screen.dart';
import 'locales/locales.dart';
import 'dart:math' as math;

int? initscreen;
bool? profileform;
bool? loggedin;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initscreen = preferences.getInt('initScreen');
  profileform = preferences.getBool('isinitialprofilecomplete');
  loggedin = preferences.getBool('isloggedin');
  print('init: ' + initscreen.toString());
  print('loggedin: ' + loggedin.toString());
  print('profile dform: ' + profileform.toString());
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(EasyLocalization(
    supportedLocales: L10n.all,
    path: 'assets/l10n',
    fallbackLocale: L10n.all[0],
    child: MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ChangeNotifierProvider(create: (_) => InitialProfileProvider()),
      ChangeNotifierProvider(create: (_) => RequestFormProvider()),
      ChangeNotifierProvider(create: (_) => StoryProvider()),
      ChangeNotifierProvider(create: (_) => ProfilePageProvider()),
      ChangeNotifierProvider(create: (_) => RequestsProvider())
    ], child: NMOApp()),
  ));
}

class NMOApp extends StatefulWidget {
  const NMOApp({Key? key}) : super(key: key);

  @override
  _NMOAppState createState() => _NMOAppState();
}

class _NMOAppState extends State<NMOApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'SegoeUI'),
        home: initscreen == 0 || initscreen == null
            ? const OnBoardingScreen()
            : loggedin == false || loggedin == null
                ? NumberInputScreen()
                : profileform == false || profileform == null
                    ? const ProfileFormScreen()
                    : const ActivityPage());
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
// adb connect 192.168.1.2

//TODO: request completed
