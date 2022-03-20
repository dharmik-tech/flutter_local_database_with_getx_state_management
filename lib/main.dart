import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shoppingcart/app_routes.dart';
import 'package:shoppingcart/modules/product/views/product_listing_screen.dart';
import 'package:sqflite/sqflite.dart';

import 'modules/product/views/add_product_screen.dart';

late Future<Database> database;
late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  database = openDatabase(
    join(await getDatabasesPath(), 'local_db_app.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE product(id INTEGER PRIMARY KEY, name TEXT, brand TEXT, price REAL, description TEXT, image_path TEXT)',
      );
    },
    version: 1,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductListingScreen(),
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.productList,
    );
  }
}
