import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    userInfoMap['uid'] = uid;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userInfoMap);
  }

  Future addUserNotes(Map<String, dynamic> userNoteInfoMap) async {
    // add uid to the note map object.
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    userNoteInfoMap['uid'] = uid;
    return await FirebaseFirestore.instance
        .collection('usernotes')
        .add(userNoteInfoMap);
  }

  Future<Stream<QuerySnapshot>> getAllNotesForAdmin() async {
    return await FirebaseFirestore.instance.collection("usernotes").snapshots();
  }

  Future<Stream<QuerySnapshot>> getAllNotesOfUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }

    return await FirebaseFirestore.instance
        .collection("usernotes")
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Future deleteNote(String noteId) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    return await FirebaseFirestore.instance
        .collection("usernotes")
        .doc(noteId)
        .delete();
  }

  Future updateNote(Map<String, dynamic> updateNoteObject) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    return await FirebaseFirestore.instance
        .collection("usernotes")
        .doc(uid)
        .update(updateNoteObject);
  }
}
