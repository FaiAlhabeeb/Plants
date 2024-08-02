import 'package:flutter/material.dart';
import 'package:flutter_plants/Pages/checkout.dart';
import 'package:flutter_plants/Pages/verifyEmail.dart';
import 'package:flutter_plants/Pages/welcome.dart';
import 'package:flutter_plants/Provider/cart.dart';
import 'package:flutter_plants/firebase_options.dart';
import 'package:flutter_plants/shared/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_plants/Pages/details.dart';
import 'package:flutter_plants/Pages/home.dart';
import 'package:flutter_plants/Pages/login.dart';
import 'package:flutter_plants/Pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model/items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Cart();
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          home: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return showSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                return VerifyEmailPage(); //Home();
              } else {
                return Login();
              }
            },
            stream: FirebaseAuth.instance.authStateChanges(),
          )),
    );
  }
}
