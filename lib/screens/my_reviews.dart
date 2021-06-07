
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyReviews extends StatefulWidget {
  @override
  _MyReviewsState createState() => new _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  SwiperController _swiperController;
  double prevOpacity = 1.0;
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

  void initState() {
    super.initState();
    _swiperController = SwiperController();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    List<String> pics = ["https://www.sushiwithgusto.com/wp-content/uploads/2016/11/uramaki_sushi-300rev.png","https://pngimg.com/uploads/donut/donut_PNG47.png",
      "https://toppng.com/public/uploads/preview/ice-cream-115283212700qrzu6fyi3.png"];
    List<LinearGradient> gradients = [firstGradient, secondtGradient, thirdGradient];
    List<Color> colors = [Color(0xFFfba457), Color(0xFFffcc00),Color(0xFFd18cd6) ];
    // List<Widget> swiperItemsList = [
    //   buildSwiperItem(
    //       "http://www.sushiwithgusto.com/wp-content/uploads/2016/11/uramaki_sushi-300rev.png",
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam nec interdum eros, id luctus nisi",
    //       Color(0xFFfba457),
    //       firstGradient,
    //       "SOON?"),
    //   buildSwiperItem(
    //       "http://pngimg.com/uploads/donut/donut_PNG47.png",
    //       "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas",
    //       Color(0xFFffcc00),
    //       secondtGradient,
    //       "PROMOTIONS!"),
    //   buildSwiperItem(
    //       "https://toppng.com/public/uploads/preview/ice-cream-115283212700qrzu6fyi3.png",
    //       "Praesent quis euismod ante. Nunc sollicitudin justo id fermentum feugiat. ",
    //       Color(0xFFd18cd6),
    //       thirdGradient,
    //       "POSITION"),
    // ];
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Reviews')
            .where('email', isEqualTo: user.email)
            .snapshots(),
        builder: (context, snapshot) {
          List<Widget> swiperItemsList = [];
          int index = 0;
          if (snapshot.hasData) {
            final reviews = snapshot.data.docs;
            for (var review in reviews) {
              final reviewData = (review.data() as Map<String, dynamic>);
              final reviewContent = reviewData['review_content'];
              final reviewCourseNumber = reviewData['course_number'];
              swiperItemsList.add(buildSwiperItem(
                  pics[index],
                  reviewContent.toString(),
                  colors[index],
                  gradients[index],
                  reviewCourseNumber.toString()));
              index++;
              index = index%2;
            }
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Expanded(
                    flex: 6,
                    child: Swiper(
                      controller: _swiperController,
                      itemCount: swiperItemsList.length,
                      onIndexChanged: (int value) {
                        if (value == 2) {
                          setState(() {
                            prevOpacity = 0.0;
                          });
                        } else {
                          setState(() {
                            prevOpacity = 1.0;
                          });
                        }
                      },
                      itemWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      itemHeight: MediaQuery
                          .of(context)
                          .size
                          .height / 1.5,
                      itemBuilder: (BuildContext context, index) {
                        return swiperItemsList[index];
                      },
                      layout: SwiperLayout.TINDER,
                      curve: Curves.bounceOut,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  buildBottomBar(),
                ],
              ),
            ),
          );
        });
  }

  Widget buildBottomBar() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                print("prev");
                _swiperController.previous(animation: true);
                print(_swiperController.index.toString());
                setState(() {
                  prevOpacity = 0.0;
                });
              },
              child: Opacity(
                opacity: prevOpacity,
                child: Text(
                  "PREV",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("next");
                _swiperController.next(animation: true);
                print(_swiperController.index);
              },
              child: Text(
                "NEXT",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwiperItem(String image, String text, Color color,
      Gradient gradient, String endText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400.withOpacity(0.8),
            blurRadius: 4,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: gradient,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 8),
                        )
                      ]),
                ),
                Image.network(
                  image,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.3,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              endText,
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black12,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


const firstGradient = LinearGradient(
  colors: [
    Color(0xFFfc792c),
    Color(0xFFfba457),
  ],
);

const secondtGradient = LinearGradient(
  colors: [
    Color(0xFFfeb700),
    Color(0xFFffcc00),
  ],
);

const thirdGradient = LinearGradient(
  colors: [
    Color(0xFFa978ad),
    Color(0xFFd18cd6),
  ],
);

// import 'dart:developer';
//
// import 'package:bgu_course_grader/screens/loading.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MyReviews extends StatefulWidget {
//   @override
//   _MyReviewsState createState() => _MyReviewsState();
// }
//
// class _MyReviewsState extends State<MyReviews> {
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   User loggedInUser;
//
//   void getCurrentUser() async {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) loggedInUser = user;
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     getCurrentUser();
//   }
//
//
//
//   // void reviewsStream() async {
//   //   await for (var snapshot in _firestore
//   //       .collection('Reviews')
//   //       .where('email', isEqualTo: loggedInUser.email)
//   //       .snapshots()) {
//   //     for (var review in snapshot.docs) {
//   //       print(review.data());
//   //     }
//   //   }
//   // }
//   // void getReviews() async{
//   //   print(loggedInUser.email);
//   //   final userReviews = await _firestore.collection('Reviews').where('email', isEqualTo: loggedInUser.email).get();
//   //   for(var review in userReviews.docs){
//   //     print(review.data());
//   //   }
//   // }
//   // Future<List<Widget>> getReviewsByUserEmail() async
//   // {
//   //   var poop = await FirebaseFirestore.instance.collection('Reviews').where('email', isEqualTo: user.email);
//   //
//   //   poop.get()
//   //       .then((value) => {
//   //     value.docs.forEach((element) {
//   //       sup.add(Container(
//   //         height: 50,
//   //         color: Colors.amber[600],
//   //         child: Center(child: Text(element['review_content'])),
//   //       )
//   //           );
//   //     })
//   //   });
//   //   print(sup);
//   //   sup2 = sup; // TODO: change it asap
//   //   sup=[];
//   //   return sup2;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         StreamBuilder<QuerySnapshot>(
//             stream: _firestore
//                 .collection('Reviews')
//                 .where('email', isEqualTo: loggedInUser.email)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               List<Container> reviewWidgets = [];
//               if (snapshot.hasData) {
//                 final reviews = snapshot.data.docs;
//                 for (var review in reviews) {
//                   final reviewData = (review.data() as Map<String, dynamic>);
//                   final reviewContent = reviewData['review_content'];
//                   final reviewCourseNumber = reviewData['course_number'];
//                   final reviewWidget = Container(
//                     height: 50,
//                     color: Colors.amber[600],
//                     child: Center(
//                         child: Text(
//                       '$reviewCourseNumber : $reviewContent',
//                       textAlign: TextAlign.center,
//                       textDirection: TextDirection.rtl,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         fontStyle: FontStyle.normal
//                       ),
//                     )),
//                   );
//                   reviewWidgets.add(reviewWidget);
//                 }
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               return Expanded(
//                 child: ListView(
//                   children: reviewWidgets,
//                 ),
//               );
//             }),
//       ],
//     );
//   }
//   //   return Column(
//   //     children: [
//   //       StreamBuilder<QuerySnapshot>(
//   //
//   //         stream: _firestore.collection('Reviews').where('email', isEqualTo: loggedInUser.email).snapshots(),
//   //         builder: (context, snapshot){
//   //       if (snapshot.hasData){
//   //         final reviews = snapshot.data.docs;
//   //         for (var review in reviews){
//   //           final reviewContent = review.data['review_content'];
//   //           final reviewCourseNumber = review.data['course_number'];
//   //
//   //           final reviewWidget = Container(
//   //           height: 50,
//   //           color: Colors.amber[600],
//   //           child: Center(child: Text(reviewContent)),
//   //         );
//   //           reviewWidgets.add(reviewWidget);
//   //
//   //   }
//   //   }
//   //   return Column(
//   //   children: reviewWidgets,
//   //   );
//   //       ),
//   //     ],
//   //   );
//   //   // reviewsStream();
//   //   // return Container();
//   //   //
//   //   // return FutureBuilder(
//   //   //   future: getReviewsByUserEmail(),
//   //   // builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot){
//   //   // if(snapshot.hasData)
//   //   // return Scaffold(
//   //   //   body: ListView(
//   //   //   padding: const EdgeInsets.all(8),
//   //   //   children:
//   //   //   sup2
//   //   //   ),
//   //   //   backgroundColor: Colors.orange[800],
//   //   //   );
//   //   // return Loading();});
//   //
//   //
//   //
//   //
//   //
//   // }
// }