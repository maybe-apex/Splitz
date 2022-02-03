import 'package:splitz/cache/enumerators.dart';
import 'package:splitz/models/general-users.dart';
import 'package:splitz/models/groups.dart';
import 'package:splitz/models/primary-user.dart';
import 'package:splitz/models/transactions.dart';

GeneralUser suVivek = GeneralUser(
  name: 'Vivek Patel',
  uid: 'UuCIHxgiqwUn3oz0PVYdQrBb33d2',
  contactNumber: 123123,
  avatarID: AvatarID.Male1,
);
GeneralUser suAnanya = GeneralUser(
  name: 'Ananya Palla',
  uid: 'i4za0HvsJgaVk1TYsgooQ3HIbcB3',
  contactNumber: 456456,
  avatarID: AvatarID.Female1,
);
GeneralUser suBhavya = GeneralUser(
  name: 'Bhavya Mishra',
  uid: 'mg5cuJIthKNr3A3zIHXD65Z7TqA3',
  contactNumber: 789789,
  avatarID: AvatarID.Female2,
);
Group puGroup1 = Group(
  name: 'DPS Budz',
  uid: 'uidDPS',
  creator: pu,
  groupMembers: puAcquaintances,
);
Group puGroup2 = Group(
  name: 'kul Colony',
  uid: 'uidkul',
  creator: pu,
  groupMembers: puAcquaintances,
);
List<GeneralUser> puAcquaintances = <GeneralUser>[
  suVivek,
  suAnanya,
  suBhavya,
];
List<Group> puGroups = <Group>[
  puGroup1,
  puGroup2,
];
PrimaryUser pu = PrimaryUser(
  firstName: 'Utkarsh',
  lastName: 'Omer',
  acquaintance: puAcquaintances,
  groupUIDs: ['groupUID'],
  contactNumber: 7379551188,
  uid: 'Xbw8WpGilledHQxoFmO1f31Kzm93',
  avatarID: AvatarID.Male2,
);

List<GeneralTransaction> transactions = <GeneralTransaction>[];

GeneralTransaction demoTransaction = GeneralTransaction(
  creator: pu,
  title: 'Generic Title',
  amount: 123,
  timeStamp: DateTime.parse('19700101'),
  involvedUsers: puAcquaintances,
  splitType: SplitType.Equally,
  settlements: [
    Settlement(
      amount: 12,
      lender: pu,
      debtor: suBhavya,
      transactionUID: '789',
    )
  ],
  uid: '12344321',
);
