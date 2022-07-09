import 'package:flutter/material.dart';

import '../Screens/number_input.dart';
import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class NumberInputField extends StatefulWidget {
  const NumberInputField({Key? key, this.controller, this.focusnode})
      : super(key: key);
  final FocusNode? focusnode;
  final TextEditingController? controller;

  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical! * 7,
      width: SizeConfig.blockSizeHorizontal! * 86.11,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextField(
        style: TextStyle(color: primaryText),
        controller: widget.controller,
        cursorColor: primaryText,
        focusNode: widget.focusnode,
        keyboardType: TextInputType.number,
        onChanged: (val) {
          isEmpty = val.isEmpty;
        },
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal! * 3),
            child: Text(
              "+91  |  ",
              style: TextStyle(color: primaryText),
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          prefixStyle: const TextStyle(color: Colors.red),
          hintText: "Phone Number",
          hintStyle: TextStyle(
              color: primaryText,
              fontSize: SizeConfig.blockSizeVertical! * 1.8),
          fillColor: widget.focusnode!.hasFocus ? focusedTextField : background,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: InputBorder.none,
          focusColor: focusedTextField,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryDesign!, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
