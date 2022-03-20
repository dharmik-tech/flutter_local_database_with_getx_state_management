import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shoppingcart/modules/product/views/add_product_screen.dart';
import 'package:shoppingcart/modules/product/views/product_listing_screen.dart';

class AppRoutes {
  static const addProduct = '/AddProduct';
  static const productList = '/';

  static final routes = [
    GetPage(
      name: AppRoutes.productList,
      page: () => ProductListingScreen(),
    ),
    GetPage(
      name: AppRoutes.addProduct,
      page: () => AddProductScreen(),
    ),
  ];
}
