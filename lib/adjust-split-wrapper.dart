import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitz/adjust-split-by-adjustment.dart';
import 'package:splitz/adjust-split-by-percentage.dart';
import 'package:splitz/cache/enumerators.dart';
import 'adjust-split-equally.dart';
import 'adjust-split-by-share.dart';
import 'adjust-split-unequally.dart';
import 'logic/transaction-helper.dart';

class AdjustSplitWrapper extends StatefulWidget {
  static String route = "AdjustSplitEqually";
  @override
  State<AdjustSplitWrapper> createState() => _AdjustSplitWrapperState();
}

class _AdjustSplitWrapperState extends State<AdjustSplitWrapper> {
  @override
  Widget build(BuildContext context) {
    final transactionHelper = Provider.of<TransactionHelper>(context);
    final currentSplitType = transactionHelper.currentSplit;
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
                      splitType: SplitType.Equally,
                      currentSplitType: currentSplitType,
                      callback: transactionHelper.setSplitType,
                    ),
                    FilterButton(
                      splitType: SplitType.Unequally,
                      currentSplitType: currentSplitType,
                      callback: transactionHelper.setSplitType,
                    ),
                    FilterButton(
                      splitType: SplitType.Shares,
                      currentSplitType: currentSplitType,
                      callback: transactionHelper.setSplitType,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterButton(
                      splitType: SplitType.Percentage,
                      currentSplitType: currentSplitType,
                      callback: transactionHelper.setSplitType,
                    ),
                    FilterButton(
                      splitType: SplitType.Adjustment,
                      currentSplitType: currentSplitType,
                      callback: transactionHelper.setSplitType,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                currentSplitType == SplitType.Equally
                    ? AdjustSplitEqually()
                    : currentSplitType == SplitType.Shares
                        ? AdjustSplitByShare()
                        : currentSplitType == SplitType.Unequally
                            ? AdjustSplitUnequally()
                            : currentSplitType == SplitType.Percentage
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
  final SplitType splitType, currentSplitType;
  final callback;
  FilterButton(
      {required this.splitType,
      required this.callback,
      required this.currentSplitType});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(splitType),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: splitType == currentSplitType
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
          getSplitNameByType(splitType),
          style: TextStyle(
            color: splitType == currentSplitType
                ? Colors.white
                : Color(0xffA1A1A1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
