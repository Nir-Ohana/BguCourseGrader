import 'package:bgu_course_grader/models/appBar.dart';
import 'package:bgu_course_grader/models/inputDec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.orange[300],
        appBar: MyAppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    Text('דירוג קורס: (בעתיד יהיו כוכבים לפי הדירוגת 1-5)'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:  MaterialStateProperty.all<Color>(Colors.orange[800]),
                        ),
                        onPressed: () async {
                          print(department);
                          print(courseName);
                          print(courseNum);
                          print(finalExam);

                        },
                        child: Text('חפש',
                          style: TextStyle(
                              color: Colors.black
                          ),
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
