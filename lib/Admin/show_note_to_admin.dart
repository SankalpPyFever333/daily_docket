import "package:cloud_firestore/cloud_firestore.dart";
import "package:daily_docket/authentication/login_page.dart";
import "package:daily_docket/pages/update_note_page.dart";
import "package:daily_docket/services/database.dart";
import "package:flutter/material.dart";

class ShowNotesToAdmin extends StatefulWidget {
  const ShowNotesToAdmin({super.key});

  @override
  State<ShowNotesToAdmin> createState() => _ShowNotesToAdminState();
}

class _ShowNotesToAdminState extends State<ShowNotesToAdmin> {
  Stream? notesStream;

  getontheload() async {
    notesStream = await DatabaseMethods().getAllNotesForAdmin();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allNotesOfAllUsers() {
    return StreamBuilder(
        stream: notesStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    String uid = ds['uid'];
                    String noteID = ds.id;

                    return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .get(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                          if (!userSnapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          DocumentSnapshot userDoc = userSnapshot.data!;
                          String userName = userDoc['name'];
                          String email = userDoc['email'];

                          return Material(
                            elevation: 12,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // here I have to display name and email fetched from users collection.

                                      SizedBox(
                                        height: 10,
                                      ),

                                      Text(
                                        "Name: " + userName,
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
                                        "Email: " + email,
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
                                            color: Color(0xFFFFD600),
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
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await DatabaseMethods()
                                                  .deleteNote(noteID);

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                "note deleted",
                                                style: TextStyle(
                                                    fontFamily: "Signi",
                                                    fontSize: 20),
                                              )));
                                            },
                                            child: Container(
                                                // width: MediaQuery.of(context).size.width,
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 86, 87, 87),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child:
                                                    Icon(Icons.delete_rounded)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateNotePage(
                                                            noteId: noteID,
                                                          )));
                                            },
                                            child: Container(
                                                // width: MediaQuery.of(context).size.width,
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 86, 87, 87),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Icon(Icons.edit)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFF2C2C2C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(bottom: 10, left: 5),
                  child: Text(
                    "Admin Panel",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 15, 255, 247),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Signi"),
                  ),
                )
              ],
            ),
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
              child: allNotesOfAllUsers(),
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
    );
  }
}
