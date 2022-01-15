import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cache/constants.dart';

TextEditingController emailController = TextEditingController();

class ForgotPassword extends StatelessWidget {
  static String route = "ForgotPassword";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/vectors/banner.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: LTBGCOLOR,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Forgot Password",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily: 'playfair',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 45,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: SvgPicture.asset(
                                        "assets/vectors/back.svg"),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  // obscureText: title != "Email",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Your email id",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xffA1A1A1),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffA1A1A1),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffA1A1A1),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              // onPressed: () async {
                              //   final auth = FirebaseAuth.instance;
                              //   if (emailValidator(emailController.text) ==
                              //       null) {
                              //     showSnackBar(context,
                              //         'Reset email has been sent to your email');
                              //     await auth.sendPasswordResetEmail(
                              //         email: emailController.text);
                              //   } else
                              //     showSnackBar(context,
                              //         'Please enter valid email address.');
                              // },
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                shadowColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                primary: kGreen,
                              ),
                              child: Text(
                                "Reset my password",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            SizedBox(height: 250),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 3,
      backgroundColor: kRed.withOpacity(0.7),
      content: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      action: SnackBarAction(
        label: 'OK',
        onPressed: scaffold.hideCurrentSnackBar,
        textColor: Colors.black54,
      ),
    ),
  );
}
