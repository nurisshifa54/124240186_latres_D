import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../view/pages/cart_page.dart';
import '../view/pages/login_page.dart';
import '../view/pages/main_page.dart';
import '../view/pages/product_detail_page.dart';
import 'app_routes.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<CartController>(() => CartController());
  }
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => ProductDetailPage(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartPage(),
    ),
  ];
}
