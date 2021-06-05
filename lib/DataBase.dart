import 'models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// class DataBaseService {
//
//   final String uid;
//
//   DataBaseService({this.uid});
//
//   //collection reference
//   final CollectionReference courseList = FirebaseFirestore.instance.collection('courses');
//
//
//
//   // List<Course> _courseDataFromSnapshot(QuerySnapshot snapshot){
//   //   return snapshot.docs.map((e) =>
//   //   Course(
//   //     name: ['name'] ?? 'shmigli',
//   //     courseNumber: ['course_number'] ?? '0',
//   //     openIn: ['open_in'] ?? 'i dont know'
//   //   ));
//   // }
//
//
//
//   //get course doc stream
//   Stream<List<Course>> get courses{
//     return courseList.snapshots().map(_courseDataFromSnapshot);
//   }
//
//
// }