import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatefulWidget {
  final String documentId;

  const GetUserName({super.key, required this.documentId});

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  final usernamediologController = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('usersss');

  showDiolog(Map data, dynamic mykey) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: Container(
              padding: EdgeInsets.all(22),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      controller: usernamediologController,
                      maxLength: 20,
                      decoration:
                          InputDecoration(hintText: "${data[mykey]}")),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            users.doc(credential!.uid).update(
                                {mykey : usernamediologController.text});
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(fontSize: 17),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersss');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     width: 350, // Adjust the width
                    height: 50,
                     padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 76, 141, 95),
                    borderRadius: BorderRadius.circular(11)), 
                    child:
                  Text(
                    "Username: ${data['Username']} ",
                    style: TextStyle(fontSize: 17),
                  ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDiolog(data, 'Username');
                      },
                      icon: Icon(Icons.edit))
                ],
                  ),
                
              
          
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     width: 350, // Adjust the width
                    height: 50,
                     padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 76, 141, 95),
                    borderRadius: BorderRadius.circular(11)), 
                    child:
                  Text(
                    "Email:  ${data['email']}",
                    style: TextStyle(fontSize: 17),
                  ),
                  ),
                  IconButton(onPressed: () {
                    showDiolog(data, 'email');
                  }, icon: Icon(Icons.edit)),
                  
                ],
              ),
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     width: 350, // Adjust the width
                    height: 50,
                     padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 76, 141, 95),
                    borderRadius: BorderRadius.circular(11)), 
                    child:
                  Text(
                    "Password: ${data['pass']}",
                    style: TextStyle(fontSize: 17),
                  ),
                  ),
                  IconButton(onPressed: () {
showDiolog(data, 'pass');

                  }, icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Container(
                     width: 350, // Adjust the width
                    height: 50,
                     padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 76, 141, 95),
                    borderRadius: BorderRadius.circular(11)), 
                    child:
                  Text(
                    "Age: ${data['age']} years old",
                    style: TextStyle(fontSize: 17),
                  ),
                  ),   
                  IconButton(onPressed: () {
                    showDiolog(data, 'age');
                  }, icon: Icon(Icons.edit)),
                  
                ],
              ),
          
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
