import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WSButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const WSButton({Key key, @required this.onPressed, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: _child(),
        style: _style(),
      );

  Widget _child() => Text(title);

  ButtonStyle _style() => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      );
}
