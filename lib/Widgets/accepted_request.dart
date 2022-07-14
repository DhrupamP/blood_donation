import 'package:dashed_circle/dashed_circle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation/constants/color_constants.dart';
import '../Size Config/size_config.dart';
import '../l10n/locale_keys.g.dart';
import '../viewModels/request_form_viewmodel.dart';

class AcceptedRequest extends StatefulWidget {
  const AcceptedRequest({
    this.patientname,
    this.nearestbank,
    this.status,
    this.requestPushId,
    this.requestUid,
    Key? key,
  }) : super(key: key);
  final String? patientname;
  final String? nearestbank;
  final String? status;
  final String? requestUid;
  final String? requestPushId;

  @override
  State<AcceptedRequest> createState() => _AcceptedRequestState();
}

class _AcceptedRequestState extends State<AcceptedRequest> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    bool isCompleted = widget.status == 'COMPLETED' ? true : false;

    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.blockSizeVertical! * 2,
        left: SizeConfig.blockSizeHorizontal! * 10,
        right: SizeConfig.blockSizeHorizontal! * 10,
      ),
      child: Container(
        width: SizeConfig.blockSizeHorizontal! * 86.11,
        height: SizeConfig.blockSizeVertical! * 19,
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
              alignment: const Alignment(-0.9, -0.65),
              child: Text(
                widget.patientname.toString(),
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
                  'Nearest blood bank ${widget.nearestbank}',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
            Align(
                alignment: Alignment(-0.9, 0.0),
                child: widget.status == 'ACCEPTED'
                    ? DashedCircle(
                        color: secondaryText!,
                        child: Container(
                          width: w * 10.56,
                          height: w * 10.56,
                          child: Center(
                            child: Text(
                              '01',
                              style: TextStyle(
                                  color: primaryText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: w * 3,
                          ),
                          Container(
                            width: w * 10.56,
                            height: w * 10.56,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: acceptColor),
                            child: Center(
                              child: Text(
                                '01',
                                style: TextStyle(
                                    color: white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.check,
                            color: acceptColor,
                          )
                        ],
                      )),
            Align(
                alignment: Alignment(-0.9, 0.7),
                child: Container(
                  width: w * 30,
                  child: widget.status == 'ACCEPTED'
                      ? Text(
                          'Waiting for confirmation form patient',
                          style: TextStyle(
                              color: secondaryText,
                              fontSize: h * 1.28,
                              fontWeight: FontWeight.w600),
                        )
                      : Text(
                          'Patient approved donation',
                          style: TextStyle(
                              color: acceptColor,
                              fontSize: h * 1.28,
                              fontWeight: FontWeight.w600),
                        ),
                )),
            Align(
                alignment: Alignment(0.15, 0.0),
                child: !isCompleted
                    ? DashedCircle(
                        color: secondaryText!,
                        child: GestureDetector(
                          onTap: () async {
                            await RequestFormVM.instance.uploadDocument(
                                context,
                                widget.requestUid.toString(),
                                widget.requestPushId.toString());
                            setState(() {
                              isCompleted = true;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text(LocaleKeys.requestcompletedtxt.tr())));
                          },
                          child: Container(
                            width: w * 10.56,
                            height: w * 10.56,
                            child: Center(
                              child: Text(
                                '02',
                                style: TextStyle(
                                    color: primaryText,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: w * 40,
                          ),
                          Container(
                            width: w * 10.56,
                            height: w * 10.56,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: acceptColor),
                            child: Center(
                              child: Text(
                                '02',
                                style: TextStyle(
                                    color: white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.check,
                            color: acceptColor,
                          )
                        ],
                      )),
            Align(
                alignment: Alignment(0.6, 0.7),
                child: Container(
                  width: w * 30,
                  child: !isCompleted
                      ? Text(
                          'Upload Documents to download certificate.',
                          style: TextStyle(
                              color: secondaryText,
                              fontSize: h * 1.28,
                              fontWeight: FontWeight.w600),
                        )
                      : Text(
                          'Document Uploaded',
                          style: TextStyle(
                              color: acceptColor,
                              fontSize: h * 1.28,
                              fontWeight: FontWeight.w600),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}
