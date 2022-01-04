import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    String friendUid,
    String friendUsername,
    String friendImageUrl,
  ) async {
    final currentUser = await FirebaseAuth.instance.currentUser();

    final currentUserDoc = await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();

    await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .updateData({
      'friends': FieldValue.arrayUnion([
        {
          'friendUid': friendUid,
          'username': friendUsername,
          'imageUrl': friendImageUrl,
        }
      ])
    });

    await Firestore.instance
        .collection('users')
        .document(friendUid)
        .updateData({
      'friends': FieldValue.arrayUnion([
        {
          'friendUid': currentUser.uid,
          'username': currentUserDoc.data['username'],
          'imageUrl': currentUserDoc.data['imageUrl'],
        }
      ])
    });
  }
}
