import 'package:flutter/material.dart';
import 'package:flutter_plants/shared/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plants/shared/data_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Profile extends StatelessWidget {
  Profile({super.key});
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;

  uploadImage2Screen() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        
          imgPath = File(pickedImg.path);
        
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Profile "),
      ),
     /* body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 64,
              ),
              Center(
               // child: Text("Email:${credential!.email}"),
              ),
              GetUserName(documentId: credential!.uid,),
              
            ],
          ),
        ),
      ),
      */
      body: 
      Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 225, 225, 225),
                              radius: 71,
                              // backgroundImage: AssetImage("assets/img/avatar.png"),
                              backgroundImage:
                                  AssetImage("assets/img/avatar.png"),
                            )
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                            width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        left: 99,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () {
                           // uploadImage2Screen();
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: Color.fromARGB(255, 94, 115, 128),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
               // child: Text("Email:${credential!.email}"),
              ),
              GetUserName(documentId: credential!.uid,),
            ],
          ),
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }
}
