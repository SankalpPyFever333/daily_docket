import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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

  Future deleteUser(String userId) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .delete();
  }

  Future<DocumentSnapshot> fetchNoteToUpdate(String noteId) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection("usernotes")
        .doc(noteId)
        .get();
    return docSnapshot;
  }

  Future updateNote(
      Map<String, dynamic> updateNoteObject, String noteId) async {
    return await FirebaseFirestore.instance
        .collection("usernotes")
        .doc(noteId)
        .update(updateNoteObject);
  }

  Future fetchAlUser() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }
}
