import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'cache/constants.dart';
import 'cache/data-processing.dart';

class StatisticsPage extends StatelessWidget {
  List users = [
    ['assets/vectors/female-avatar-1.svg', 'Ananya Palla', kGreen, 0.61, false],
    ['assets/vectors/GroupImage.jpg', 'DPS Budz', kRed, 0.22, true],
  ];
  static String route = "StatisticsPage";

  Widget getDayCards() {
    DateTime today = DateTime.now();
    DateTime _firstDayOfTheWeek =
        today.subtract(new Duration(days: today.weekday));
    List<Widget> dayList = [];
    for (var index = 1; index <= 7; index++) {
      dayList.add(
        DayCard(
          date: _firstDayOfTheWeek.add(
            Duration(days: index),
          ),
        ),
      );
    }
    return new Row(
      children: dayList,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                "Statistics",
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
                // onTap: logoutCallback,
                child: SvgPicture.asset("assets/vectors/add-contact.svg"),
              ),
            ],
          ),
          SizedBox(height: 30),
          getDayCards(),
          SizedBox(height: 30),
          RichText(
            text: TextSpan(
                text: 'OWED',
                style: TextStyle(
                    fontSize: 16, color: kGreen, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: ' / ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: kOffWhite,
                    ),
                  ),
                  TextSpan(
                    text: 'LENT',
                    style: TextStyle(
                      fontSize: 16,
                      color: kRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
          ActivityPlot(),
          Text(
            "DAYS",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: kOffWhite,
              fontFamily: 'playfair',
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kGreen.withOpacity(0.75),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                  child: Text(
                    "Lent\n₹576",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kRed.withOpacity(0.75),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                  ),
                  child: Text(
                    "Owed\n₹2576",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              // return Container(
              //   color: kOffWhite,
              //   height: 20,
              //   width: 32,
              // );
              return PickedFileProgressBarWrapper(
                icon: users[index][0],
                name: users[index][1],
                color: users[index][2],
                progress: users[index][3],
                group: users[index][4],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
            itemCount: users.length,
          ),
        ],
      ),
    );
  }
}

class ActivityPlot extends StatelessWidget {
  final List<Color> owedRedGradient = [
    const Color(0xffFF9292),
    const Color(0xffFF9292),
  ];
  final List<Color> lentGreenGradient = [
    const Color(0xff94EBCD),
    const Color(0xff94EBCD),
  ];

  List<LineChartBarData> linechartbardata() {
    final owed = LineChartBarData(
      spots: getMentorLessonChartData(DateTime.now()),
      curveSmoothness: 0.6,
      isCurved: true,
      colors: owedRedGradient,
      preventCurveOverShooting: true,
      barWidth: 4,
      dotData: FlDotData(
        show: false,
      ),
      shadow: BoxShadow(
        blurRadius: 6,
        color: kGreen,
      ),
    );
    final lent = LineChartBarData(
      show: true,
      spots: getMentorHourChartData(DateTime.now()),
      isCurved: true,
      colors: lentGreenGradient,
      curveSmoothness: 0.6,
      preventCurveOverShooting: true,
      barWidth: 4,
      dotData: FlDotData(
        show: false,
      ),
      shadow: BoxShadow(
        blurRadius: 6,
        color: kRed.withOpacity(0.85),
      ),
    );
    return [owed, lent];
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 10, right: 20, top: 20),
        height: MediaQuery.of(context).size.height * 0.20,
        child: LineChart(
          LineChartData(
            minX: 1,
            maxX: 28,
            minY: 0,
            maxY: 4,
            titlesData: LineTitles.getTitleData(),
            gridData: FlGridData(
              show: false,
              drawHorizontalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Color(0xff37434d),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: linechartbardata(),
          ),
        ),
      );
}

List<FlSpot> getMentorLessonChartData(DateTime joiningDate) {
  List<FlSpot> result = [];
  Map<int, int> map = {
    1: 0,
    4: 4,
    7: 0,
    10: 1,
    13: 0,
    16: 1,
    19: 0,
    22: 2,
    25: 0,
    28: 3,
  };
  // for (var s in mentorSchedule) {
  //   int week = (s.timing.difference(joiningDate).inDays / 7).floor() + 1;
  //   if (map.containsKey(week)) {
  //     map.update(week, (val) => val + 1);
  //   } else
  //     map[week] = 1;
  // }
  for (int i = 1; i <= 28; i++) {
    if (map.containsKey(i))
      result.add(FlSpot(i.toDouble(), map[i]!.toDouble()));
  }
  return result;
}

List<FlSpot> getMentorHourChartData(DateTime joiningDate) {
  //TODO:initialize middle weeks without values to 0;
  List<FlSpot> result = [];
  Map<int, double> map = {
    1: 0,
    4: 1,
    7: 0,
    10: 2,
    13: 0,
    16: 4,
    19: 0,
    22: 0,
    25: 3,
    28: 0,
  };
  // for (var s in mentorSchedule) {
  //   int week = (s.timing.difference(joiningDate).inDays / 7).floor() + 1;
  //   if (map.containsKey(week)) {
  //     map.update(week, (val) => val + s.duration / 60);
  //   } else
  //     map[week] = s.duration / 60;
  // }
  for (int i = 1; i <= 28; i++) {
    if (map.containsKey(i))
      result.add(FlSpot(i.toDouble(), map[i]!.toDouble()));
  }
  return result;
}

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, test) => const TextStyle(
            color: kOffWhite,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
              case 4:
                return '4';
              case 7:
                return '7';
              case 10:
                return '10';
              case 13:
                return '13';
              case 16:
                return '16';
              case 19:
                return '19';
              case 22:
                return '22';
              case 25:
                return '25';
              case 28:
                return '28';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, test) => const TextStyle(
            color: kOffWhite,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
            }
            return '';
          },
        ),
      );
}

class DayCard extends StatelessWidget {
  final DateTime date;

  DayCard({required this.date});

  @override
  Widget build(BuildContext context) {
    bool active = isActive(date);
    // bool event = iseventful(scheduleList, date);
    bool event = date.day % 2 == 0;
    Color fontColor = Colors.white;
    Color eventColor =
        active ? Colors.white.withOpacity(0.7) : kYellow.withOpacity(0.8);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 40,
      decoration: active
          ? BoxDecoration(
              color: kYellow.withOpacity(0.8),
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: kYellow.withOpacity(0.3),
                  blurRadius: 10,
                ),
              ],
            )
          : null,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 4, right: 4),
            child: Text(
              DateFormat('EEE').format(date).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: fontColor,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              date.day.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: fontColor,
              ),
            ),
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: event,
            child: Container(
              margin: EdgeInsets.only(top: 3, bottom: 10),
              height: size.height * 0.005,
              width: size.width * 0.03,
              color: eventColor,
            ),
          )
        ],
      ),
    );
  }
}

class PickedFileProgressBarWrapper extends StatelessWidget {
  final double progress;
  final String name, icon;
  final Color color;
  final bool group;
  PickedFileProgressBarWrapper(
      {required this.progress,
      required this.name,
      required this.icon,
      required this.color,
      required this.group});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final progressBarWidth = size.width * 0.5;

    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            group
                ? Image.asset(
                    icon,
                    height: 45,
                  )
                : SvgPicture.asset(
                    icon,
                    height: 45,
                  ),
            SizedBox(width: 20),
            SizedBox(
              width: progressBarWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: kOffWhite,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Visibility(
                        visible: progress < 1,
                        child: Positioned(
                          right: -60,
                          top: -7,
                          child: Text(
                            '${(progress * 100).toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: progressBarWidth * progress,
                        decoration: BoxDecoration(
                            border: Border.all(color: color, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(width: 5),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
