import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitz/constants.dart';

class GroupsPage extends StatelessWidget {
  List<List> transactionDetails = [
    ["Sparsh", 1276],
    ["Raman", -456],
    ["Raj", 816],
    ["Shrey", -654],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, top: 60, right: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Groups",
                style: TextStyle(
                  fontFamily: 'playfair',
                  color: Colors.white,
                  fontSize: 64,
                  fontStyle: FontStyle.italic,
                  // fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset("assets/vectors/add-contact.svg"),
              ),
            ],
          ),
          SizedBox(height: 14),
          TextField(
            decoration: InputDecoration(
              // isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              filled: true,
              fillColor: Color(0xff31303A),
              hintText: "Filter",
              hintStyle: TextStyle(
                  color: Color(0xffA1A1A1), fontWeight: FontWeight.w700),
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
              prefixIcon: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: SvgPicture.asset(
                  "assets/vectors/search.svg",
                ),
              ),
              prefixIconConstraints: BoxConstraints(minHeight: 50),
            ),
          ),
          SizedBox(height: 14),
          GroupWrapper(
            groupImage: 'assets/vectors/GroupImage.jpg',
            groupName: "DPS Budz",
            transactionDetails: transactionDetails,
          ),
          GroupWrapper(
            groupImage: 'assets/vectors/GroupImage2.jpg',
            groupName: "KulColony",
            transactionDetails: [],
          ),
        ],
      ),
    );
  }
}

class GroupWrapper extends StatelessWidget {
  final List<List> transactionDetails;
  final String groupName, groupImage;
  GroupWrapper(
      {required this.transactionDetails,
      required this.groupName,
      required this.groupImage});

  List<Widget> getDetails(List<List> transactionDetails) {
    List<Widget> result = [];
    for (List detail in transactionDetails) {
      result.add(DetailsText(name: detail[0], amount: detail[1].toDouble()));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  groupImage,
                  height: 80,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.7),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
              ),
              SizedBox(width: 13),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kOffWhite,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getDetails(transactionDetails),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              transactionDetails.isEmpty ? "settled up" : "you lent\n₹982",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: transactionDetails.isEmpty
                    ? kOffWhite
                    : kGreen.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsText extends StatelessWidget {
  final String name;
  final double amount;
  DetailsText({required this.name, required this.amount});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        amount > 0 ? "owes you $name ₹$amount" : "you owe $name ₹${-amount}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          color: amount > 0 ? kGreen.withOpacity(0.8) : kRed,
        ),
      ),
    );
  }
}
