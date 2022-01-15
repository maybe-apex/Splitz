import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splitz/forgot-password.dart';
import 'cache/constants.dart';
import 'cache/data-processing.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController contactNumberController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();

String? uid = '';

class SingUpPage extends StatefulWidget {
  static String route = "Signup";

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  void singUpCallback() async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    try {
      setState(() {
        // loading = true;
      });
      final newUser = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (newUser.user != null) {
        uid = newUser.user?.uid;
        setState(() {
          // loading = false;
        });
        int contactNumber =
            parseIntFromString('${contactNumberController.text}');
        await firestore.collection('/Users').doc(uid).set({
          'FirstName': firstNameController.text,
          'LastName': lastNameController.text,
          'ContactNumber': contactNumber,
          'Email': emailController.text,
        });
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

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
                                  Text(
                                    "Sign-up",
                                    style: TextStyle(
                                      fontFamily: 'playfair',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 45,
                                      color: Colors.white,
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
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: firstNameController,
                                        // obscureText: title != "Email",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "First Name",
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
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: TextFormField(
                                        controller: lastNameController,
                                        // obscureText: title != "Email",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Last Name",
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
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contact Number",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextFormField(
                                  controller: contactNumberController,
                                  // obscureText: title != "Email",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Your Contact Number",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  // obscureText: title != "Email",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Password",
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
                              // onPressed: singUpCallback,
                              onPressed: singUpCallback,
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
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
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
