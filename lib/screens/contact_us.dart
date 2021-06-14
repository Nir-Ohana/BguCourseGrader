import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




class ContactUs extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        body: MyCustomForm(),
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
    final FirebaseFirestore firestore_instance = FirebaseFirestore.instance;
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 150,),
          // TextFormField(
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          //   controller: nameController,
          //   decoration: const InputDecoration(
          //     icon: const Icon(Icons.person),
          //     hintText: 'Enter your name',
          //     labelText: 'Name',
          //   ),
          // ),
          Container(child:TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: messageController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.question_answer, color: Colors.orangeAccent,),
              hintText: 'How may we help you?',
              labelText: 'Message',
            ),
            maxLines: null,
          ),
          margin: EdgeInsets.all(25.0),
          ),
          new Container(
            padding: const EdgeInsets.only(left: 150.0, top: 40.0),
            child: new ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orangeAccent[400]),
                onPressed: () {
                  // firestore_instance
                  //     .collection('courses')
                  //     .get()
                  //     .then((value) => {
                  //           value.docs.forEach((element) {
                  //             log(element.data().toString());
                  //           })
                  //         });
                  FocusScope.of(context).unfocus();
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content:  Text('מעבד את הנתונים...', textDirection:TextDirection.rtl,)));
                    firestore_instance
                        .collection("ContactUs").doc(user.displayName + ' ' + DateTime.now().toString())
                        .set({
                          'email': user.email,
                          'name': user.displayName,
                          'message': messageController.text
                        })
                        .then((_) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('סחתיין עליך !', textDirection: TextDirection.rtl,))))
                        .catchError((_) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content:
                                    Text('Ya Walli, we have a problem.'))));

                    Navigator.pop(context);
                    // Navigator.of(context).pop();
                  }
                  // int count = 0;
                  // Navigator.popUntil(context, (route) {
                  //   return count++ == 2;
                  // });
                },
                child: const Text('Submit')),
          ),
        ],
      ),
    );
  }
}
