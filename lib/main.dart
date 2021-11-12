import 'package:flutter/material.dart';
import 'package:splitz/constants.dart';
import 'package:splitz/forgot-password.dart';
import 'package:splitz/main-wrapper.dart';
import 'package:splitz/signup-page.dart';
import 'login-page.dart';

void main() {
  runApp(Splitz());
}

class Splitz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginPage(),
        SingUpPage.route: (context) => SingUpPage(),
        ForgotPassword.route: (context) => ForgotPassword(),
        MainWrapper.route: (context) => MainWrapper(),
      },
      theme: ThemeData(fontFamily: 'gothic', scaffoldBackgroundColor: BGCOLOR),
      initialRoute: MainWrapper.route,
    );
  }
}
