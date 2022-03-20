import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shoppingcart/modules/product/controllers/product_controller.dart';
import 'package:shoppingcart/modules/product/models/product.dart';
import 'package:shoppingcart/modules/product/views/add_product_screen.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({Key? key}) : super(key: key);

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  var productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddProductScreen());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: productController.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Obx(
              () => productController.products.value.isNotEmpty
                  ? GridView.builder(
                      itemCount: productController.products.value.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black12, width: 0.5)),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Image.file(
                                  File(productController
                                      .products.value[index].imagePath!),
                                  width: double.infinity,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                productController.products.value[index].brand!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(productController
                                  .products.value[index].name!),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('\$ ' +
                                  productController.products.value[index].price!
                                      .toString()),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        );

                        // Row(
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 20,
                        //       child: Image.file(
                        //         File(productController
                        //             .products.value[index].imagePath!),
                        //         width: 25,
                        //         height: 30,
                        //         fit: BoxFit.scaleDown,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 16,
                        //     ),
                        //   ],
                        // )
                        //   ListTile(
                        //   leading: Image.file(File(productController
                        //       .products.value[index].imagePath!)),
                        //   title: Text(
                        //     productController.products.value[index].name!,
                        //   ),
                        // );
                      },
                    )
                  : const Center(
                      child: Text('No Products yet'),
                    ),
            );
          } else {
            return const Center(
              child: Text('No Data Found'),
            );
          }
        },
      ),
    );
  }
}
