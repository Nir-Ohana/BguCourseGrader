import 'package:bgu_course_grader/models/appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  final nameController = TextEditingController();
  final facultyController = TextEditingController();
  final departmentController = TextEditingController();
  final neighbourhoodController = TextEditingController();
  final yearController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore_instance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore_instance
            .collection('Users')
            .snapshots(),
        builder: (context, snapshot) {
          List<String> fields = [];
          if (snapshot.hasData) {
            final reviews = snapshot.data.docs;
            for (var review in reviews) {
              if (review.id == user.displayName) {
                final reviewData = (review.data() as Map<String, dynamic>);
                final department = reviewData['department'];
                final faculty = reviewData['faculty'];
                final neighbourhood = reviewData['neighbourhood'];
                final year = reviewData['year'];
                fields.add(department);
                fields.add(faculty);
                fields.add(neighbourhood);
                fields.add(year);
              }
            }
          }
          return Scaffold(
      appBar:MyAppBar(),
      body: Directionality(textDirection: TextDirection.rtl, child:Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "פרופיל",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                user.photoURL,
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Color(0xFFFDA901),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("פקולטה", "מדעי הדשא",facultyController, false),
              buildTextField("מחלקה", "פלוגת איזי",departmentController, false),
              buildTextField("שכונה", "ד' הישנה",neighbourhoodController, false),
              buildTextField("שנה", "בוגר תיכון אקסטרני",yearController, false),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white),

                    onPressed: () {Navigator.of(context).pop();},
                    child: Text("ביטול",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(facultyController.text);
                      firestore_instance
                          .collection("Users").doc(user.displayName)
                          .set({
                        'faculty': facultyController.text!=""? facultyController.text: fields[1],
                        'department' : departmentController.text!=""? departmentController.text : fields[0] ,
                        'neighbourhood' : neighbourhoodController.text!= ""? neighbourhoodController.text: fields[2],
                        'year' : yearController.text!= ""? yearController.text: fields[3],
                        'photoURL' : user.photoURL});
                      Navigator.of(context).popUntil((route) => route.isFirst);},
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFDA901),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))
                    )
                   ,
                    child: Text(
                      "שמירה",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white,),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    )
    );
  }
  );}
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    facultyController.dispose();
    departmentController.dispose();
    neighbourhoodController.dispose();
    super.dispose();
  }

  Widget buildTextField(
      String labelText, String placeholder,TextEditingController controller, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            )),
      ),
    );}}