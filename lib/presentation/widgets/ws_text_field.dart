import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WSTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const WSTextField({
    Key key,
    this.controller,
    this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
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
        borderSide: BorderSide(width: 2.w),
        borderRadius: BorderRadius.circular(5.r),
      );
}
