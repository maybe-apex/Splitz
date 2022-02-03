import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:splitz/adjust-split-wrapper.dart';
import 'package:splitz/cache/constants.dart';
import 'package:splitz/cache/enumerators.dart';
import 'package:splitz/cache/local-data.dart';
import 'package:splitz/logic/transaction-helper.dart';
import 'package:splitz/models/general-users.dart';

import 'models/transactions.dart';

class NewTransaction extends StatefulWidget {
  static String route = "NewTransaction";

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime _pickedDate = DateTime.now();
  void datePicker() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date != null) {
      setState(() {
        _pickedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionHelper = Provider.of<TransactionHelper>(context);
    final _currentSplit = transactionHelper.currentSplit;
    final _transactionTitle = transactionHelper.transactionTitle;
    final _totalAmount = transactionHelper.totalAmount;
    final _splitType = transactionHelper.currentSplit;
    final TextEditingController _suggestionsController =
        TextEditingController();
    List<GeneralUser> _involvedUsers = transactionHelper.involvedUsers;

    List<Settlement> getSettlement(double totalAmount, SplitType splitType,
        List<GeneralUser> involvedUsers) {
      if (splitType == SplitType.Equally) {
        final ledger = transactionHelper.equalLedger;
        final splitAmount = totalAmount / ledger.length;
        return ledger
            .map((user) => Settlement(
                lender: pu,
                debtor: user,
                amount: splitAmount,
                transactionUID: '1234'))
            .toList();
      }
      return [];
    }

    void addTransaction() {
      transactions.add(
        GeneralTransaction(
          creator: pu,
          title: _transactionTitle,
          amount: _totalAmount,
          timeStamp: _pickedDate,
          involvedUsers: _involvedUsers,
          splitType: SplitType.Equally,
          settlements:
              getSettlement(_totalAmount, _currentSplit, _involvedUsers),
          uid: '567567',
        ),
      );
      print(transactions.last.settlements);
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    "New Transaction",
                    style: TextStyle(
                      fontFamily: 'playfair',
                      color: Colors.white,
                      fontSize: 64,
                      fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30),
                  TypeAheadFormField<GeneralUser?>(
                    hideOnEmpty: true,
                    minCharsForSuggestions: 1,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _suggestionsController,
                      maxLines: null,
                      style: TextStyle(color: kOffWhite),
                      cursorColor: kGrey,
                      decoration: InputDecoration(
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SingleChildScrollView(
                            // scrollDirection: Axis.horizontal,
                            child: Text(
                              "With you and:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        filled: true,
                        fillColor: Color(0xff31303A),
                        hintText: "Enter names of people involved",
                        hintStyle: TextStyle(
                            color: Color(0xffA1A1A1),
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0x00003670), width: 30),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0x00003670), width: 30),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    hideSuggestionsOnKeyboardHide: true,
                    suggestionsCallback: (String query) =>
                        List.of(puAcquaintances)
                            .where(
                              (element) => element.name.toLowerCase().contains(
                                    query.toLowerCase(),
                                  ),
                            )
                            .toList(),
                    itemBuilder: (context, GeneralUser? suggestions) {
                      final user = suggestions!;
                      return ListTile(
                        dense: true,
                        tileColor: Color(0xff31303A),
                        textColor: kOffWhite,
                        title: Text(user.name),
                      );
                    },
                    noItemsFoundBuilder: (context) => ListTile(
                      dense: true,
                      tileColor: Color(0xff31303A),
                      textColor: kOffWhite,
                      title: Text('No User Found'),
                    ),
                    onSuggestionSelected: (GeneralUser? selectedUser) {
                      _suggestionsController.clear();
                      Provider.of<TransactionHelper>(context, listen: false)
                          .addInvolvedUsers(selectedUser!);
                    },
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 6,
                      alignment: WrapAlignment.start,
                      children: _involvedUsers
                          .map(
                            (user) => InkWell(
                              onTap: () => Provider.of<TransactionHelper>(
                                      context,
                                      listen: false)
                                  .removeInvolvedUsers(user),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  color: Color(0xff31303A),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Text(
                                  user.name.split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  InputForm(
                    fieldName: 'transactionDescription',
                    callback: transactionHelper.setTransactionTitle,
                  ),
                  SizedBox(height: 30),
                  InputForm(
                    fieldName: 'amount',
                    callback: transactionHelper.setTotalAmount,
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 60),
                        child: SvgPicture.asset("assets/vectors/calendar.svg"),
                      ),
                      SizedBox(width: 10),
                      DatePicker(
                        callback: datePicker,
                        pickedDate: _pickedDate,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Paid by",
                        style: TextStyle(
                            fontSize: 14,
                            color: kOffWhite.withOpacity(0.7),
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: Text(
                            "you",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: Color(0XFF413F49),
                            ),
                            color: Color(0XFF1D1C23),
                          ),
                        ),
                      ),
                      Text(
                        "and split",
                        style: TextStyle(
                            fontSize: 14,
                            color: kOffWhite.withOpacity(0.7),
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AdjustSplitWrapper.route),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: Text(
                            getSplitNameByType(_currentSplit).toLowerCase() +
                                '.',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: Color(0XFF413F49),
                            ),
                            color: Color(0XFF1D1C23),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ExitConfirmButtons(
                        label: "Exit",
                        callback: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ExitConfirmButtons(
                        label: "Confirm Transaction",
                        callback: addTransaction,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExitConfirmButtons extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  ExitConfirmButtons({required this.label, required this.callback});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: label == "Exit" ? kRed.withOpacity(0.7) : kGreen,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: label == "Exit" ? kRed.withOpacity(0.7) : kGreen,
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

class DatePicker extends StatelessWidget {
  final VoidCallback callback;
  final DateTime pickedDate;
  DatePicker({required this.callback, required this.pickedDate});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: callback,
            child: Container(
              alignment: Alignment.center,
              // width: size.width * 0.4,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 2,
                  color: Color(0XFF413F49),
                ),
                color: Color(0XFF1D1C23),
              ),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                DateFormat('EEE,dd MMM').format(pickedDate),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kOffWhite,
                  // fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  final String fieldName;
  final callback;
  InputForm({required this.fieldName, required this.callback});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 60),
          child: SvgPicture.asset(fieldName == 'amount'
              ? "assets/vectors/rupee.svg"
              : "assets/vectors/reciept.svg"),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            onChanged: (String value) => fieldName == 'amount'
                ? callback(double.parse(value))
                : callback(value),
            inputFormatters: fieldName == 'amount'
                ? [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}')),
                  ]
                : null,
            keyboardType: fieldName == 'amount'
                ? TextInputType.numberWithOptions(decimal: true)
                : null,
            cursorColor: Colors.white,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText:
                  fieldName == 'amount' ? "0.00" : "Transaction Description",
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xffA1A1A1),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffA1A1A1), width: 4),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 4),
              ),
            ),
          ),
        ),
        SizedBox(width: 15),
      ],
    );
  }
}
