import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plants/Pages/login.dart';
import 'package:flutter_plants/shared/color.dart';
import 'package:flutter_plants/shared/constant.dart';
import 'package:flutter_plants/shared/snackbar.dart';

class Forgetpasswords extends StatefulWidget {
  Forgetpasswords({super.key});

  @override
  State<Forgetpasswords> createState() => _ForgetpasswordsState();
}

class _ForgetpasswordsState extends State<Forgetpasswords> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;

  resetpassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
          showSnackBar(context, "Done,please check your email ");
          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "Error:${e.code}");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Reset Password "),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your email to reset your password",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 33,
                ),
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
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      resetpassword();
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
                          "Reset Password",
                          style: TextStyle(fontSize: 19),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
