import 'package:bgu_course_grader/models/appBar.dart';
import 'package:flutter/material.dart';
import 'menu_choice_list.dart';
import 'package:bgu_course_grader/screens/prefered_courses.dart';
import 'package:bgu_course_grader/screens/my_reviews.dart';
import 'package:bgu_course_grader/screens/courses_list.dart';
import 'package:bgu_course_grader/screens/contact_us.dart';
import 'package:bgu_course_grader/screens/advanced_search.dart';


class Menu extends StatelessWidget {


  void _navigator(int index, BuildContext context){
    switch(index) {
      case 0: {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PrefferedCourses()));
      }
      break;

      case 1: {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdvancedSearch()));
      }
      break;
      case 2:{
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>MyReviews()));
      }
      break;
      case 3:{
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CourseList()));
      }
      break;
      case 4:{
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContactUs()));
      }
      break;
      default: {
        //statements;
      }
      break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index){
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Card(
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
