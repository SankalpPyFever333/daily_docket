import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userInfoMap);
  }

  Future addUserNotes(Map<String, dynamic> userBookingIngoMap) async {
    return await FirebaseFirestore.instance
        .collection('booking')
        .add(userBookingIngoMap);
  }

  Future<Stream<QuerySnapshot>> getAllNotesForAdmin() async {
    return await FirebaseFirestore.instance.collection("usernotes").snapshots();
  }

  Future deleteNote() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    return await FirebaseFirestore.instance
        .collection("usernotes")
        .doc(uid)
        .delete();
  }
  Future updateNote() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    return await FirebaseFirestore.instance
        .collection("usernotes")
        .doc(uid)
        .update(data);
  }
}
