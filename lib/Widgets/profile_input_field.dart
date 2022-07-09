import 'package:flutter/material.dart';

import '../Screens/profile_form.dart';
import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class ProfileInputField extends StatefulWidget {
  const ProfileInputField(
      {Key? key,
      this.controller,
      this.focusnode,
      this.hinttxt,
      this.validate,
      this.inputType,
      this.suffixIcon,
      this.isEnabled,
      this.data})
      : super(key: key);
  final FocusNode? focusnode;
  final TextEditingController? controller;
  final String? hinttxt;
  final String? Function(String?)? validate;
  final TextInputType? inputType;
  final IconData? suffixIcon;
  final bool? isEnabled;
  final String? data;

  @override
  _ProfileInputFieldState createState() => _ProfileInputFieldState();
}

class _ProfileInputFieldState extends State<ProfileInputField> {
  @override
  void initState() {
    super.initState();
    dobtxt = widget.hinttxt;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            height: SizeConfig.blockSizeVertical! * 8,
            width: SizeConfig.blockSizeHorizontal! * 86.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              enabled: widget.isEnabled,
              focusNode: widget.focusnode,
              validator: widget.validate,
              style:
                  TextStyle(color: otpCursorColor, fontWeight: FontWeight.w600),
              controller: widget.controller,
              cursorColor: primaryText,
              keyboardType: widget.inputType,
              decoration: InputDecoration(
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                suffixIcon: Icon(
                  widget.suffixIcon,
                  color: secondaryText,
                ),
                hintText: widget.hinttxt,
                hintStyle: TextStyle(
                    color: secondaryText,
                    fontSize: SizeConfig.blockSizeVertical! * 1.8),
                fillColor:
                    widget.focusnode!.hasFocus ? focusedTextField : background,
                enabled: widget.isEnabled == null ? true : widget.isEnabled!,
                filled: true,
                errorStyle:
                    const TextStyle(textBaseline: TextBaseline.alphabetic),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryDesign!, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
