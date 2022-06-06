import 'package:flutter/material.dart';
import '../Screens/profile_form.dart';
import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class DropDownField extends StatefulWidget {
  DropDownField(
      {Key? key,
      this.hinttext,
      this.items,
      this.value,
      this.errortxt,
      this.focusnode,
      this.isEnabled,
      required this.onchanged})
      : super(key: key);
  final List<String>? items;
  final String? value;
  final String? hinttext;
  final String? errortxt;
  final FocusNode? focusnode;
  final Function(dynamic) onchanged;
  final bool? isEnabled;
  @override
  _DropDownFieldState createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          IgnorePointer(
            ignoring: !widget.isEnabled!,
            child: Container(
              height: SizeConfig.blockSizeVertical! * 8,
              width: SizeConfig.blockSizeHorizontal! * 86.11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField(
                focusNode: widget.focusnode,
                validator: (value) {
                  if (value == null) {
                    return widget.errortxt;
                  }
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusColor: focusedTextField,
                    fillColor: background,
                    filled: true,
                    focusedBorder: InputBorder.none),
                value: widget.value,
                items: widget.items!.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            color: primaryText, fontWeight: FontWeight.w600)),
                  );
                }).toList(),
                onChanged: widget.onchanged,
                hint: Text(widget.hinttext!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}