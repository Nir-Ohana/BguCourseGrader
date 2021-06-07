import 'package:bgu_course_grader/models/appBar.dart';
import 'package:flutter/material.dart';
import 'menu_choice_list.dart';

import 'package:bgu_course_grader/screens/my_reviews.dart';
import 'package:bgu_course_grader/screens/courses_list.dart';
import 'package:bgu_course_grader/screens/contact_us.dart';
import 'package:bgu_course_grader/screens/advanced_search.dart';


class Menu extends StatelessWidget {


  void _navigator(int index, BuildContext context){

    List<Function> targets= [
          () => Navigator.push(context, MaterialPageRoute(builder: (context) =>CourseList(favorites: true ,filtered: false, finalExam: false,))),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdvancedSearch())),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) =>MyReviews())),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) => CourseList(favorites: false ,filtered: false, finalExam: false,))),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) => CourseList(favorites: false,filtered: false, finalExam: false,))),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()))
    ];
    targets[index].call();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orange[100],
        appBar: MyAppBar(),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Card(
                  color: Colors.orange[200],
                  child: ListTile(
                    onTap: (){_navigator(index, context);},                              // routing to required menu option
                    title: Text(
                        choices[index]
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}

