import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splitz/cache/enumerators.dart';
import 'package:splitz/cache/local-data.dart';
import 'package:splitz/logic/search-helper.dart';
import 'package:splitz/secondary-user-profile-page.dart';
import 'cache/constants.dart';

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

  void logoutCallback() {
    FirebaseAuth.instance.signOut();
  }

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(String value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.length == 0 && value.length == 1) {
      SearchHelper().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; i++) {
          queryResultSet.add(docs.docs[i].data());
        }
        print(queryResultSet);
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['FirstName'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  Widget buildResultCard(data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Container(
        child: Text(
          data['FirstName'],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
    );
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
                onTap: logoutCallback,
                child: SvgPicture.asset("assets/vectors/add-contact.svg"),
              ),
            ],
          ),
          SizedBox(height: 14),
          TextField(
            onChanged: (val) {
              initiateSearch(val);
            },
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
          // GridView.count(
          //   padding: EdgeInsets.only(left: 10, right: 10),
          //   crossAxisCount: 2,
          //   crossAxisSpacing: 4,
          //   mainAxisSpacing: 4,
          //   primary: false,
          //   shrinkWrap: true,
          //   children: tempSearchStore.map((e) => buildResultCard(e)).toList(),
          // ),
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
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => UserTab(
              name: puAcquaintances[index].name,
              balance: 2576.0,
              image: getAvatarByID(puAcquaintances[index].avatarID),
            ),
            separatorBuilder: (context, int) => SizedBox(height: 20),
            itemCount: puAcquaintances.length,
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
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(SecondaryUserProfilePage.route),
      child: Padding(
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
