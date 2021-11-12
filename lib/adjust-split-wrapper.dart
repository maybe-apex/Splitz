import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitz/adjust-split-by-adjustment.dart';
import 'package:splitz/adjust-split-by-percentage.dart';

import 'adjust-split-equally.dart';
import 'adjust-split-by-share.dart';
import 'adjust-split-unequally.dart';

class AdjustSplitWrapper extends StatefulWidget {
  static String route = "AdjustSplitEqually";

  @override
  State<AdjustSplitWrapper> createState() => _AdjustSplitWrapperState();
}

class _AdjustSplitWrapperState extends State<AdjustSplitWrapper> {
  String isActive = "Equally";
  void splitCallback(setActive) {
    setState(() {
      isActive = setActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              children: [
                Text(
                  "Adjust Split",
                  style: TextStyle(
                    fontFamily: 'playfair',
                    color: Colors.white,
                    fontSize: 64,
                    fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterButton(
                      title: "Equally",
                      isActive: isActive,
                      callback: splitCallback,
                    ),
                    FilterButton(
                      title: "Unequally",
                      isActive: isActive,
                      callback: splitCallback,
                    ),
                    FilterButton(
                      title: "By Share",
                      isActive: isActive,
                      callback: splitCallback,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterButton(
                      title: "By Percentage",
                      isActive: isActive,
                      callback: splitCallback,
                    ),
                    FilterButton(
                      title: "By Adjustment",
                      isActive: isActive,
                      callback: splitCallback,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                isActive == "Equally"
                    ? AdjustSplitEqually()
                    : isActive == "By Share"
                        ? AdjustSplitByShare()
                        : isActive == "Unequally"
                            ? AdjustSplitUnequally()
                            : isActive == "By Percentage"
                                ? AdjustSplitByPercentage()
                                : AdjustSplitByAdjustment(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String title, isActive;
  final callback;
  FilterButton(
      {required this.title, required this.isActive, required this.callback});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(title),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: isActive == title
              ? [
                  BoxShadow(
                      color: Color(0xffA1A1A1).withOpacity(0.45),
                      blurRadius: 4,
                      offset: Offset(0, 4)),
                ]
              : [],
          color: Color(0xff31303A),
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          title,
          style: TextStyle(
            color: isActive == title ? Colors.white : Color(0xffA1A1A1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
