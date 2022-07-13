import 'package:dashed_circle/dashed_circle.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation/constants/color_constants.dart';
import '../Size Config/size_config.dart';
import '../viewModels/request_form_viewmodel.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({
    this.patientname,
    this.nearestbank,
    this.patientbloodgroup,
    this.requestUid,
    this.requestPushId,
    this.status,
    Key? key,
  }) : super(key: key);
  final String? patientname;
  final String? patientbloodgroup;
  final String? nearestbank;
  final String? requestUid;
  final String? requestPushId;
  final String? status;

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  Color? buttonColor;
  @override
  void initState() {
    buttonColor = widget.status == 'SENT' ? acceptColor! : Colors.grey;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
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
              alignment: const Alignment(-0.9, 0.1),
              child: Container(
                width: SizeConfig.blockSizeHorizontal! * 43.89,
                height: SizeConfig.blockSizeVertical! * 3.38,
                decoration: BoxDecoration(
                  color: focusedTextField,
                  borderRadius: BorderRadius.circular(63),
                ),
                child: Center(
                  child: Text(
                    '${widget.patientbloodgroup} blood requires',
                    style: TextStyle(color: primaryDesign),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.8, 0.7),
              child: GestureDetector(
                onTap: () {
                  print(widget.requestPushId.toString());
                  RequestFormVM.instance.cancelRequest(
                      context, widget.requestUid!, widget.requestPushId!);
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
              alignment: const Alignment(0.9, 0.8),
              child: Container(
                width: SizeConfig.blockSizeHorizontal! * 23.33,
                height: SizeConfig.blockSizeVertical! * 4.38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(63),
                ),
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(63),
                            side: BorderSide(color: Colors.red))),
                    backgroundColor: MaterialStateProperty.all(buttonColor),
                  ),
                  onPressed: () async {
                    print(widget.requestUid! + ' ' + widget.requestPushId!);
                    await RequestFormVM.instance.acceptRequest(
                        context, widget.requestUid!, widget.requestPushId!);
                    setState(() {
                      buttonColor = Colors.grey;
                    });
                    print(currentuserRequest.status);
                  },
                  child: Center(
                    child: Text(
                      'Accept',
                      style: TextStyle(color: Colors.white),
                    ),
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
