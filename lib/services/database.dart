import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
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

  Future<Stream<QuerySnapshot>> getBooking() async {
    return await FirebaseFirestore.instance.collection("usernotes").snapshots();
  }

  Future deletebooking() async {
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
}
