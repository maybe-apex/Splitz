import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitz/logic/cloud-helper.dart';
import 'adjust-split-wrapper.dart';
import 'cache/constants.dart';
import 'forgot-password.dart';
import 'logic/transaction-helper.dart';
import 'main-wrapper.dart';
import 'new-transaction-page.dart';
import 'secondary-user-profile-page.dart';
import 'signup-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Splitz());
}

class Splitz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GoogleSignInProvider>(
            create: (context) => GoogleSignInProvider(),
          ),
          ChangeNotifierProvider<TransactionHelper>(
            create: (context) => TransactionHelper(),
          ),
        ],
        child: MaterialApp(
            routes: {
              '/': (context) => MainWrapper(),
              SingUpPage.route: (context) => SingUpPage(),
              ForgotPassword.route: (context) => ForgotPassword(),
              MainWrapper.route: (context) => MainWrapper(),
              NewTransaction.route: (context) => NewTransaction(),
              AdjustSplitWrapper.route: (context) => AdjustSplitWrapper(),
              SecondaryUserProfilePage.route: (context) =>
                  SecondaryUserProfilePage(),
            },
            theme: ThemeData(
                fontFamily: 'gothic', scaffoldBackgroundColor: BGCOLOR),
            initialRoute: '/'));
  }
}
