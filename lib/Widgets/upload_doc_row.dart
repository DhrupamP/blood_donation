import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/request_form_provider.dart';
import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class UploadDocRow extends StatelessWidget {
  const UploadDocRow(
      {Key? key, this.text, this.onpressed, required this.docname})
      : super(key: key);
  final String? text;
  final VoidCallback? onpressed;
  final String docname;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 8,
      width: SizeConfig.blockSizeHorizontal! * 85,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 3,
              ),
              Text(
                text!,
                style: TextStyle(
                    color: otpCursorColor,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical! * 1.9),
              ),
              docname == 'id'
                  ? context.watch<RequestFormProvider>().isUploadedid
                      ? Text(
                          'Successfully Uploaded',
                          style: TextStyle(
                              color: tickgreen,
                              fontSize: SizeConfig.blockSizeVertical! * 1.5,
                              fontWeight: FontWeight.w400),
                        )
                      : SizedBox()
                  : context.watch<RequestFormProvider>().isUploadedbrf
                      ? Text(
                          'Size: ' +
                              CheckFileSize(context
                                  .read<RequestFormProvider>()
                                  .brfresult!
                                  .files
                                  .first
                                  .size),
                          style: TextStyle(
                              color: red,
                              fontSize: SizeConfig.blockSizeVertical! * 1.5,
                              fontWeight: FontWeight.w400))
                      : SizedBox()
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: onpressed,
            child: Container(
                height: SizeConfig.blockSizeVertical! * 8,
                width: SizeConfig.blockSizeVertical! * 8,
                decoration: BoxDecoration(
                    color: background, borderRadius: BorderRadius.circular(6)),
                child: docname == 'id'
                    ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          context.watch<RequestFormProvider>().isUploadedid
                              ? Positioned(
                                  top: -SizeConfig.blockSizeVertical! * 0.5,
                                  left: -SizeConfig.blockSizeVertical! * 0.5,
                                  child: Container(
                                    height:
                                        SizeConfig.blockSizeVertical! * 2.25,
                                    width: SizeConfig.blockSizeVertical! * 2.25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: tickgreen,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        size:
                                            SizeConfig.blockSizeVertical! * 1.5,
                                        Icons.check,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Center(
                            child: Icon(
                              Icons.upload_rounded,
                              color: secondaryText,
                              size: SizeConfig.blockSizeVertical! * 4,
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          context.watch<RequestFormProvider>().isUploadedbrf
                              ? Positioned(
                                  top: -SizeConfig.blockSizeVertical! * 0.5,
                                  left: -SizeConfig.blockSizeVertical! * 0.5,
                                  child: Container(
                                    height:
                                        SizeConfig.blockSizeVertical! * 2.25,
                                    width: SizeConfig.blockSizeVertical! * 2.25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: tickgreen,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        size:
                                            SizeConfig.blockSizeVertical! * 1.5,
                                        Icons.check,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Center(
                            child: Icon(
                              Icons.upload_rounded,
                              color: secondaryText,
                              size: SizeConfig.blockSizeVertical! * 4,
                            ),
                          ),
                        ],
                      )),
          )
        ],
      ),
    );
  }
}

String CheckFileSize(int bytes) {
  double temp = bytes / 1000;
  if (temp < 200) {
    return 'Less than 200 Kb';
  } else {
    return 'more than 200kb';
  }
}
