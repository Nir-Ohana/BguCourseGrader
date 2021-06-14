import 'package:bgu_course_grader/screens/settings/settings_main.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/screens/my_reviews.dart';
import 'package:bgu_course_grader/screens/courses_list.dart';
import 'package:bgu_course_grader/screens/contact_us.dart';
import 'package:bgu_course_grader/screens/advanced_search.dart';

class Menu extends StatelessWidget {
  void _navigator(int index, BuildContext context) {
    List<Function> targets = [
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourseList(
                    favorites: true,
                    filtered: false,
                    finalExam: false,
                  ))),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdvancedSearch())),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyReviews())),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourseList(
                    favorites: false,
                    filtered: false,
                    finalExam: false,
                  ))),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContactUs())),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsMenu()))
    ];
    targets[index].call();
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.orange[100],
//         appBar: MyAppBar(),
//         body: Directionality(
//           textDirection: TextDirection.rtl,
//           child: ListView.builder(
//             itemCount: 5,
//             itemBuilder: (context, index){
//               return Padding(
//                 padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
//                 child: Card(
//                   color: Colors.orange[200],
//                   child: ListTile(
//                     onTap: (){_navigator(index, context);},                              // routing to required menu option
//                     title: Text(
//                         choices[index]
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         )
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orangeAccent[100],
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(top: 40),
            child: GridView.count(crossAxisCount: 2, children: <Widget>[
              buildCardWithIcon(
                Icons.search_outlined,
                context,
                () {
                  _navigator(1, context);
                },
                "חיפוש מתקדם",
              ),
              buildCardWithIcon(
                Icons.rate_review_sharp,
                context,
                () {
                  _navigator(2, context);
                },
                "הביקורות שלי",
              ),
              buildCardWithIcon(
                Icons.list_alt,
                context,
                () {
                  _navigator(3, context);
                },
                "רשימת קורסים",
              ),
              buildCardWithIcon(
                Icons.favorite_outlined,
                context,
                () {
                  _navigator(0, context);
                },
                "מועדפים",
              ),
              buildCardWithIcon(
                Icons.hearing_outlined,
                context,
                () {
                  _navigator(4, context);
                },
                "צרו קשר",
              ),
              buildCardWithIcon(
                Icons.settings,
                context,
                () {
                  _navigator(5, context);
                },
                "הגדרות",
              ),
            ]),
          ),
        ));
  }

  //     ListView.builder(
  //       itemCount: 5,
  //       itemBuilder: (context, index){
  //           return Padding(
  //               padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
  //             child: Card(
  //               color: Colors.orange[200],
  //               child: ListTile(
  //                 onTap: (){_navigator(index, context);},                              // routing to required menu option
  //                 title: Text(
  //                   choices[index]
  //                 ),
  //               ),
  //             ),
  //           );
  //       },
  //     ),
  //   )
//     // );
//   }
// }

  Padding buildCardWithIcon(
      IconData icon, context, VoidCallback onTap, String pageName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 70,
                  color: Color(0xFFEE7C21),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  pageName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFCB6B03),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
