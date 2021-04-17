import 'package:flutter/material.dart';

import '../auth_screen.dart';

class SwitchAuthFlowInkwell extends StatelessWidget {
  final AuthScreenType type;

  const SwitchAuthFlowInkwell({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => _switchFlow(context),
        child: Text(
          type == AuthScreenType.signIn
              ? "Don't have an account? Sign up"
              : 'Already have an account? Sign in',
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
