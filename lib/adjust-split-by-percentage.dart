import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:splitz/cache/enumerators.dart';
import 'package:splitz/forgot-password.dart';

import 'cache/constants.dart';
import 'logic/transaction-helper.dart';
import 'models/general-users.dart';

class AdjustSplitByPercentage extends StatefulWidget {
  @override
  State<AdjustSplitByPercentage> createState() =>
      _AdjustSplitByPercentageState();
}

class _AdjustSplitByPercentageState extends State<AdjustSplitByPercentage> {
  @override
  Widget build(BuildContext context) {
    final transactionHelper = Provider.of<TransactionHelper>(context);
    final List<GeneralUser> _involvedUsers = transactionHelper.involvedUsers;
    final _totalAmount = transactionHelper.totalAmount;
    final _ledger = transactionHelper.percentageLedger;
    final _percentageFilled =
        _ledger.values.reduce((value, element) => value + element);
    final _percentageLeft = 100 - _percentageFilled;
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => UserTab(
            ledger: _ledger,
            total: _totalAmount,
            user: _involvedUsers[index],
            callback: transactionHelper.modifyPercentageLedger,
          ),
          itemCount: _involvedUsers.length,
        ),
        Column(
          children: [
            Text(
              "$_percentageLeft% LEFT",
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
  final GeneralUser user;
  final Map<GeneralUser, double> ledger;
  final double total;
  final callback;
  UserTab({
    required this.user,
    required this.total,
    required this.ledger,
    required this.callback,
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
                      "₹${total * double.parse(ledger[user].toString()) / 100}",
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
                    constraints: BoxConstraints(maxWidth: 30),
                    child: TextFormField(
                      maxLength: 3,
                      textAlign: TextAlign.center,
                      initialValue: ledger[user].toString(),
                      onChanged: (String per) {
                        if (per == '') per = '0';
                        final percentage = double.parse(per);
                        if (percentage < 0 || percentage > 100)
                          showSnackBar(
                              context, 'Please input a valid percentage');
                        else
                          callback(user, percentage);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      cursorColor: Colors.white,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(
                          color: kOffWhite,
                        ),
                        counterText: '',
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
                    "%",
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
