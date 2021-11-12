import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import 'constants.dart';

class AdjustSplitByShare extends StatefulWidget {
  @override
  State<AdjustSplitByShare> createState() => _AdjustSplitByShareState();
}

class _AdjustSplitByShareState extends State<AdjustSplitByShare> {
  Map<String, bool> activeUsers = {
    "Ananya Palla": true,
    "Vivek Patel": true,
    "Bhavya Mishra": false
  };

  void userCallback(String name) {
    setState(() {
      activeUsers[name] = !activeUsers[name]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            UserTab(
              image: "assets/vectors/female-avatar-1.svg",
              name: "Ananya Palla",
              active: activeUsers,
              callback: userCallback,
            ),
            UserTab(
              image: "assets/vectors/male-avatar-1.svg",
              name: "Vivek Patel",
              active: activeUsers,
              callback: userCallback,
            ),
            UserTab(
              image: "assets/vectors/female-avatar-2.svg",
              name: "Bhavya Mishra",
              active: activeUsers,
              callback: userCallback,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "8 TOTAL SHARES",
              style: TextStyle(
                fontFamily: 'playfair',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BackConfirmButtons(label: "Back"),
                SizedBox(width: 50),
                BackConfirmButtons(label: "Confirm"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class BackConfirmButtons extends StatelessWidget {
  final String label;
  BackConfirmButtons({required this.label});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: label == "Back" ? kRed.withOpacity(0.7) : kGreen,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: label == "Back" ? kRed.withOpacity(0.7) : kGreen,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class UserTab extends StatelessWidget {
  final String name, image;
  final Map<String, bool> active;
  final Function callback;
  UserTab({
    required this.image,
    required this.name,
    required this.callback,
    required this.active,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xffA1A1A1).withOpacity(0.25),
                        blurRadius: 4,
                        offset: Offset(0, 4)),
                  ],
                  color: kOffWhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: SvgPicture.asset(image),
              ),
              SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kOffWhite),
                    ),
                    Text(
                      "₹15",
                      style: TextStyle(
                        fontFamily: 'playfair',
                        color: kOffWhite,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 15),
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffA1A1A1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "SHARES",
                    style: TextStyle(
                      fontFamily: "playfair",
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
