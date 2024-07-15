// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tm_school/core/extensions/extension.dart';

class WTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? hintTextSytle;
  final bool? filled;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool? obscureText;
  final String? obscuringCharacter;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final bool? canRequestFocus;
  final bool? autofocus;
  final int? maxLength;

  const WTextField({
    Key? key,
    this.controller,
    this.textAlign,
    this.textStyle,
    this.hintText,
    this.hintTextSytle,
    this.filled,
    this.fillColor,
    this.borderColor,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.obscureText,
    this.obscuringCharacter,
    this.prefixText,
    this.prefixStyle,
    this.canRequestFocus,
    this.autofocus,
    this.maxLength,
  }) : super(key: key);
  @override
  _WTextFieldState createState() {
    return _WTextFieldState();
  }
}

class _WTextFieldState extends State<WTextField>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.maxLength,
      autofocus: widget.autofocus ?? false,
      canRequestFocus: widget.canRequestFocus ?? true,
      obscuringCharacter: widget.obscuringCharacter ?? "•",
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign ?? TextAlign.center,
      style: widget.textStyle ?? context.style.fontSize13Weight300,
      decoration: InputDecoration(
        counterText: "",

        prefixStyle: widget.prefixStyle ?? context.style.fontSize13Weight300,
        prefixText: widget.prefixText,
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: context.colors.mainRadishColor,
        //   ),
        // ),
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: widget.hintTextSytle ??
            context.style.fontSize13Weight300.copyWith(
              color: context.colors.hintTextColor,
            ),
        filled: widget.filled ?? true,
        fillColor: widget.fillColor ?? context.colors.textFieldBackground,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? context.colors.orange,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? context.colors.orange,
          ),
        ),
      ),
    );
  }
}
