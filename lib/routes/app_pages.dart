import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../view/pages/cart_page.dart';
import '../view/pages/login_page.dart';
import '../view/pages/main_page.dart';
import '../view/pages/product_detail_page.dart';
import 'app_routes.dart';

class AppBinding extends Bindings {
  final String? username;

  AppBinding(this.username);

  @override
  void dependencies() {
    Get.put(AuthController(username));
    Get.put(CartController());
  }
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
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
