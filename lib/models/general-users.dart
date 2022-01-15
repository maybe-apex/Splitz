import 'package:splitz/cache/enumerators.dart';

class GeneralUser {
  String name = 'dName', uid = 'dUID';
  AvatarID avatarID = AvatarID.none;
  int contactNumber = -1;
  GeneralUser({
    required this.name,
    required this.uid,
    required this.contactNumber,
    required this.avatarID,
  });

  @override
  String toString() {
    return 'GeneralUser{name: $name, uid: $uid, avatarID: $avatarID, contactNumber: $contactNumber}';
  }
}
