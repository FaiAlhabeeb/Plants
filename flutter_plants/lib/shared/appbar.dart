import 'package:flutter/material.dart';
import 'package:flutter_plants/Pages/checkout.dart';
import 'package:flutter_plants/Provider/cart.dart';
import 'package:provider/provider.dart';

class ProductAndPrice extends StatelessWidget {
  //const productandprice ({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: ((context, classInstancee, child) {
      return Row(
        children: [
          Stack(
            children: [
              Container(
                  child: Text(
                    "${classInstancee.selectedproducts.length}",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(211, 164, 255, 193),
                      shape: BoxShape.circle)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout(),
                        ));
                  },
                  icon: Icon(Icons.add_shopping_cart)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text("${classInstancee.price}"),
          )
        ],
      );
    }));
  }
}
