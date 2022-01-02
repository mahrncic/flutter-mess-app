import 'package:cloud_firestore/cloud_firestore.dart';

class Friends {
  static Stream<QuerySnapshot> getFriendsForUser(String currentUserUid) {
    return Firestore.instance
        .collection('users/$currentUserUid/friends')
        .snapshots();
  }

  static Future<void> deleteFriend(
    String currentUserUid,
    String friendUid,
  ) async {
    final userFriends =
        Firestore.instance.collection('users/$currentUserUid/friends');
    await userFriends.document(friendUid).delete();
  }

  static Stream<QuerySnapshot> searchByUsername(String searchValue) {
    return Firestore.instance.collection('users').snapshots();
  }
}
