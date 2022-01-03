import 'package:cloud_firestore/cloud_firestore.dart';

class Friends {
  static Stream<DocumentSnapshot> getFriendsForUser(String currentUserUid) {
    return Firestore.instance
        .collection('users')
        .document(currentUserUid)
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

  static Future<void> addFriend(
    String currentUserUid,
    String friendUid,
    String friendUsername,
    String friendImageUrl,
  ) async {
    await Firestore.instance
        .collection('users')
        .document(currentUserUid)
        .updateData({
      'friends': FieldValue.arrayUnion([
        {
          'friendUid': friendUid,
          'username': friendUsername,
          'imageUrl': friendImageUrl,
        }
      ])
    });
  }
}
