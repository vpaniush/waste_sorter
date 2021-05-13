import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WsValidationMessage extends StatelessWidget {
  final String message;

  const WsValidationMessage(this.message, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 7.w, top: 4.h),
          child: Text(
            message,
            style: TextStyle(color: Colors.red, fontSize: 12.sp),
          ),
        ),
      );
}
