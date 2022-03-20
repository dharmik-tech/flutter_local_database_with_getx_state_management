import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingcart/common_widgets/camera_screen.dart';
import 'package:shoppingcart/modules/product/controllers/product_controller.dart';
import 'package:shoppingcart/modules/product/models/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  var productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // _buildTextField(hint: 'Product Name',controller:nameController,),
                TextFormField(
                  controller: productController.nameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Product Name',
                  ),
                  validator: requiredField,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: productController.brandController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Brand',
                  ),
                  validator: requiredField,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: productController.priceController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This is a required field';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Price should be greater than zero';
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: productController.descriptionController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Description',
                  ),
                  validator: requiredField,
                ),
                const SizedBox(
                  height: 12,
                ),
                Obx(
                  () => productController.imagePath.value.isEmpty
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Material(
                                      child: CupertinoActionSheet(
                                        actions: [
                                          InkWell(
                                            onTap: () async {
                                              Get.back();
                                              ImagePicker _picker =
                                                  ImagePicker();
                                              final XFile? photo =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);

                                              if (photo != null) {
                                                productController.imagePath
                                                    .value = photo.path;
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 20.0),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.image_outlined,
                                                      color: Theme.of(context)
                                                          .hoverColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    Text(
                                                      "Image from Gallery",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .hoverColor,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Get.back();

                                              XFile? photo = await Get.to(
                                                  () => CameraScreen());

                                              if (photo != null) {
                                                productController.imagePath
                                                    .value = photo.path;
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 20.0),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Theme.of(context)
                                                          .hoverColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    Text(
                                                      "Image from Camera",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .hoverColor,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        title: const Text("Attachment"),
                                        cancelButton: InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 20.0),
                                            child: const Center(
                                              child: Text("Cancel"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(64),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 4,
                                  children: const [
                                    Icon(Icons.camera),
                                    Text(
                                      'Upload Image',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          children: [
                            Align(
                              child: IconButton(
                                icon: const Icon(Icons.close_rounded),
                                onPressed: () {
                                  productController.imagePath.value = '';
                                },
                              ),
                              alignment: Alignment.topRight,
                            ),
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Image.file(
                                File(productController.imagePath.value),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (productController.imagePath.value.isNotEmpty) {
                          Product product = Product(
                              name: productController.nameController.text,
                              brand: productController.brandController.text,
                              imagePath: productController.imagePath.value,
                              price: num.parse(
                                  productController.priceController.text),
                              description:
                                  productController.descriptionController.text);

                          int result =
                              await productController.insertProduct(product);

                          log('insertion ' + result.toString());

                          if (result != 0) {
                            Fluttertoast.showToast(
                                msg: 'Product Added Successfully');
                            Get.back();
                          } else {
                            log('Insertion failed');
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please add product image');
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This is a required field';
    }
  }

// Widget _buildTextField({String? hint,TextEditingController? controller,}) {
//   // add other properties here}) { // new
//   return TextFormField(
//     controller: controller,
//     decoration:  InputDecoration(
//       filled: true,
//       fillColor: Colors.white,
//       border: InputBorder.none,
//       hintText: hint,
//     ),
//     validator: requiredField,
//   );
// }

}
