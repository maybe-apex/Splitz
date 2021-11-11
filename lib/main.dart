import 'package:flutter/material.dart';
import 'package:splitz/constants.dart';
import 'login-page.dart';

void main() {
  runApp(Splitz());
}

class Splitz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/': (context) => LoginPage()},
      theme: ThemeData(fontFamily: 'gothic', scaffoldBackgroundColor: BGCOLOR),
      initialRoute: LoginPage.route,
    );
  }
}
