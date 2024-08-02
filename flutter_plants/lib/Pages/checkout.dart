import 'package:flutter/material.dart';
import 'package:flutter_plants/Provider/cart.dart';
import 'package:flutter_plants/shared/appbar.dart';
import 'package:flutter_plants/shared/color.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartt = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("checkout"),
          backgroundColor: appbarGreen,
          actions: [
            ProductAndPrice(),
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
                child: SizedBox(
                    height: 550,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: cartt.selectedproducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              subtitle: Text(
                                  "${cartt.selectedproducts[index].price}"),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    cartt.selectedproducts[index].imgPath),
                              ),
                              title: Text(cartt.selectedproducts[index].name),
                              trailing: IconButton(
                                  onPressed: () {
                                    cartt.delete(cartt.selectedproducts[index]);
                                  },
                                  icon: Icon(Icons.remove)),
                            ),
                          );
                        }))),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(BTNpink),
                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
              child: Text(
                "Pay \$${cartt.price}",
                style: TextStyle(fontSize: 19),
              ),
            ),
          ],
        ));
  }
}
