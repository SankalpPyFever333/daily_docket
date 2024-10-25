import "package:cloud_firestore/cloud_firestore.dart";
import "package:daily_docket/authentication/login_page.dart";
import "package:daily_docket/pages/create_note.dart";
import "package:daily_docket/pages/update_note_page.dart";
import "package:daily_docket/services/database.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class ShowAllNote extends StatefulWidget {
  const ShowAllNote({super.key});

  @override
  State<ShowAllNote> createState() => _ShowAllNoteState();
}

class _ShowAllNoteState extends State<ShowAllNote> {
  Stream? notesStream;

  getontheload() async {
    notesStream = await DatabaseMethods().getAllNotesOfUser();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allNotesOfUser() {
    return StreamBuilder(
        stream: notesStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    String noteId = ds.id;
                    return Material(
                      elevation: 12,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              Color(0xFF005082),
                              Color(0xFF0083B0),
                              Color(0xFF00B4DB)
                            ])),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Title: " + ds["title"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Signi"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Description: " + ds["description"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Signi"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Date: " + ds["Date"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Signi"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Time: " + ds["timeOfTheDay"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Signi"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await DatabaseMethods()
                                            .deleteNote(noteId);
                                      },
                                      child: Container(
                                          // width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 86, 87, 87),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Icon(Icons.delete_rounded)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateNotePage(
                                                      noteId: noteId,
                                                    )));
                                      },
                                      child: Container(
                                          // width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 86, 87, 87),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Icon(Icons.edit)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                "All Notes",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Signi"),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: allNotesOfUser(),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 36, 255, 219),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateNoteByUser()));
        },
        tooltip: "add note",
        child: Icon(Icons.add),
      ),
    );
  }
}
