import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WSTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String hintText;
  final bool obscureText;
  final bool isValid;

  const WSTextField({
    Key key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.obscureText = false,
    this.isValid = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        onChanged: onChanged?.call,
        obscureText: obscureText,
        decoration: _decoration(),
        style: TextStyle(fontSize: 15.sp),
      );

  InputDecoration _decoration() => InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
        enabledBorder: _border(),
        focusedBorder: _border(),
        hintText: hintText,
      );

  InputBorder _border() => OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.w,
          color: isValid ? Colors.black : Colors.red,
        ),
        borderRadius: BorderRadius.circular(5.r),
      );
}
