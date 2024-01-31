
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab2_201097/models/Clothes.dart';

class NewClothes extends StatefulWidget {
  final Function addClothing;
  const NewClothes({super.key, required this.addClothing});

  @override
  State<NewClothes> createState() => _NewClothesState();
}

class _NewClothesState extends State<NewClothes> {
  final _nameController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _imageUrlController = new TextEditingController();
  final _priceController = new TextEditingController();
  String name="";
  String description="";
  String imageUrl="";
  double price=0.0;

  void _submitData(){
    if(_nameController.text.isEmpty || _descriptionController.text.isEmpty || _imageUrlController.text.isEmpty){
      return;
    }

    this.name=_nameController.text;
    this.description=_descriptionController.text;
    this.imageUrl=_imageUrlController.text;
    this.price=double.parse(_priceController.text);

    final newClothing = Clothes(Random().nextInt(1000), name, description, imageUrl, price);

    widget.addClothing(newClothing);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name:"),
            onSubmitted: (_) => _submitData,
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: "Description:"),
            onSubmitted: (_) => _submitData,
          ),
          TextField(
            controller: _imageUrlController,
            decoration: const InputDecoration(labelText: "Image url:"),
            onSubmitted: (_) => _submitData,
          ),
          TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Price:"),
              onSubmitted: (_) => _submitData,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]
          ),
          ElevatedButton(
            onPressed: _submitData,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(124, 252, 0, 1.0),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                )
            ),
            child: const Text("Add new clothing item"),
          )
        ],
      ),
    );
  }
}