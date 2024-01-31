import 'package:flutter/material.dart';
import '../models/Clothes.dart';

class ShoppingCartScreen extends StatefulWidget {
  final List<Clothes> shoppingCart;

  const ShoppingCartScreen({super.key, required this.shoppingCart});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("201097 Clothes shop"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.builder(
        itemCount: widget.shoppingCart.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.shoppingCart[index].imageUrl,
                      height: 72,
                      width: 72,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Text('Error loading image');
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.shoppingCart[index].name),
                    const Text(" - "),
                    Text(widget.shoppingCart[index].price.toString()),
                    const Text("\$"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.shoppingCart.removeAt(index);
                        });
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll<Color>(Color.fromRGBO(124, 252, 0, 1.0)),
                      ),
                      child: const Text(
                        "Delete from cart",
                        style: TextStyle(color: Color.fromRGBO(128, 0, 32, 1.0)),
                      ),
                    ),
                  ],
                )
              ],
            ),

          );
        }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            setState(() {
              widget.shoppingCart.clear();
            });

          },
              style: const ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll<Color>(Color.fromRGBO(124, 252, 0, 1.0)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.sell,color: Color.fromRGBO(20, 52, 164, 1.0)),
                  Text("Buy everything from your cart?", style: TextStyle(color: Color.fromRGBO(20, 52, 164, 1.0), fontWeight: FontWeight.w700),),
                ],
              )
          )
        ],
      ),
    );
  }
}