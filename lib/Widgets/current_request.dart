import 'package:blood_donation/Screens/number_input.dart';
import 'package:blood_donation/Widgets/accepted_request.dart';
import 'package:blood_donation/Widgets/new_request.dart';
import 'package:blood_donation/l10n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:provider/provider.dart';
import '../Providers/requests_provider.dart';
import '../Size Config/size_config.dart';
import '../viewModels/request_form_viewmodel.dart';

class CurrentRequest extends StatefulWidget {
  const CurrentRequest({
    this.requestUid,
    this.requestPushId,
    this.status,
    Key? key,
  }) : super(key: key);
  final String? requestUid;
  final String? requestPushId;
  final String? status;

  @override
  State<CurrentRequest> createState() => _CurrentRequestState();
}

class _CurrentRequestState extends State<CurrentRequest> {
  @override
  Widget build(BuildContext context) {
    if (widget.status == 'SENT') {
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
                child: GestureDetector(
                  onTap: () {
                    print(k.toString());
                    RequestFormVM.instance.cancelCurrentRequest(
                        context, auth.currentUser!.uid, k);
                    RequestFormVM.instance.getRequestData(context);
                  },
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
    } else if (widget.status == 'ACCEPTED') {
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
                  userRequest.patientName ?? '',
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
                    'Nearest blood bank ${userRequest.nearByBloodBank}',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(-0.8, 0.7),
                child: GestureDetector(
                  onTap: () {
                    print(k);
                    RequestFormVM.instance.cancelCurrentRequest(
                        context, auth.currentUser!.uid, k);
                    RequestFormVM.instance.getRequestData(context);
                  },
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
              ),
              Align(
                alignment: const Alignment(0.9, 0.7),
                child: GestureDetector(
                  onTap: () async {
                    await RequestFormVM.instance.confirmRequest(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(LocaleKeys.requestcompletedtxt.tr())));
                    print(currentuserRequest.status);
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal! * 42.5,
                    height: SizeConfig.blockSizeVertical! * 4.38,
                    decoration: BoxDecoration(
                      color: acceptColor,
                      borderRadius: BorderRadius.circular(63),
                    ),
                    child: Center(
                      child: Text(
                        'Confirm Donation',
                        style: TextStyle(
                            color: white,
                            fontSize: SizeConfig.blockSizeVertical! * 1.79,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
