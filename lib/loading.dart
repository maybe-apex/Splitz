import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  static String route = 'LoadingPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
