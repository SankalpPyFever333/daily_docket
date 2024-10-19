import 'package:daily_docket/pages/show_all_note.dart';
import 'package:flutter/material.dart';
import "package:daily_docket/services/database.dart";

class CreateNoteByUser extends StatefulWidget {
  const CreateNoteByUser({super.key});

  @override
  State<CreateNoteByUser> createState() => _CreateNoteByUserState();
}

class _CreateNoteByUserState extends State<CreateNoteByUser> {
  String? title, description;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  _submitNote() async {
    DateTime current_Time_Date =
        DateTime.now(); //pass this to date and time field in the document.
    TimeOfDay currentTime = TimeOfDay.now(); //give the current time.
    String formattedDate =
        "${current_Time_Date.year}-${current_Time_Date.month.toString().padLeft(2, '0')}-${current_Time_Date.day.toString().padLeft(2, '0')}";

    title = titleController.text;
    description = descController.text;

    Map<String, dynamic> userNoteInfoMap = {
      'title': title,
      'description': description,
      'Date': formattedDate,
      'timeOfTheDay': currentTime.format(context).toString(),
    };

    await DatabaseMethods().addUserNotes(userNoteInfoMap);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      "Note Added",
      style: TextStyle(fontSize: 20, fontFamily: "Signi"),
    )));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShowAllNote()));
  }

// while creating note, pass time and date with the Map object.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF005082),
                Color(0xFF0083B0),
                Color(0xFF00B4DB)
              ])),
              child: Text(
                "Add Note",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ))),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Title",
                style: TextStyle(
                    color: Color.fromARGB(255, 33, 255, 244),
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Signi"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter title';
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "title",
                  labelText: "Enter title",
                  prefixIcon: Icon(Icons.abc_outlined),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Description",
                style: TextStyle(
                    color: Color.fromARGB(255, 33, 255, 244),
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Signi"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter description';
                  }
                  return null;
                },
                controller: descController,
                decoration: InputDecoration(
                  hintText: "description",
                  labelText: "Enter description",
                  prefixIcon: Icon(Icons.abc_outlined),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    _submitNote();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Signi",
                        color: Color.fromARGB(255, 33, 255, 244)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
