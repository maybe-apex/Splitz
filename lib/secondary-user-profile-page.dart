import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitz/cache/local-data.dart';
import 'cache/constants.dart';
import 'new-transaction-page.dart';

class SecondaryUserProfilePage extends StatelessWidget {
  static String route = "SecondaryUserProfilePage";
  List transactions = [
    // ["Mon\n07", "Post Midsem Outing", 1411.12],
    ["Sat\n04", "CellPhone Bill", -1000],
    ["Thr\n02", "Dominos", 0],
    ["Mon\n07", "Post Midsem Outing", 1411.12],
    ["Sat\n04", "CellPhone Bill", -1000],
    ["Thr\n02", "Dominos", 0],
    ["Mon\n07", "Post Midsem Outing", 1411.12],
    ["Sat\n04", "CellPhone Bill", -1000],
    ["Thr\n02", "Dominos", 0],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 20),
        child: FloatingActionButton(
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 30,
              top: MediaQuery.of(context).size.height * 0.09,
            ),
            decoration: BoxDecoration(
              color: Color(0xff31303A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset("assets/vectors/back.svg"),
                ),
                SizedBox(height: 30),
                Container(
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffA1A1A1).withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: Offset(0, 4)),
                            ],
                            color: kOffWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Hero(
                            tag: suVivek.name,
                            child: SvgPicture.asset(
                              "assets/vectors/male-avatar-1.svg",
                              height: 120,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "You are owed ₹411.12",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: kGreen.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                "You owe Vivek ₹1000 in non group expenses",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Vivek owes you ₹1411.12 in ”Post Midsem outing”",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Vivek Patel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: kYellow,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: kYellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Text(
                          "Settle",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: kRed,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: kRed,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Text(
                          "Remind",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "October 2021",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'playfair',
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TransactionWrapper(
                          date: transactions[index][0],
                          title: transactions[index][1],
                          amount: transactions[index][2] * 1.0 / 1.0,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 20);
                      },
                      itemCount: transactions.length,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TransactionWrapper extends StatelessWidget {
  final String date, title;
  final double amount;
  TransactionWrapper(
      {required this.amount, required this.title, required this.date});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 35),
              child: Text(
                date,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
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
              child: SvgPicture.asset(
                "assets/vectors/bill.svg",
                height: 25,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          amount == 0
              ? "settled"
              : amount > 0
                  ? "you lent\n₹$amount"
                  : "you borrowed\n₹${-amount}",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            color: amount == 0
                ? kOffWhite.withOpacity(0.5)
                : amount > 0
                    ? kGreen.withOpacity(0.8)
                    : kRed,
          ),
        ),
      ],
    );
  }
}
