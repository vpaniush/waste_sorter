import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth_screen.dart';

class SwitchAuthFlowInkwell extends StatelessWidget {
  final AuthScreenType type;

  const SwitchAuthFlowInkwell({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => _switchFlow(context),
        child: Text(
          type == AuthScreenType.signIn
              ? 'dont_have_account'.tr()
              : 'already_have_account'.tr(),
          style: TextStyle(
            color: Colors.green[300],
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  void _switchFlow(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (type == AuthScreenType.signIn) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AuthScreen(AuthScreenType.signUp)),
      );
    } else {
      Navigator.pop(context);
    }
  }
}
