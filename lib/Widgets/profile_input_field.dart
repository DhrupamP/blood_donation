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
      this.inputType,
      this.suffixIcon,
      this.isEnabled,
      this.validate,
      this.leftpadding,
      this.rightpadding,
      this.data})
      : super(key: key);
  final FocusNode? focusnode;
  final TextEditingController? controller;
  final String? hinttxt;
  final TextInputType? inputType;
  final IconData? suffixIcon;
  final bool? isEnabled;
  final String? data;
  final String? Function(String?)? validate;
  final double? leftpadding;
  final double? rightpadding;

  @override
  _ProfileInputFieldState createState() => _ProfileInputFieldState();
}

class _ProfileInputFieldState extends State<ProfileInputField> {
  String? errortxt;
  Color? _color;
  @override
  void initState() {
    super.initState();
    _color = background;
    dobtxt = widget.hinttxt;
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
          left: widget.leftpadding == null
              ? SizeConfig.blockSizeHorizontal! * 6.94
              : SizeConfig.blockSizeHorizontal! * widget.leftpadding!,
          right: widget.rightpadding == null
              ? SizeConfig.blockSizeHorizontal! * 6.94
              : SizeConfig.blockSizeHorizontal! * widget.rightpadding!,
          bottom: SizeConfig.blockSizeVertical! * 1),
      child: TextFormField(
        enabled: widget.isEnabled,
        focusNode: widget.focusnode,
        validator: widget.validate,
        style: TextStyle(color: otpCursorColor, fontWeight: FontWeight.w600),
        controller: widget.controller,
        cursorColor: primaryText,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryDesign!, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
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
