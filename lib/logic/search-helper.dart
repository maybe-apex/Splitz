import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHelper {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
