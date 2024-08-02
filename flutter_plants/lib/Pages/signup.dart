import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plants/Pages/login.dart';
import 'package:flutter_plants/shared/color.dart';
import 'package:flutter_plants/shared/constant.dart';
import 'package:flutter_plants/shared/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isvisible = true;
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final ageController = TextEditingController();

  bool isuppercase = false;
  bool isPassword8Char = false;
  bool islowercase = false;
  bool isnumber = false;
  bool special = false;
  onPasswordChanged(String password) {
    isPassword8Char = false;
    isuppercase = false;
    islowercase = false;
    isnumber = false;
    special = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        isuppercase = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        islowercase = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        isnumber = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        special = true;
      }
    });
  }

  register() async {
    setState(() {
      isloading = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      CollectionReference users =
          FirebaseFirestore.instance.collection('usersss');

      users
          .doc(credential.user!.uid)
          .set({
            'username': usernameController.text,
            'age': ageController.text,
            "email": emailController.text,
            "pass": passwordController.text
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, " ERROR,Please try again later");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarGreen,
          title: Text("Sign up "),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                        //height: 64,
                        ),
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationtextfield.copyWith(
                          hintText: "Enter your UserName",
                          suffixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(height: 33),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: decorationtextfield.copyWith(
                          hintText: "Enter your Age",
                          suffixIcon: Icon(Icons.pest_control_rodent)),
                    ),
                    SizedBox(height: 33),
                    TextFormField(
                        validator: (value) {
                          return value!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : "Enter a valid email";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: decorationtextfield.copyWith(
                            hintText: "Enter your Email",
                            suffixIcon: Icon(Icons.email))),
                    SizedBox(height: 33),
                    TextFormField(
                      onChanged: (password) {
                        onPasswordChanged(password);
                      },
                      validator: (value) {
                        return value!.length < 8
                            ? "Enter at least 8 characters"
                            : null;
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction;
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: isvisible ? true : false,
                      decoration: decorationtextfield.copyWith(
                          hintText: "Enter your Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isvisible = !isvisible;
                                });
                              },
                              icon: isvisible
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility))),
                    ),
                    const SizedBox(height: 33),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isPassword8Char ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("At least 8 characters"),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isnumber ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("At least 1 number"),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isuppercase ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("has uppercase"),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: islowercase ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("has lowercase"),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: special ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("has special characters"),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await register();
                          if (!mounted) return;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        } else {
                          showSnackBar(context, " ERROR");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(BTNgreen),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: isloading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 19),
                            ),
                    ),
                    SizedBox(height: 33),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("are you have already account ?",
                            style: TextStyle(fontSize: 18)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text('Sign in',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
