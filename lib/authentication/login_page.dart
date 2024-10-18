import "package:daily_docket/Admin/admin_login.dart";
import "package:daily_docket/authentication/signup.dart";
import "package:daily_docket/pages/show_all_note.dart";
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/gestures.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShowAllNote()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for this email",
          style:
              TextStyle(fontFamily: "Signi", fontSize: 20, color: Colors.black),
        )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "entered wrong password",
          style:
              TextStyle(fontFamily: "Signi", fontSize: 20, color: Colors.black),
        )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "internal server error! Try again later",
          style:
              TextStyle(fontFamily: "Signi", fontSize: 20, color: Colors.black),
        )));
      }
    }
  }

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
                  "Hello\nSign in",
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
                      "Email",
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 255, 247),
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Signi"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Enter Email",
                        prefixIcon: Icon(Icons.mail_outline),
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Color(0xFF311917),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Signi"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                          });
                        }
                        userLogin();
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
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xFF311917),
                                fontSize: 17,
                                fontFamily: "Signi",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                                text: "sign up",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Signi",
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
                                  }),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminLogin()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Are you an Admin?",
                            style: TextStyle(
                              color: Color(0xFF311917),
                              fontSize: 17,
                              fontFamily: "Signi",
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
