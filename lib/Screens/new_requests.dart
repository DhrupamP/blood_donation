import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class NewRequestsPage extends StatefulWidget {
  const NewRequestsPage({Key? key}) : super(key: key);

  @override
  _NewRequestsPageState createState() => _NewRequestsPageState();
}

class _NewRequestsPageState extends State<NewRequestsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return ListView(
      children: [
        SizedBox(
          height: h * 2.88,
        ),
        NewRequest(),
      ],
    );
  }
}

class NewRequest extends StatelessWidget {
  const NewRequest({
    this.patientname,
    this.nearestbank,
    this.patientbloodgroup,
    Key? key,
  }) : super(key: key);
  final String? patientname;
  final String? patientbloodgroup;
  final String? nearestbank;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.blockSizeVertical! * 2,
        left: SizeConfig.blockSizeHorizontal! * 10,
        right: SizeConfig.blockSizeHorizontal! * 10,
      ),
      child: Container(
        width: SizeConfig.blockSizeHorizontal! * 86.11,
        height: SizeConfig.blockSizeVertical! * 14.63,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: secondaryText!,
            )),
        child: Stack(
          children: [
            Align(
                alignment: const Alignment(-0.9, -0.9),
                child: Text(
                  'Patient Name',
                  style: TextStyle(
                      color: secondaryText,
                      fontSize: SizeConfig.blockSizeVertical! * 1.8),
                )),
            Align(
              alignment: const Alignment(-0.9, -0.5),
              child: Text(
                patientname.toString(),
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: SizeConfig.blockSizeVertical! * 2),
              ),
            ),
            Align(
              alignment: const Alignment(1, -0.9),
              child: SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 30,
                height: SizeConfig.blockSizeVertical! * 4,
                child: Text(
                  'Nearest blood bank $nearestbank',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.9, 0.8),
              child: Container(
                width: SizeConfig.blockSizeHorizontal! * 43.89,
                height: SizeConfig.blockSizeVertical! * 3.38,
                decoration: BoxDecoration(
                  color: focusedTextField,
                  borderRadius: BorderRadius.circular(63),
                ),
                child: Center(
                  child: Text(
                    '$patientbloodgroup blood requires',
                    style: TextStyle(color: primaryDesign),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.9, 0.8),
              child: Container(
                width: SizeConfig.blockSizeHorizontal! * 23.33,
                height: SizeConfig.blockSizeVertical! * 4.38,
                decoration: BoxDecoration(
                  color: acceptColor,
                  borderRadius: BorderRadius.circular(63),
                ),
                child: const Center(
                  child: Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
