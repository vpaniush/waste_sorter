import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WsAppBar {
  static PreferredSizeWidget build({@required String title}) => AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: 20.sp),
        ),
        toolbarHeight: 56.h,
      );
}
