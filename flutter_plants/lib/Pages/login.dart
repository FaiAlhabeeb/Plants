import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plants/Pages/forgetpasswords.dart';
import 'package:flutter_plants/Pages/signup.dart';
import 'package:flutter_plants/shared/color.dart';
import 'package:flutter_plants/shared/constant.dart';
import 'package:flutter_plants/shared/snackbar.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isvisible=false;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Signin() async {
    

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text);
      showSnackBar(context, "Done");
    } on FirebaseAuthException catch (e) {
     showSnackBar(context, "Error:${e.code}");
    }
    Navigator.pop(context);
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: appbarGreen,
      title: Text("Sign in "),),
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(33.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 64,
            ),
            TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                
                decoration:
                    decorationtextfield.copyWith(hintText: "Enter your Email",suffixIcon: Icon(Icons.email))),
                    
                    
            SizedBox(height: 33),
            TextField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: isvisible?false:true,
                decoration: decorationtextfield.copyWith(
                    hintText: "Enter your Password"
                    , suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isvisible = !isvisible;
                            });
                          },
                          icon: isvisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility))),
                    ),
            SizedBox(height: 33),
            ElevatedButton(
              onPressed: () async {
                await Signin();
                if (!mounted) return;
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(BTNgreen),
                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 19),
              ),
            ),
            SizedBox(height: 20),
            TextButton(onPressed: (){
               Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Forgetpasswords()));
            }, child: Text("Forget password?",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline),
            )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("don't have an account ?", style: TextStyle(fontSize: 18)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text('Sign up',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
