import 'package:daily_docket/Admin/admin_login.dart';
import 'package:daily_docket/authentication/login_page.dart';
import 'package:daily_docket/authentication/phone_authentication.dart';
import 'package:daily_docket/authentication/signup.dart';
import 'package:daily_docket/pages/create_note.dart';
import 'package:daily_docket/pages/show_all_note.dart';
import 'package:daily_docket/pages/update_note_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "firebase_options.dart";
import 'package:daily_docket/services/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    _checkLogInStatus();
    super.initState();
  }

  Future<void> _checkLogInStatus() async {
    bool? loggedInStatus = await SharedPreferenceHelper().getLoginStatus();

    setState(() {
      isLoggedIn = loggedInStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Docket',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn! ? ShowAllNote() : LoginPage(),
    );
  }
}
