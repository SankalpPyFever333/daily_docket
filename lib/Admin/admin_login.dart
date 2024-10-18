import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_docket/Admin/show_note_to_admin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:flutter/gestures.dart";

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String? username, password;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 50, left: 30),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xFF005082),
                  Color(0xFF0083B0),
                  Color(0xFF00B4DB)
                ])),
                child: Text(
                  "Admin \nLogin Panel",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              padding: EdgeInsets.only(top: 40, left: 30, right: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 255, 247),
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Signi"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter username';
                        }
                        return null;
                      },
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        labelText: "Enter username",
                        prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 255, 247),
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Signi"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Enter Password",
                        prefixIcon: Icon(Icons.password_outlined),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          loginAdmin();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF005082),
                            Color(0xFF0083B0),
                            Color(0xFF00B4DB)
                          ]),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "LOG IN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Signi",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != usernameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "invalid username",
            style: TextStyle(fontFamily: "Signi"),
          )));
        } else if (result.data()['password'] !=
            passwordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "invalid password",
            style: TextStyle(fontFamily: "Signi"),
          )));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShowNotesToAdmin()));
        }
      });
    });
  }
}
