import 'package:bgu_course_grader/models/inputDec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'courses_list.dart';

class AdvancedSearch extends StatefulWidget {
  @override
  _AdvancedSearchState createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {
  // fields for DB
  String department = '';
  //String lecturer = '';
  String courseName = '';
  String courseNum = '';
  bool midterm = false;
  bool finalExam = false;
  bool assignments = false;
  bool attendance = false;
  //double user_rating = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orangeAccent[100],
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("חיפוש מתקדם",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,



                    ),),
                    SizedBox(height: 50,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText:
                              'מחלקה'), // faculty box, need to add autocomplete or drag down
                      // validator: (val) =>
                      // val.isEmpty ? 'Please enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          department = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText:
                              'שם קורס'), // faculty box, need to add autocomplete or drag down
                      // validator: (val) =>
                      // val.isEmpty ? 'Please enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          courseName = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText:
                              'מספר קורס'), // faculty box, need to add autocomplete or drag down
                      // validator: (val) =>
                      // val.isEmpty ? 'Please enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          courseNum = val;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: finalExam,
                      title: Text('ללא מבחן'),
                      secondary: Icon(Icons.fact_check),
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (bool value) {
                        setState(() {
                          finalExam = value;
                        });
                      },
                    ),
                    // RatingBar.builder(
                    //   initialRating: 0,
                    //   minRating: 1,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: true,
                    //   itemCount: 5,
                    //   itemSize: 30,
                    //   itemPadding: EdgeInsets.symmetric(
                    //       horizontal: 4.0),
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star,
                    //     color: Colors.amber,
                    //   ),
                    //   onRatingUpdate: (rating) {
                    //     user_rating = rating; // new rating of the user
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orangeAccent[400]),
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseList(
                                      filtered: true,
                                      department: department,
                                      courseNum: courseNum,
                                      courseName: courseName,
                                      finalExam: finalExam,
                                      favorites: false,
                                      )));
                        },
                        child: Text(
                          'חפש',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
