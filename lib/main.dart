import 'package:flutter/material.dart';
import 'adjust-split-wrapper.dart';
import 'cache/constants.dart';
import 'forgot-password.dart';
import 'main-wrapper.dart';
import 'new-transaction-page.dart';
import 'secondary-user-profile-page.dart';
import 'signup-page.dart';
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
          SecondaryUserProfilePage.route: (context) =>
              SecondaryUserProfilePage(),
        },
        theme:
            ThemeData(fontFamily: 'gothic', scaffoldBackgroundColor: BGCOLOR),
        initialRoute: MainWrapper.route);
  }
}
