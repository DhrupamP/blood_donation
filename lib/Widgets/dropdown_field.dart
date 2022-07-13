import 'package:flutter/material.dart';
import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class DropDownField extends StatefulWidget {
  const DropDownField(
      {Key? key,
      this.hinttext,
      this.items,
      this.value,
      this.errortxt,
      this.focusnode,
      this.isEnabled,
      required this.onchanged,
      this.leftpadding,
      this.rightpadding})
      : super(key: key);
  final List<String>? items;
  final String? value;
  final String? hinttext;
  final String? errortxt;
  final FocusNode? focusnode;
  final Function(dynamic) onchanged;
  final bool? isEnabled;
  final double? leftpadding;
  final double? rightpadding;
  @override
  _DropDownFieldState createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
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
      child: IgnorePointer(
        ignoring: widget.isEnabled == null ? false : !widget.isEnabled!,
        child: DropdownButtonFormField(
          focusNode: widget.focusnode,
          validator: (value) {
            if (value == null) {
              return widget.errortxt;
            }
            return null;
          },
          decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              focusColor: focusedTextField,
              fillColor: background,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none)),
          value: widget.value,
          items: widget.items!.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: TextStyle(
                      color: otpCursorColor, fontWeight: FontWeight.w600)),
            );
          }).toList(),
          onChanged: widget.onchanged,
          borderRadius: BorderRadius.circular(8),
          hint: Text(
            widget.hinttext!,
            style: TextStyle(color: secondaryText, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
