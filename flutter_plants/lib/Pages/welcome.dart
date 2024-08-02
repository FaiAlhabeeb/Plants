import 'package:flutter/material.dart';
import 'package:flutter_plants/Pages/login.dart';
import 'package:flutter_plants/Pages/signup.dart';
import 'package:flutter_plants/shared/color.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Welcome "),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/image/logo.jpg",
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 400),
              ElevatedButton(
                onPressed: () {
                  onTap:
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  };
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appbarGreen,
                  minimumSize:
                      Size(300, 50), // Adjust the width and height as needed
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   onTap:
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  };
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appbarGreen,
                  minimumSize:
                      Size(300, 50), // Adjust the width and height as needed
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
