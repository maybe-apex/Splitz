import 'package:splitz/cache/enumerators.dart';
import 'general-users.dart';

class GeneralTransaction {
  String uid, title;
  double amount;
  DateTime timeStamp;
  GeneralUser creator;
  List<GeneralUser> involvedUsers;
  SplitType splitType;
  List<Settlement> settlements;
  GeneralTransaction(
      {required this.creator,
      required this.title,
      required this.amount,
      required this.timeStamp,
      required this.involvedUsers,
      required this.splitType,
      required this.settlements,
      required this.uid});

  @override
  String toString() {
    return 'GeneralTransaction{uid: $uid, title: $title, amount: $amount, timeStamp: $timeStamp, creator: $creator, involvedUsers: $involvedUsers, splitType: $splitType, settlements: $settlements}';
  }
}

class Settlement {
  GeneralUser lender, debtor;
  String transactionUID;
  double amount;
  Settlement({
    required this.amount,
    required this.lender,
    required this.debtor,
    required this.transactionUID,
  });

  @override
  String toString() {
    return 'Settlement{lender: $lender, debtor: $debtor, transactionUID: $transactionUID, amount: $amount}';
  }
}
