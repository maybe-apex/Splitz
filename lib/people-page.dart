import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';

class PeoplePage extends StatefulWidget {
  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  String activeFilter = "All";

  void filterCallback(String user) {
    setState(() {
      activeFilter = user;
    });
  }

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
                "People",
                style: TextStyle(
                  fontFamily: 'playfair',
                  color: Colors.white,
                  fontSize: 64,
                  fontStyle: FontStyle.italic,
                  // fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                // onTap: () => Navigator.pop(context),
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
          SizedBox(height: 10),
          Row(
            children: [
              FilterButton(
                title: "All",
                isActive: activeFilter,
                callback: filterCallback,
              ),
              FilterButton(
                title: "People who owe you",
                isActive: activeFilter,
                callback: filterCallback,
              ),
            ],
          ),
          Row(
            children: [
              FilterButton(
                title: "People you owe",
                isActive: activeFilter,
                callback: filterCallback,
              ),
              FilterButton(
                title: "Unclear balances",
                isActive: activeFilter,
                callback: filterCallback,
              ),
            ],
          ),
          SizedBox(height: 30),
          UserTab(
            name: "Ananya Palla",
            image: "assets/vectors/female-avatar-1.svg",
            balance: 2576,
          ),
          SizedBox(height: 20),
          UserTab(
            name: "Vivek Patel",
            image: "assets/vectors/male-avatar-1.svg",
            balance: -388,
          ),
          SizedBox(height: 20),
          UserTab(
            name: "Bhavya Mishra",
            image: "assets/vectors/female-avatar-2.svg",
            balance: 0,
          ),
        ],
      ),
    );
  }
}

class UserTab extends StatelessWidget {
  final String name, image;
  final double balance;
  UserTab({required this.image, required this.balance, required this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                child: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kOffWhite),
                ),
              )
            ],
          ),
          Text(
            balance == 0
                ? "Settled up"
                : balance > 0
                    ? "owes you\n₹$balance"
                    : "you owe\n₹${-balance}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: balance == 0
                  ? kOffWhite
                  : balance > 0
                      ? kGreen.withOpacity(0.8)
                      : kRed,
            ),
          )
        ],
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
