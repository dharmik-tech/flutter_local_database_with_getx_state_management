import 'package:get/get.dart';
import 'package:shoppingcart/modules/product/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class ProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxList<Product> products = <Product>[].obs;
  RxString imagePath = ''.obs;

  // Define a function that inserts dogs into the database
  Future<int> insertProduct(Product product) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the product into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    int result = await db.insert(
      'product',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );

    await getProducts();

    return result;
  }

// A method that retrieves all the products from the product table.
  Future<List<Product>> getProducts() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('product');

    // Convert the List<Map<String, dynamic> into a List<Product>.
    List<Product> productList = List.generate(maps.length, (i) {
      return Product(
          id: maps[i]['id'],
          name: maps[i]['name'],
          brand: maps[i]['brand'],
          imagePath: maps[i]['image_path'],
          description: maps[i]['description'],
          price: maps[i]['price']);
    });

    products.clear();
    products.assignAll(productList);
    return products.value;
  }

//
// Future<void> updateDog(Dog dog) async {
//   // Get a reference to the database.
//   final db = await database;
//
//   // Update the given Dog.
//   await db.update(
//     'dogs',
//     dog.toMap(),
//     // Ensure that the Dog has a matching id.
//     where: 'id = ?',
//     // Pass the Dog's id as a whereArg to prevent SQL injection.
//     whereArgs: [dog.id],
//   );
// }
//
// Future<void> deleteDog(int id) async {
//   // Get a reference to the database.
//   final db = await database;
//
//   // Remove the Dog from the database.
//   await db.delete(
//     'dogs',
//     // Use a `where` clause to delete a specific dog.
//     where: 'id = ?',
//     // Pass the Dog's id as a whereArg to prevent SQL injection.
//     whereArgs: [id],
//   );
// }

}
