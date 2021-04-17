import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waste_sorter/domain/blocs/auth_bloc/bloc.dart';
import 'package:waste_sorter/presentation/screens/sorter/sorter_screen.dart';
import 'package:waste_sorter/presentation/widgets/ws_button.dart';
import 'package:waste_sorter/presentation/widgets/ws_text_field.dart';

import 'local_widgets/switch_auth_flow_inkwell.dart';

enum AuthScreenType { signIn, signUp }

class AuthScreen extends StatefulWidget {
  final AuthScreenType type;

  const AuthScreen(this.type, {Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState(type);
}

class _AuthScreenState extends State<AuthScreen> {
  final String _title;
  final AuthScreenType type;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _AuthScreenState(this.type)
      : _title = type == AuthScreenType.signIn ? 'Sign in' : 'Sign up';

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedIn) _goNext();
        },
        child: buildUI(),
      );

  Widget buildUI() => GestureDetector(
        onTap: _unfocus,
        child: Scaffold(
          appBar: AppBar(title: Text(_title)),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(50.w),
              child: _content(),
            ),
          ),
        ),
      );

  Widget _content() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100.h),
          _emailField(),
          SizedBox(height: 20.h),
          _passwordField(),
          SizedBox(height: 30.h),
          _button(),
          SizedBox(height: 30.h),
          SwitchAuthFlowInkwell(type: type),
          _keyboardHandler(),
        ],
      );

  Widget _emailField() => WSTextField(
        controller: _emailController,
        hintText: 'Email',
      );

  Widget _passwordField() => WSTextField(
        controller: _passwordController,
        hintText: 'Password',
        obscureText: true,
      );

  Widget _button() => WSButton(onPressed: _buttonPressed, title: _title);

  void _buttonPressed() {
    _unfocus();
    if (type == AuthScreenType.signIn) {
      _blocAddEvent(
        SignIn(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    } else {
      _blocAddEvent(
        SignUp(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _blocAddEvent(AuthEvent event) {
    BlocProvider.of<AuthBloc>(context).add(event);
  }

  void _goNext() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => SorterScreen()),
      (route) => false,
    );
  }

  Widget _keyboardHandler() =>
      SizedBox(height: MediaQuery.of(context).viewInsets.bottom);

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }
}
