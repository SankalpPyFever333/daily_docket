import "package:cloud_firestore/cloud_firestore.dart";
import "package:daily_docket/services/database.dart";
import "package:flutter/material.dart";

class UpdateNotePage extends StatefulWidget {
  final String noteId;
  const UpdateNotePage({required this.noteId});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  // fetch existing note and show to user and he can update it
  DocumentSnapshot? docsnp;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  getontheload() async {
    docsnp = await DatabaseMethods().fetchNoteToUpdate(widget.noteId);

    setState(() {
      titleController.text = docsnp!['title'];
      descController.text = docsnp!['description'];
    });
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  _updateNote() async {
    DateTime current_Time_Date = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();
    String formattedDate =
        "${current_Time_Date.year}-${current_Time_Date.month.toString().padLeft(2, '0')}-${current_Time_Date.day.toString().padLeft(2, '0')}";
    // update note in database
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 120, left: 20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF005082),
              Color(0xFF0083B0),
              Color(0xFF00B4DB)
            ])),
            child: Text(
              "Update Your Note",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Signi"),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            padding: EdgeInsets.only(top: 40, left: 30, right: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "title",
                    style: TextStyle(
                        fontFamily: "Signi",
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 18, 255, 247)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "title",
                        labelText: "enter title",
                        prefixIcon: Icon(Icons.title_rounded)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "description",
                    style: TextStyle(
                        fontFamily: "Signi",
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 18, 255, 247)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    controller: descController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "description",
                        labelText: "enter description",
                        prefixIcon: Icon(Icons.description)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _updateNote();
                        }
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
        ],
      ),
    ));
  }
}
