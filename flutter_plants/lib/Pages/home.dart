import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plants/Pages/checkout.dart';
import 'package:flutter_plants/Pages/details.dart';
import 'package:flutter_plants/Pages/login.dart';
import 'package:flutter_plants/Pages/profile.dart';
import 'package:flutter_plants/Provider/cart.dart';
import 'package:flutter_plants/model/items.dart';
import 'package:flutter_plants/shared/appbar.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 33),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          product: items[index],
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                      child: GestureDetector(
                        onTap: () {},
                        // use ClipRRect & Positioned
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              left: 0,
                              top: -3,
                              bottom: -9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(55),
                                child: Image.asset(items[index].imgPath),
                              ),
                            ),
                          ],
                        ),
                      ),
                      footer: GridTileBar(
                          // backgroundColor: Color.fromARGB(66, 73, 127, 110),
                          trailing: Consumer<Cart>(
                              builder: ((context, classInstancee, child) {
                            return IconButton(
                                color: Color.fromARGB(255, 62, 94, 70),
                                onPressed: () {
                                  classInstancee.add(items[index]);
                                },
                                icon: Icon(Icons.add));
                          })),
                          leading: Text("\$12.99"),
                          title: Text(
                            "",
                          ))));
            }),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/saudi.jpg"),
                      fit: BoxFit.cover)),
              accountName: Text("Lama Hassan",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
              accountEmail: Text("Lama@yahoo.com"),
              currentAccountPictureSize: Size.square(99),
              currentAccountPicture: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage("assets/image/personal.jpg"),
              )),
          ListTile(
              title: Text("Home"), leading: Icon(Icons.home), onTap: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
              }),
          ListTile(
              title: Text("My products"),
              leading: Icon(Icons.add_shopping_cart),
              onTap: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Checkout(),
                      ));
              }),
          ListTile(
              title: Text("About"),
              leading: Icon(Icons.help_center),
              onTap: () {}),
              ListTile(
                title: Text("Profile"),
                leading: Icon(Icons.person),
                onTap: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                }),
          ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                 FirebaseAuth.instance.signOut();
              }),
        ],
      )),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 141, 95),
        title: Text("Home"),
        actions: [
           ProductAndPrice(),
        ],
      )
    );
  }
}
