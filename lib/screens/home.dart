import 'package:flutter/material.dart';
import 'package:lab2_201097/screens/shopping_cart.dart';
import '../models/Clothes.dart';
import '../widgets/edit.dart';
import '../widgets/add_new.dart';
import 'dart:ui' as ui;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Clothes> clothes = [];
  List<Clothes> shopping_cart = [];

  void _addClothing() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewClothes(
              addClothing: _addNewClothesToList,
            ),
          );
        });
  }

  void _addNewClothesToList(Clothes newClothes) {
    setState(() {
      clothes.add(newClothes);
    });
  }

  void _editClothes(index) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: EditClothes(
              editClothes: _editClothesFromList,
              index: index,
              clothing: clothes[index],
            ),
          );
        });
  }

  void _editClothesFromList(Clothes newClothes, int index) {
    setState(() {
      clothes[index].name = newClothes.name;
      clothes[index].description = newClothes.description;
      clothes[index].imageUrl = newClothes.imageUrl;
      clothes[index].price = newClothes.price;
    });
  }

  void _addToShoppingCart(int index) {
    setState(() {
      shopping_cart.add(clothes[index]);
    });
  }

  void _goToShoppingCart() {
    print("shopping cart pressed");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ShoppingCartScreen(shoppingCart: shopping_cart)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("201097 Clothes shop"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            ElevatedButton(
              onPressed: () => _addClothing(),
              style: const ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Color.fromRGBO(124, 252, 0, 1.0))),
              child: const Text(
                "Add clothes",
                style: TextStyle(color: Color.fromRGBO(128, 0, 32, 1.0)),
              ),
            )
          ],
        ),
        body: GridView.builder(
          itemCount: clothes.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(clothes[index].name)]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        clothes[index].imageUrl,
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
                      const Text(" Price:"),
                      Text(clothes[index].price.toString()),
                      const Text("\$"),
                      ElevatedButton(
                        onPressed: () => _addToShoppingCart(index),
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(124, 252, 0, 1.0)),
                          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0)),
                        ),
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(color: Color.fromRGBO(128, 0, 32, 1.0)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            clothes.removeAt(index);
                          });
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(124, 252, 0,1.0)),
                          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.delete, color: Color.fromRGBO(128, 0, 32, 1.0),),
                            Text("Delete", style: TextStyle(color: Color.fromRGBO(128, 0, 32, 1.0))),
                            ],
                        )
                      ),
                      ElevatedButton(
                        onPressed: () => _editClothes(index),
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(124, 252, 0,1.0)),
                            padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.0)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.edit, color: Color.fromRGBO(128, 0, 32, 1.0),),
                            Text("Edit", style: TextStyle(color: Color.fromRGBO(128, 0, 32, 1.0))),
                          ],
                        )
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: _goToShoppingCart,
                style: const ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Color.fromRGBO(124, 252, 0,1.0)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add_shopping_cart, color: Color.fromRGBO(128, 0, 32, 1.0),),
                    Text("View cart", style: TextStyle(color: Color.fromRGBO(128, 0, 32, 1.0)), )
                  ],
                ))
          ],
        ));
  }
}