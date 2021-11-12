import 'package:flutter/material.dart';
import 'package:splitz/adjust-split-wrapper.dart';
import 'package:splitz/constants.dart';
import 'package:splitz/forgot-password.dart';
import 'package:splitz/main-wrapper.dart';
import 'package:splitz/new-transaction-page.dart';
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
          NewTransaction.route: (context) => NewTransaction(),
          AdjustSplitWrapper.route: (context) => AdjustSplitWrapper(),
        },
        theme:
            ThemeData(fontFamily: 'gothic', scaffoldBackgroundColor: BGCOLOR),
        initialRoute: AdjustSplitWrapper.route);
  }
}
