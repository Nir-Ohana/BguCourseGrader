import 'dart:async';

import 'package:bgu_course_grader/authentication/auth_bloc.dart';
import 'package:bgu_course_grader/authentication/login.dart';
import 'package:bgu_course_grader/models/appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/screens/menu/menu_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<User> loginStateSubscription;


  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    authBloc.currentUser.listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Authentication()));
      }
    });
    super.initState();
  }

  @override
  void dispose(){
      loginStateSubscription.cancel();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[100],
      appBar: MyAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<User>(
            stream: authBloc.currentUser,
            builder: (context, snapshot) {
              if(!snapshot.hasData) return CircularProgressIndicator();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(snapshot.data.photoURL),
                  ),
                  Divider(
                    height: 60.0,
                    color: Colors.grey[800],
                  ),
                  Text(
                    'שם:',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    snapshot.data.displayName,
                    style: TextStyle(
                      color: Colors.purpleAccent[800],
                      letterSpacing: 2.0,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'פקולטה',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'מדעי הדשא',
                    style: TextStyle(
                      color: Colors.purpleAccent[800],
                      letterSpacing: 2.0,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'מחלקה',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'פלוגת איזי',
                    style: TextStyle(
                      color: Colors.purpleAccent[800],
                      letterSpacing: 2.0,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:  MaterialStateProperty.all<Color>(Colors.orange[800]),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Menu()));
                          },
                          child: Text('לתפריט',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}



