import "package:flutter/material.dart";

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {


  // fetch existing note and show to user and he can update it.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Text("update page")]),
    );
  }
}
