import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:splitz/cache/enumerators.dart';

import 'cache/constants.dart';
import 'logic/transaction-helper.dart';
import 'models/general-users.dart';

class AdjustSplitByShare extends StatefulWidget {
  @override
  State<AdjustSplitByShare> createState() => _AdjustSplitByShareState();
}

class _AdjustSplitByShareState extends State<AdjustSplitByShare> {
  void userCallback(String name) {
    setState(() {
      // activeUsers[name] = !activeUsers[name]!;
    });
  }

  Map<GeneralUser, int> ledger = {};
  @override
  Widget build(BuildContext context) {
    final transactionHelper = Provider.of<TransactionHelper>(context);
    final List<GeneralUser> _involvedUsers = transactionHelper.involvedUsers;
    final _totalAmount = transactionHelper.totalAmount;
    final _ledger = transactionHelper.shareLedger;
    final _setSplit = transactionHelper.setSplitType;
    final totalShares =
        _ledger.values.reduce((value, element) => value + element);
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => UserTab(
            ledger: _ledger,
            user: _involvedUsers[index],
            totalAmount: _totalAmount,
            callback: transactionHelper.modifyShareLedger,
          ),
          itemCount: _involvedUsers.length,
        ),
        Column(
          children: [
            Text(
              totalShares > 0
                  ? "$totalShares shares for ₹${_totalAmount.toStringAsFixed(2)}\n₹${(_totalAmount / totalShares).toStringAsFixed(2)} per share"
                  : '',
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
        if (label == 'Back') {
          setSplit(SplitType.Shares);
          Navigator.pop(context);
        }
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
  final Map<GeneralUser, int> ledger;
  final callback, totalAmount;
  UserTab({
    required this.user,
    required this.ledger,
    required this.totalAmount,
    required this.callback,
  });
  @override
  Widget build(BuildContext context) {
    final totalShares =
        ledger.values.reduce((value, element) => value + element);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kOffWhite),
                    ),
                    Text(
                      totalShares != 0
                          ? "₹${(ledger[user]! / totalShares * totalAmount).toStringAsFixed(2)}"
                          : '',
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
                    constraints: BoxConstraints(maxWidth: 40),
                    child: TextFormField(
                      initialValue: ledger[user].toString(),
                      onChanged: (String share) {
                        if (share == '') share = '0';
                        callback(user, int.parse(share));
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
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
