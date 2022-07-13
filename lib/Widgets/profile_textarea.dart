import 'package:flutter/material.dart';

import '../Screens/profile_form.dart';
import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class ProfileInputTextArea extends StatefulWidget {
  const ProfileInputTextArea(
      {Key? key,
      this.controller,
      required this.focusnode,
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
  _ProfileInputTextAreaState createState() => _ProfileInputTextAreaState();
}

class _ProfileInputTextAreaState extends State<ProfileInputTextArea> {
  Color? _color = background;
  @override
  void initState() {
    super.initState();
    dobtxt = widget.hinttxt;
    _color = background;
    widget.focusnode!.addListener(() {
      if (widget.focusnode!.hasFocus) {
        setState(() {
          _color = focusedTextField;
        });
      } else {
        setState(() {
          _color = background;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal! * 6.94,
          right: SizeConfig.blockSizeHorizontal! * 6.94,
          bottom: SizeConfig.blockSizeVertical! * 1),
      child: TextFormField(
        maxLines: 5,
        enabled: widget.isEnabled,
        focusNode: widget.focusnode,
        validator: widget.validate,
        style: TextStyle(color: otpCursorColor, fontWeight: FontWeight.w600),
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
          fillColor: _color,
          enabled: widget.isEnabled == null ? true : widget.isEnabled!,
          filled: true,
          errorStyle: const TextStyle(textBaseline: TextBaseline.alphabetic),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryDesign!, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
