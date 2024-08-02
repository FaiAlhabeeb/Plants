import 'package:flutter/material.dart';

class Item {
  String imgPath;
  double price;
  String name;
  Item({required this.imgPath, required this.price,required this.name});
}

List<Item> items = [
  Item(name: "Product1",imgPath: "assets/image/plants1.webp", price: 12.55),
  Item(name:"product2",imgPath: "assets/image/plants2.jpg", price: 20.55),
  Item(name: "product3", imgPath: "assets/image/plants3.jpg", price: 30.55),
  Item(name: "product4", imgPath: "assets/image/plants4.webp", price: 12.55),
  Item(name: "product5", imgPath: "assets/image/plants5.jpg", price: 18.55),
  Item(name: "product6", imgPath: "assets/image/plants6.webp", price: 12.55),
];
