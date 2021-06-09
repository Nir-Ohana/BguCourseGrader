import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/screens/menu/menu_screen.dart';

class Profile extends StatelessWidget {
  final String userName;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Profile(this.userName);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
        .collection('Users')
        .snapshots(),
    builder: (context, snapshot) {
      List<String> fields = [];
      if (snapshot.hasData) {
        final fieldss = snapshot.data.docs;
        for (var field in fieldss) {
          if (field.id == userName) {
            final fieldData = (field.data() as Map<String, dynamic>);
            final department = fieldData['department'];
            final faculty = fieldData['faculty'];
            final neighbourhood = fieldData['neighbourhood'];
            final year = fieldData['year'];
            final photoURL = fieldData['photoURL'];
            fields.add(department);
            fields.add(faculty);
            fields.add(neighbourhood);
            fields.add(year);
            fields.add(photoURL);
            break;
          }
        }
      }
      else {
        fields.add("");
        fields.add("");
        fields.add("");
        fields.add("");
        fields.add("");
      }

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.orange[100],
//       appBar: MyAppBar(),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
//         child: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Image.network(loggedInUser.photoURL),
//                 ),
//                 Divider(
//                   height: 60.0,
//                   color: Colors.grey[800],
//                 ),
//                 Text(
//                   'שם:',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     letterSpacing: 2.0,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Text(
//                   loggedInUser.displayName,
//                   style: TextStyle(
//                     color: Colors.purpleAccent[800],
//                     letterSpacing: 2.0,
//                     fontSize: 20,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 Text(
//                   'פקולטה',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     letterSpacing: 2.0,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Text(
//                   fields[1]!=null? fields[1].toString() : 'מדעי הדשא' ,
//                   style: TextStyle(
//                     color: Colors.purpleAccent[800],
//                     letterSpacing: 2.0,
//                     fontSize: 20,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 Text(
//                   'מחלקה',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     letterSpacing: 2.0,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Text(
//                   fields[0]!=null? fields[0].toString() : 'פלוגת איזי',
//                   style: TextStyle(
//                     color: Colors.purpleAccent[800],
//                     letterSpacing: 2.0,
//                     fontSize: 20,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 100),
//                   child: Center(
//                     child: SizedBox(
//                       width: 200,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               Colors.orange[800]),
//                         ),
//                         onPressed: () {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => Menu()));
//                         },
//                         child: Text(
//                           'לתפריט',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )),
//       ),
//     );
//   });
// }}
      return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orangeAccent,
                          Colors.deepOrangeAccent
                        ],
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://imgur.com/0FrdmOo.jpg"),
                      fit: BoxFit.fill
                      )
                    ),
                    child: Column(
                        children: [
                          SizedBox(height: 110.0,),
                          CircleAvatar(
                            radius: 65.0,
                            child: ClipOval(child:Image.network(
                                fields[4]!=null?fields[4]: "https://www.cdn3.iconfinder.com/data/icons/users-outline/60/50_-Blank_Profile-_user_people_group_team-512.png")),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(height: 10.0,),
                          Text(userName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                          SizedBox(height: 10.0,),
                          Text('ברוכים הבאים למדרג הקורסים',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),)
                        ]
                    ),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.orange[100],
                    child: Center(
                        child: Card(
                            margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                            child: Directionality(textDirection: TextDirection.rtl,child:Container(
                                width: 310.0,
                                height: 290.0,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("מידע אישי",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w800,
                                        ),),
                                      Divider(color: Colors.blueGrey[200],),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Icon(
                                            Icons.school_outlined,
                                            color: Colors.blueAccent[400],
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text("מחלקה",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),),
                                              Text(fields[0]!=null? fields[0].toString() : 'פלוגת איזי',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),)
                                            ],
                                          )

                                        ],
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Icon(
                                            Icons.science_outlined,
                                            color: Colors.amberAccent[400],
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text("פקולטה",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),),
                                              Text(
                                                fields[1]!=null? fields[1].toString() : 'מדעי הדשא',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),)
                                            ],
                                          )

                                        ],
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Icon(
                                            Icons.home_outlined,
                                            color: Color(0xFFF56A00),
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text("שכונה",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),),
                                              Text(fields[2]!=null? fields[2].toString() : 'הומלס לבינתיים',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),)
                                            ],
                                          )

                                        ],
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Icon(
                                            Icons.calendar_today_outlined,
                                            color: Colors.red[300],
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text("שנה",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),),
                                              Text(fields[3]!=null? fields[3].toString() : 'WHAT YEAR IS THIS?!',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),)
                                            ],
                                          )

                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            )
                        )
                    ),
                  ),
                ),

                )],
            ),
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.45,
              left: 30.0,
              right: 30.0,
              child: InkWell(
                  child:
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    child: Padding(
                        padding: EdgeInsets.all(23.0),
                        child: Text(
                            'חזור',
                            style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 20.0),
                            textAlign: TextAlign.center
                        )
                    ),
                  ),

                  onTap: () {Navigator.canPop(context)? Navigator.of(context).pop(): Navigator.push(context,
    MaterialPageRoute(builder: (context) => Menu()));
                  }
              ),
            )
            ],

        ),
      );
    });
    }
    }
