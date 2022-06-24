import 'package:flutter/material.dart';
import 'package:blood_donation/constants/color_constants.dart';
import '../Size Config/size_config.dart';
import '../viewModels/request_form_viewmodel.dart';

class SentRequest extends StatelessWidget {
  const SentRequest({
    Key? key,
  }) : super(key: key);
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
                sentRequest.patientName ?? '',
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
                  'Nearest blood bank ${sentRequest.nearByBloodBank}',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.8, 0.7),
              child: Container(
                width: SizeConfig.blockSizeHorizontal! * 26.11,
                height: SizeConfig.blockSizeVertical! * 3.38,
                child: Center(
                  child: Text(
                    'Cancel Request',
                    style: TextStyle(
                        color: primaryDesign,
                        fontSize: SizeConfig.blockSizeVertical! * 1.79,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.9, 0.7),
              child: Container(
                width: SizeConfig.blockSizeHorizontal! * 35.5,
                height: SizeConfig.blockSizeVertical! * 4.38,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(63),
                ),
                child: Center(
                  child: Text(
                    'Pending',
                    style: TextStyle(
                        color: white,
                        fontSize: SizeConfig.blockSizeVertical! * 1.79,
                        fontWeight: FontWeight.w600),
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
