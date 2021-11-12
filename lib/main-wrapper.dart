import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitz/groups-page.dart';
import 'package:splitz/new-transaction-page.dart';
import 'people-page.dart';
import 'constants.dart';

class MainWrapper extends StatefulWidget {
  static String route = "MainWrapper";

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  Widget currentPage(currentIndex) {
    return currentIndex == 0
        ? PeoplePage()
        : currentIndex == 1
            ? GroupsPage()
            : PeoplePage();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, NewTransaction.route),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: kYellow,
                blurRadius: 10,
                spreadRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SvgPicture.asset("assets/vectors/add-expense.svg"),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: kGrey,
        currentIndex: currentIndex,
        iconSize: 20,
        backgroundColor: Color(0xff31303A),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                "assets/vectors/people-bnb.svg",
                color: currentIndex == 0 ? Colors.white : kGrey,
              ),
            ),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                "assets/vectors/groups-bnb.svg",
                color: currentIndex == 1 ? Colors.white : kGrey,
              ),
            ),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                "assets/vectors/stats-bnb.svg",
                color: currentIndex == 2 ? Colors.white : kGrey,
              ),
            ),
            label: 'Statistics',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: currentPage(currentIndex),
      ),
    );
  }
}
