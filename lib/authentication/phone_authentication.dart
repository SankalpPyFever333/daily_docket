import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneVerifyOtp extends StatefulWidget {
  const PhoneVerifyOtp({super.key});

  @override
  State<PhoneVerifyOtp> createState() => _PhoneVerifyOtpState();
}

class _PhoneVerifyOtpState extends State<PhoneVerifyOtp> {
  // get the phone number from user, if that phone number is present, then get the otp and logged in.

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String phonenumber = '';
  String verificationId = '';
  bool otpSent = false;

  Future<void> sendOTP() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Invalid phone number")));
          }
        },
        codeSent: (String verifyId, int? resendToken) {
          setState(() {
            verificationId = verifyId;
          });
          otpSent = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("OTP sent successfully")));
        },
        timeout: Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verifyId) {
          setState(() {
            verificationId = verifyId;
          });
        });
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
                  "OTP verification",
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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            return 'please enter phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          hintText: "+1234567890",
                          labelText: "Enter Phone Number",
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Enter OTP",
                        style: TextStyle(
                            color: Color.fromARGB(255, 18, 255, 247),
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Signi"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter otp';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6)
                        ],
                        controller: otpController,
                        decoration: InputDecoration(
                          labelText: "OTP",
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await sendOTP();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10)),
                          child: Text(
                            "Send",
                            style: TextStyle(
                                fontFamily: "Signi",
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
