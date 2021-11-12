import 'package:flutter/material.dart';
import 'constants.dart';

class LoginPage extends StatelessWidget {
  static String route = "LoginPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/vectors/banner-blurred.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 80),
                    child: Text(
                      "Splitz",
                      style: TextStyle(
                        fontFamily: 'playfair',
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
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
                          child: Text(
                            "Log-in",
                            style: TextStyle(
                              fontFamily: 'playfair',
                              fontWeight: FontWeight.w700,
                              fontSize: 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        EmailPasswordForm(
                          title: "Email",
                        ),
                        SizedBox(height: 30),
                        EmailPasswordForm(
                          title: "Password",
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                color: Color(0xffA1A1A1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  shadowColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 110, vertical: 15),
                                  primary: kGreen,
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account yet ?",
                                    style: TextStyle(
                                        color: Color(0xffA1A1A1),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Sign-up",
                                      style: TextStyle(
                                          color: Color(0xffA1A1A1),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class EmailPasswordForm extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  final String title;
  EmailPasswordForm({required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'gothic',
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(
          controller: emailController,
          obscureText: title != "Email",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: title == "Email" ? "Your Email id" : "Password",
            hintStyle: TextStyle(
              fontSize: 15,
              color: Color(0xffA1A1A1),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffA1A1A1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffA1A1A1)),
            ),
          ),
        )
      ],
    );
  }
}
