import 'general-users.dart';

class Group {
  final String name, uid;
  final GeneralUser creator;
  final List<GeneralUser> groupMembers;
  Group({
    required this.name,
    required this.creator,
    required this.groupMembers,
    required this.uid,
  });
  addUser(GeneralUser newUser) {
    groupMembers.add(newUser);
  }
}
