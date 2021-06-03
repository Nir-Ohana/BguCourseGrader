import 'package:bgu_course_grader/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyReviews extends StatefulWidget {
  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {

  List<Container> sup = [];
  List<Container> sup2 = [];

  Future<List<Widget>> getReviewsByUserEmail() async
  {
    final user = FirebaseAuth.instance.currentUser;
    var poop = await FirebaseFirestore.instance.collection('Reviews').where('email', isEqualTo: user.email);

    poop.get()
        .then((value) => {
      value.docs.forEach((element) {
        sup.add(Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text(element['review_content'])),
        )
            );
      })
    });
    print(sup);
    sup2 = sup; // TODO: change it asap
    sup=[];
    return sup2;
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: getReviewsByUserEmail(),
    builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot){
    if(snapshot.hasData)
    return Scaffold(
      body: ListView(
      padding: const EdgeInsets.all(8),
      children:
      sup2
      ),
      backgroundColor: Colors.orange[800],
      );
    return Loading();});





  }
}
