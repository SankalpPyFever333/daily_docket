import "package:daily_docket/authentication/login_page.dart";
import "package:daily_docket/pages/show_all_note.dart";
import "package:daily_docket/services/shared_pref.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/gestures.dart";
import "package:daily_docket/services/database.dart";
import "package:flutter/services.dart";

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, email, phoneNo, password;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

// for checking, we need validator, that is available in TextFormField, we use this instead of TextField.

  registration() async {
    try {
      // below code stores the authentication details.
      if (email != null &&
          password != null &&
          name != null &&
          phoneNo != null) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
      }

      // saving data to device using shared_preference:

      await SharedPreferenceHelper().saveUserEmail(emailController.text);
      await SharedPreferenceHelper().saveUserName(nameController.text);
      await SharedPreferenceHelper().saveUserId(passwordController.text);
      await SharedPreferenceHelper().saveUserImage(
          "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=600");

      // below code store the user's data in the collection.

      Map<String, dynamic> userInfo = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": contactController.text,
        "password": passwordController.text,
        "Image":
            "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=600"
      };

      // add above data to collection:
      await DatabaseMethods().addUserDetails(userInfo);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Registered successfully",
        style: TextStyle(fontSize: 20, fontFamily: "Signi"),
      )));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShowAllNote()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "password is too weak",
          style: TextStyle(fontSize: 20, fontFamily: "Signi"),
        )));
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Account already exists",
          style: TextStyle(fontSize: 20, fontFamily: "Signi"),
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
                  "Create Your Account",
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
                      "Name",
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 255, 247),
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Signi"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter name';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        labelText: "Enter Name",
                        prefixIcon: Icon(Icons.abc_outlined),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                      height: 30,
                    ),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 255, 247),
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Signi"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\+?[0-9]*')),
                        LengthLimitingTextInputFormatter(13)
                      ],
                      controller: contactController,
                      decoration: InputDecoration(
                        hintText: "Phone",
                        labelText: "Enter Phone",
                        prefixIcon: Icon(Icons.phone_android_rounded),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            name = nameController.text;
                            password = passwordController.text;
                            phoneNo = contactController.text;
                          });
                        }

                        registration();
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
                          "SIGN UP",
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
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                color: Color(0xFF311917),
                                fontSize: 17,
                                fontFamily: "Signi",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                                text: "LOG IN",
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
                                            builder: (context) => LoginPage()));
                                  }),
                          ]),
                        ),
                      ],
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
