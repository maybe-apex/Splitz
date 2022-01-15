import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'cache/constants.dart';
import 'cache/enumerators.dart';
import 'logic/transaction-helper.dart';
import 'models/general-users.dart';

class AdjustSplitUnequally extends StatefulWidget {
  @override
  State<AdjustSplitUnequally> createState() => _AdjustSplitUnequallyState();
}

class _AdjustSplitUnequallyState extends State<AdjustSplitUnequally> {
  @override
  Widget build(BuildContext context) {
    final transactionHelper = Provider.of<TransactionHelper>(context);
    final List<GeneralUser> _involvedUsers = transactionHelper.involvedUsers;
    final _totalAmount = transactionHelper.totalAmount;
    final _ledger = transactionHelper.unequalLedger;
    final _amountLeft = _totalAmount -
        _ledger.values.reduce((value, element) => value + element);
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => UserTab(
            ledger: _ledger,
            user: _involvedUsers[index],
            callback: transactionHelper.modifyUnequalLedger,
          ),
          itemCount: _involvedUsers.length,
        ),
        Column(
          children: [
            Text(
              "₹$_amountLeft OF ₹$_totalAmount LEFT",
              textAlign: TextAlign.center,
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
  final callback;
  UserTab({
    required this.user,
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
                      "₹${ledger[user]}",
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
                  Text(
                    "₹",
                    style: TextStyle(
                      fontFamily: "playfair",
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 60),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}')),
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      initialValue:
                          ledger[user] != 0 ? ledger[user].toString() : '',
                      onChanged: (amount) {
                        if (double.tryParse(amount) == null)
                          callback(user, 0.00);
                        else
                          callback(user, double.parse(amount));
                      },
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
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
                ],
              )),
        ],
      ),
    );
  }
}
