import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void onPressed() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Looged in")));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF001F3F),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: const Text(
              "Hello\n Welcome to DailyDocket",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(top: 250),
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 12, top: 12, right: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("email"),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter email",
                                labelText: "Email"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 12, top: 12, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("password"),
                          const SizedBox(
                            height: 5,
                          ),
                          const TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter password",
                                labelText: "password"),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                onPressed();
                              },
                              child: const Text("Login in"))
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
