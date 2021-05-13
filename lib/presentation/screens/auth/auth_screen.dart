import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waste_sorter/domain/blocs/auth_bloc/bloc.dart';
import 'package:waste_sorter/presentation/screens/home/home_screen.dart';
import 'package:waste_sorter/presentation/widgets/ws_app_bar.dart';
import 'package:waste_sorter/presentation/widgets/ws_button.dart';
import 'package:waste_sorter/presentation/widgets/ws_text_field.dart';
import 'package:waste_sorter/presentation/widgets/ws_validation_message.dart';

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
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return buildUI(state);
            }
            return Container();
          },
        ),
      );

  Widget buildUI(AuthInitial state) => GestureDetector(
        onTap: _unfocus,
        child: Scaffold(
          appBar: WsAppBar.build(title: _title),
          body: _body(state),
        ),
      );

  Widget _body(AuthInitial state) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(50.w),
          child: _content(state),
        ),
      );

  Widget _content(AuthInitial state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100.h),
          _emailField(state),
          if (state.emailErrorMessage != null)
            WsValidationMessage(state.emailErrorMessage),
          SizedBox(height: 20.h),
          _passwordField(state),
          if (state.passwordErrorMessage != null)
            WsValidationMessage(state.passwordErrorMessage),
          SizedBox(height: 20.h),
          _button(),
          SizedBox(height: 25.h),
          SwitchAuthFlowInkwell(type: type),
          _keyboardHandler(),
        ],
      );

  Widget _emailField(AuthInitial state) => WSTextField(
        controller: _emailController,
        onChanged: (text) {
          _blocAddEvent(EmailOnChanged(text));
        },
        hintText: 'Email',
        isValid: state.emailErrorMessage == null,
      );

  Widget _passwordField(AuthInitial state) => WSTextField(
        controller: _passwordController,
        onChanged: (text) {
          _blocAddEvent(PasswordOnChanged(text));
        },
        hintText: 'Password',
        isValid: state.passwordErrorMessage == null,
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
      MaterialPageRoute(builder: (_) => HomeScreen()),
      (route) => false,
    );
  }

  Widget _keyboardHandler() =>
      SizedBox(height: MediaQuery.of(context).viewInsets.bottom);

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }
}
