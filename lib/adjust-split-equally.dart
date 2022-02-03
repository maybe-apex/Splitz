import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:splitz/cache/enumerators.dart';
import 'package:splitz/models/general-users.dart';

import 'cache/constants.dart';
import 'logic/transaction-helper.dart';

class AdjustSplitEqually extends StatefulWidget {
  @override
  State<AdjustSplitEqually> createState() => _AdjustSplitEquallyState();
}

class _AdjustSplitEquallyState extends State<AdjustSplitEqually> {
  @override
  Widget build(BuildContext context) {
    final transactionHelper = Provider.of<TransactionHelper>(context);
    final List<GeneralUser> _involvedUsers = transactionHelper.involvedUsers;
    final _totalAmount = transactionHelper.totalAmount;
    final _ledger = transactionHelper.equalLedger;
    final _setSplit = transactionHelper.setSplitType;
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => UserTab(
            user: _involvedUsers[index],
            callback: transactionHelper.modifyEqualLedger,
            active: _ledger.contains(_involvedUsers[index]),
          ),
          itemCount: _involvedUsers.length,
        ),
        Column(
          children: [
            Text(
              _ledger.length > 0
                  ? "${(_totalAmount / _ledger.length).toStringAsFixed(2)} per person"
                  : 'Please Select Users',
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
                BackConfirmButtons(
                  label: "Back",
                  setSplit: _setSplit,
                ),
                SizedBox(width: 50),
                BackConfirmButtons(label: "Confirm", setSplit: _setSplit),
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
  final setSplit;
  BackConfirmButtons({required this.label, required this.setSplit});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setSplit(SplitType.Equally);
        Navigator.pop(context);
      },
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
  final GeneralUser user;
  final callback;
  final bool active;
  UserTab({
    required this.user,
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
                child: SvgPicture.asset(getAvatarByID(user.avatarID)),
              ),
              SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  user.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kOffWhite),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
                onTap: () => callback(user),
                child: active
                    ? SvgPicture.asset("assets/vectors/radio-button-filled.svg")
                    : SvgPicture.asset(
                        "assets/vectors/radio-button-hollow.svg")),
          ),
        ],
      ),
    );
  }
}
