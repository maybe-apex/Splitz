import 'package:splitz/models/general-users.dart';

class PrimaryUser extends GeneralUser {
  final String firstName, lastName;
  List<GeneralUser> acquaintance;
  List<String> groupUIDs;
  PrimaryUser({
    required this.firstName,
    required this.lastName,
    required this.acquaintance,
    required this.groupUIDs,
    required contactNumber,
    required avatarID,
    required String uid,
  }) : super(
          name: '$firstName + $lastName',
          avatarID: avatarID,
          uid: uid,
          contactNumber: contactNumber,
        );
}
