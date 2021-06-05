import 'dart:developer';

import 'package:bgu_course_grader/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyReviews extends StatefulWidget {
  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  List<Container> sup2 = [];

  void reviewsStream() async {
    await for (var snapshot in _firestore
        .collection('Reviews')
        .where('email', isEqualTo: loggedInUser.email)
        .snapshots()) {
      for (var review in snapshot.docs) {
        print(review.data());
      }
    }
  }
  // void getReviews() async{
  //   print(loggedInUser.email);
  //   final userReviews = await _firestore.collection('Reviews').where('email', isEqualTo: loggedInUser.email).get();
  //   for(var review in userReviews.docs){
  //     print(review.data());
  //   }
  // }
  // Future<List<Widget>> getReviewsByUserEmail() async
  // {
  //   var poop = await FirebaseFirestore.instance.collection('Reviews').where('email', isEqualTo: user.email);
  //
  //   poop.get()
  //       .then((value) => {
  //     value.docs.forEach((element) {
  //       sup.add(Container(
  //         height: 50,
  //         color: Colors.amber[600],
  //         child: Center(child: Text(element['review_content'])),
  //       )
  //           );
  //     })
  //   });
  //   print(sup);
  //   sup2 = sup; // TODO: change it asap
  //   sup=[];
  //   return sup2;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('Reviews')
                .where('email', isEqualTo: loggedInUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              List<Container> reviewWidgets = [];
              if (snapshot.hasData) {
                final reviews = snapshot.data.docs;
                for (var review in reviews) {
                  final reviewData = (review.data() as Map<String, dynamic>);
                  final reviewContent = reviewData['review_content'];
                  final reviewCourseNumber = reviewData['course_number'];
                  final reviewWidget = Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: Center(
                        child: Text(
                      '$reviewCourseNumber : $reviewContent',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal
                      ),
                    )),
                  );
                  reviewWidgets.add(reviewWidget);
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ListView(
                  children: reviewWidgets,
                ),
              );
            }),
      ],
    );
  }
  //   return Column(
  //     children: [
  //       StreamBuilder<QuerySnapshot>(
  //
  //         stream: _firestore.collection('Reviews').where('email', isEqualTo: loggedInUser.email).snapshots(),
  //         builder: (context, snapshot){
  //       if (snapshot.hasData){
  //         final reviews = snapshot.data.docs;
  //         for (var review in reviews){
  //           final reviewContent = review.data['review_content'];
  //           final reviewCourseNumber = review.data['course_number'];
  //
  //           final reviewWidget = Container(
  //           height: 50,
  //           color: Colors.amber[600],
  //           child: Center(child: Text(reviewContent)),
  //         );
  //           reviewWidgets.add(reviewWidget);
  //
  //   }
  //   }
  //   return Column(
  //   children: reviewWidgets,
  //   );
  //       ),
  //     ],
  //   );
  //   // reviewsStream();
  //   // return Container();
  //   //
  //   // return FutureBuilder(
  //   //   future: getReviewsByUserEmail(),
  //   // builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot){
  //   // if(snapshot.hasData)
  //   // return Scaffold(
  //   //   body: ListView(
  //   //   padding: const EdgeInsets.all(8),
  //   //   children:
  //   //   sup2
  //   //   ),
  //   //   backgroundColor: Colors.orange[800],
  //   //   );
  //   // return Loading();});
  //
  //
  //
  //
  //
  // }
}
