import 'package:flutter/material.dart';
import 'package:splitz/cache/enumerators.dart';
import 'package:splitz/models/general-users.dart';

class TransactionHelper extends ChangeNotifier {
  String _transactionTitle = '';
  SplitType _splitType = SplitType.Equally;
  double _totalAmount = 0;
  List<GeneralUser> _involvedUsers = <GeneralUser>[];
  Map<GeneralUser, double> _unequalLedger = {};
  List<GeneralUser> _equalLedger = [];
  Map<GeneralUser, int> _shareLedger = {};
  Map<GeneralUser, double> _percentageLedger = {};

  get currentSplit => _splitType;
  get involvedUsers => _involvedUsers;
  String get transactionTitle => _transactionTitle;
  double get totalAmount => _totalAmount;
  Map<GeneralUser, double> get unequalLedger => _unequalLedger;
  List<GeneralUser> get equalLedger => _equalLedger;
  Map<GeneralUser, int> get shareLedger => _shareLedger;
  Map<GeneralUser, double> get percentageLedger => _percentageLedger;

  void setSplitType(value) {
    _splitType = value;
    notifyListeners();
  }

  void setTransactionTitle(String value) {
    _transactionTitle = value;
  }

  void setTotalAmount(double value) {
    _totalAmount = value;
  }

  void addInvolvedUsers(GeneralUser newUser) {
    if (!_involvedUsers.contains(newUser)) _involvedUsers.add(newUser);
    _unequalLedger[newUser] = 0;
    _shareLedger[newUser] = 0;
    _percentageLedger[newUser] = 0;
    _equalLedger.add(newUser);
    notifyListeners();
  }

  void removeInvolvedUsers(GeneralUser oldUser) {
    _involvedUsers.remove(oldUser);
    _unequalLedger.remove(oldUser);
    _shareLedger.remove(oldUser);
    _percentageLedger.remove(oldUser);
    _equalLedger.remove(oldUser);
    notifyListeners();
  }

  void modifyUnequalLedger(user, amount) {
    _unequalLedger[user] = amount;
    notifyListeners();
  }

  void modifyEqualLedger(user) {
    if (_equalLedger.contains(user)) _equalLedger.remove(user);
    _equalLedger.add(user);
    notifyListeners();
  }

  void modifyShareLedger(user, share) {
    _shareLedger[user] = share;
    notifyListeners();
  }

  void modifyPercentageLedger(user, percentage) {
    if (0 <= percentage && percentage <= 100)
      _percentageLedger[user] = percentage;
    notifyListeners();
  }

  void resetLedgers() {
    _shareLedger = {};
    _percentageLedger = {};
    _unequalLedger = {};
  }
}
