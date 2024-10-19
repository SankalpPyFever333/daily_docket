import 'package:flutter/material.dart';

class CreateNoteByUser extends StatefulWidget {
  const CreateNoteByUser({super.key});

  @override
  State<CreateNoteByUser> createState() => _CreateNoteByUserState();
}

class _CreateNoteByUserState extends State<CreateNoteByUser> {
  createNote() async {
    DateTime current_Time_Date =
        DateTime.now(); //pass this to date and time field in the document.
    TimeOfDay currentTime = TimeOfDay.now(); //give the current time.
  }

// while creating note, pass time and date with the Map object.

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
