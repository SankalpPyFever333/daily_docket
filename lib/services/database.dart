import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserBooking(Map<String, dynamic> userBookingIngoMap) async {
    return await FirebaseFirestore.instance
        .collection('booking')
        .add(userBookingIngoMap);
  }

  Future<Stream<QuerySnapshot>> getBooking() async {
    return await FirebaseFirestore.instance.collection("booking").snapshots();
  }

  Future deletebooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("booking")
        .doc(id)
        .delete();
  }
}
