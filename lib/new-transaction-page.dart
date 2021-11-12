import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:splitz/constants.dart';

DateTime pickedDate = DateTime.now();

class NewTransaction extends StatefulWidget {
  static String route = "NewTransaction";

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  void datePicker() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "With you and:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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
                    borderSide: BorderSide(color: Color(0x00003670), width: 30),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x00003670), width: 30),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              InputForm(
                iconLocation: "assets/vectors/reciept.svg",
                hintText: "Transaction Description",
              ),
              SizedBox(height: 30),
              InputForm(
                iconLocation: "assets/vectors/rupee.svg",
                hintText: "0.00",
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 60),
                    child: SvgPicture.asset("assets/vectors/calendar.svg"),
                  ),
                  SizedBox(width: 10),
                  DatePicker(callback: datePicker),
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
                    onTap: () {},
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      child: Text(
                        "equally",
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
                  ),
                  ExitConfirmButtons(label: "Confirm Transaction"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ExitConfirmButtons extends StatelessWidget {
  final String label;
  ExitConfirmButtons({required this.label});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
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

class DatePickerWrapper extends StatefulWidget {
  @override
  _DatePickerWrapperState createState() => _DatePickerWrapperState();
}

class _DatePickerWrapperState extends State<DatePickerWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void datePicker() async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (date != null) {
        setState(() {
          pickedDate = date;
        });
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DatePicker(callback: datePicker),
        ],
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  final VoidCallback callback;
  DatePicker({required this.callback});
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
  final String hintText, iconLocation;
  InputForm({required this.hintText, required this.iconLocation});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 60),
          child: SvgPicture.asset(iconLocation),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            cursorColor: Colors.white,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: hintText,
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
