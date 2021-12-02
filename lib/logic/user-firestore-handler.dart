import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';

import 'authentication.dart';
import 'user-cached-data.dart';
import 'user-data-processing.dart';

class ProfileHandler {
  final firestore = FirebaseFirestore.instance;
  final auth = Authentication();
  DateTime joiningDate = DateTime.now();

  String uid = '';

  getData(VoidCallback callback) async {
    await getCurrentUser();
    getuserScheduleData(callback);
    getuserProfileData(callback);
    getsecondaryUserData(callback);
  }

  getCurrentUser() async {
    try {
      final User user = await auth.getCurrentUser();
      uid = user.uid;
      userUID = uid;
      userEmail = user.email ?? 'email';
    } catch (error) {
      print('userProfile error -> $error');
    }
  }

  getUserProfileData(VoidCallback callback) async {
    await for (var snapshot
        in firestore.collection('userData').doc(uid).snapshots()) {
      var firstName = snapshot.get('FirstName').toString();
      var lastName = snapshot.get('LastName').toString();
      UserProfileData = User(
        batchName: snapshot.get('BatchName').toString(),
        firstName: firstName,
        idNumber: snapshot.get('IDNumber'),
        lastName: lastName,
        categoryName: snapshot.get('CategoryName').toString(),
        email: snapshot.get('email'),
        joiningDate: snapshot.get('JoiningDate').toDate(),
        gender: snapshot.get('Gender'),
        age: snapshot.get('Age'),
        phoneNumber: snapshot.get('PhoneNumber'),
        category: snapshot.get('Category'),
        qualification: snapshot.get('CategoryName'),
        specialization: snapshot.get('Specialization'),
      );
      joiningDate = snapshot.get('JoiningDate').toDate();
      userName = "$firstName $lastName";
      callback();
    }
  }

  getuserScheduleData(VoidCallback callback) async {
    await for (var snapshot in firestore
        .collection('userData/$uid/Schedule')
        .orderBy('LectureTime')
        .snapshots()) {
      userSchedule.clear();
      final schedules = snapshot.docs;
      int notificationID = 1;
      for (var schedule in schedules) {
        Schedule sch = Schedule(
          secondaryUser: schedule.get('secondaryUserName'),
          lesson: schedule.get('LessonNumber'),
          duration: schedule.get('Duration'),
          timing: schedule.get('LectureTime').toDate(),
          userScheduleID: schedule.id,
          secondaryUserScheduleID: schedule.get('secondaryUserScheduleID'),
          secondaryUserUID: schedule.get('secondaryUserUID'),
          postSessionSurvey: schedule.get('PostSessionSurvey'),
          footNotes: schedule.get('FootNotes'),
        );
        userSchedule.add(sch);
        if (sch.timing.isAfter(DateTime.now())) {
          Notify(sch.timing, sch.lesson.toString(), sch.secondaryUser,
              notificationID);
          notificationID++;
        }
      }
      userScheduleData = userScheduleData(
        nextInteraction: getNextInteraction(userSchedule),
        lastInteraction: getLastInteraction(userSchedule),
        hoursPerWeek: getLectureHourRate(joiningDate, userSchedule).last,
        lecturesPerWeek: getLectureHourRate(joiningDate, userSchedule).first,
      );
      callback();
    }
  }

  void Notify(DateTime schedule, String lesson, String secondaryUser,
      int notificationID) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          notificationLayout: NotificationLayout.BigText,
          id: notificationID,
          channelKey: 'key1',
          title: 'Schedule Reminder',
          body:
              'You have a lesson scheduled with $secondaryUser, at ${DateFormat('hh:mm a').format(schedule)} for lesson $lesson. Please be on time!'),
      schedule: NotificationCalendar.fromDate(
          date: schedule.subtract(
            Duration(minutes: 30),
          ),
          allowWhileIdle: true),
    );
  }

  getSecondaryUserData(VoidCallback callback) async {
    await for (var snapshot in firestore
        .collection('userData/$uid/secondaryUsers')
        .orderBy('FirstName')
        .snapshots()) {
      secondaryUsersList.clear();
      final secondaryUsers = snapshot.docs;
      for (var secondaryUser in secondaryUsers) {
        await firestore
            .collection('/secondaryUserInfo')
            .doc(secondaryUser.id)
            .get()
            .then((value) {
          String firstName = secondaryUser.get('FirstName');
          String lastName = secondaryUser.get('LastName');
          secondaryUser mnt = secondaryUser(
            preTestScore: value['PreTestScore'],
            uid: secondaryUser.id,
            batchName: value['BatchName'],
            firstName: firstName,
            gender: value['Gender'],
            idNumber: value['IDNumber'],
            initialLevel: value['InitialLevel'],
            joiningDate: value['JoiningDate'].toDate(),
            lastName: lastName,
            intervention: value['Intervention'],
            subDivision: value['SubDivision'],
            phoneNumber: value['PhoneNumber'],
            whatsappNumber: value['WhatsappNumber'],
            fullName: "$firstName $lastName",
            totalEngagementLectures: 0,
            totalEngagementTime: Duration(minutes: 0),
          );
          secondaryUsersList.add(mnt);
        });
      }
      callback();
    }
  }

  DeclareCompletionData(VoidCallback callback) async {
    await for (var snapshot in firestore
        .collection('userData/$userUID/Schedule')
        .orderBy('LectureTime')
        .snapshots()) {
      for (secondaryUser secondaryUser in secondaryUsersList) {
        secondaryUser.totalEngagementLectures = 0;
        secondaryUser.totalEngagementTime = Duration(minutes: 0);
      }
      final schedules = snapshot.docs;
      for (var schedule in schedules) {
        for (secondaryUser secondaryUser in secondaryUsersList) {
          if (secondaryUser.uid == schedule.get('secondaryUserUID') &&
              schedule.get('PostSessionSurvey')) {
            secondaryUser.totalEngagementLectures++;
            secondaryUser.totalEngagementTime +=
                Duration(minutes: schedule.get('Duration'));
          }
        }
      }
      callback();
    }
  }

  DropsecondaryUser(secondaryUser secondaryUser) {
    Map<String, dynamic> data = {
      'DateModified': Timestamp.fromDate(DateTime.now()),
      'EngagementTime': secondaryUser.totalEngagementTime.inMinutes,
      'LessonCount': secondaryUser.totalEngagementLectures,
      'secondaryUserName': secondaryUser.fullName,
      'secondaryUserUID': secondaryUser.uid,
      'userName': userName,
      'userUID': userUID
    };
    firestore.collection('Dropout').add(data);
    firestore.collection('Logs').add({
      'DateModified': Timestamp.fromDate(DateTime.now()),
      'Event': 'Dropout from Program',
      'userName': userName,
      'OldData': 'Does not exist',
      'NewData': data,
      'UID': userUID,
    });
    firestore
        .collection('userData/$userUID/secondaryUsers')
        .doc(secondaryUser.uid)
        .delete();
  }

  DeclareCompletion(secondaryUser secondaryUser) {
    Map<String, dynamic> data = {
      'DateDeclared': Timestamp.fromDate(DateTime.now()),
      'EngagementTime': secondaryUser.totalEngagementTime.inMinutes,
      'LessonCount': secondaryUser.totalEngagementLectures,
      'secondaryUserName': secondaryUser.fullName,
      'secondaryUserUID': secondaryUser.uid,
      'userName': userName,
      'userUID': userUID,
      'userGender': userProfileData.gender,
      'secondaryUserGender': secondaryUser.gender,
      'userBatch': userProfileData.batchName,
      'secondaryUserBatch': secondaryUser.batchName,
      'secondaryUserInitialLevel': secondaryUser.initialLevel,
      'PreTestScore': secondaryUser.preTestScore,
      'secondaryUserID': secondaryUser.idNumber,
      'userID': userProfileData.idNumber,
      'secondaryUserJoiningDate': Timestamp.fromDate(secondaryUser.joiningDate),
      'userCategory': userProfileData.category,
    };
    firestore.collection('Completion').add(data);
    firestore.collection('Logs').add({
      'DateModified': Timestamp.fromDate(DateTime.now()),
      'Event': 'Completion of Program',
      'userName': userName,
      'OldData': 'Does not exist',
      'NewData': data,
      'UID': userUID,
    });
  }
}

class user {
  final String batchName,
      firstName,
      lastName,
      qualification,
      email,
      gender,
      category,
      categoryName,
      specialization;
  final int idNumber, phoneNumber, age;
  final DateTime joiningDate;

  user(
      {required this.batchName,
      required this.firstName,
      required this.email,
      required this.gender,
      required this.joiningDate,
      required this.idNumber,
      required this.lastName,
      required this.qualification,
      required this.phoneNumber,
      required this.age,
      required this.category,
      required this.categoryName,
      required this.specialization});
}

class userScheduleData {
  final Duration lastInteraction, nextInteraction;
  final double lecturesPerWeek, hoursPerWeek;

  userScheduleData(
      {required this.nextInteraction,
      required this.lastInteraction,
      required this.hoursPerWeek,
      required this.lecturesPerWeek});
}

class Schedule {
  String secondaryUser,
      secondaryUserUID,
      userScheduleID,
      secondaryUserScheduleID,
      footNotes;
  DateTime timing;
  int duration, lesson;
  bool postSessionSurvey;
  Schedule({
    required this.secondaryUserUID,
    required this.secondaryUserScheduleID,
    required this.userScheduleID,
    required this.secondaryUser,
    required this.lesson,
    required this.duration,
    required this.timing,
    required this.postSessionSurvey,
    required this.footNotes,
  });
}

class secondaryUser {
  String firstName,
      uid,
      lastName,
      batchName,
      fullName,
      initialLevel,
      gender,
      subDivision,
      intervention;
  int phoneNumber,
      idNumber,
      totalEngagementLectures,
      whatsappNumber,
      preTestScore;
  DateTime joiningDate;
  Duration totalEngagementTime;

  secondaryUser({
    required this.firstName,
    required this.preTestScore,
    required this.batchName,
    required this.uid,
    required this.joiningDate,
    required this.lastName,
    required this.fullName,
    required this.initialLevel,
    required this.gender,
    required this.intervention,
    required this.subDivision,
    required this.idNumber,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.totalEngagementLectures,
    required this.totalEngagementTime,
  });
}

class Response {
  int score;
  String answer, question;

  Response({required this.score, required this.answer, required this.question});
}

class Lesson {
  String title, duration, url;
  List<String>? videoLinks;
  int number;

  Lesson(
      {required this.title,
      required this.number,
      required this.duration,
      required this.url,
      this.videoLinks});
}

class Completion {
  String userName,
      secondaryUserName,
      userUID,
      secondaryUserUID,
      userGender,
      secondaryUserBatch,
      userBatch,
      secondaryUserGender,
      secondaryUserInitialLevel,
      userCategory;
  DateTime dateDeclared, secondaryUserJoiningDate;
  Duration engagementTime;
  int lessonCount, preTestScore, userID, secondaryUserID;
  Completion(
      {required this.userName,
      required this.userUID,
      required this.userCategory,
      required this.secondaryUserInitialLevel,
      required this.userID,
      required this.secondaryUserID,
      required this.secondaryUserJoiningDate,
      required this.secondaryUserName,
      required this.dateDeclared,
      required this.engagementTime,
      required this.lessonCount,
      required this.userGender,
      required this.secondaryUserBatch,
      required this.userBatch,
      required this.secondaryUserGender,
      required this.preTestScore,
      required this.secondaryUserUID});
}
