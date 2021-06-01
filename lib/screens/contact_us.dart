import 'dart:developer';

import 'package:bgu_course_grader/screens/menu/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/models/appBar.dart';

class ContactUs extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Contact Us';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: MyAppBar(),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final user = FirebaseAuth.instance.currentUser;
  final nameController = TextEditingController();
  final messageController = TextEditingController();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String name;
    String message;
    final FirebaseFirestore firestore_instance = FirebaseFirestore.instance;
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: nameController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: messageController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.question_answer),
              hintText: 'How may we help you?',
              labelText: 'Message',
            ),
            maxLines: null,
          ),
          new Container(
            padding: const EdgeInsets.only(left: 150.0, top: 40.0),
            child: new ElevatedButton(
                onPressed: () {
                  firestore_instance
                      .collection('courses')
                      .get()
                      .then((value) => {
                            value.docs.forEach((element) {
                              log(element.data().toString());
                            })
                          });
                  FocusScope.of(context).unfocus();
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    firestore_instance
                        .collection("ContactUs")
                        .add({
                          'email': user.email,
                          'name': nameController.text,
                          'message': messageController.text
                        })
                        .then((_) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Thank you for your feedback !'))))
                        .catchError((_) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content:
                                    Text('Ya Walli, we have a problem.'))));

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Menu()));
                  }
                },
                child: const Text('Submit')),
          ),
        ],
      ),
    );
  }
}
