import 'dart:math';
import 'package:get/get.dart';
import '../model/product.dart';
import '../service/cart_service.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();
  final AuthController _authController = Get.find<AuthController>();

  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;

  String get _username => _authController.username.value ?? '';

  double get totalPrice {
    return items.fold(
      0.0,
      (total, item) => total + (item['price'] as double) * (item['qty'] as int),
    );
  }

  @override
  void onInit() {
    loadItems();
    ever(_authController.username, (_) => loadItems());
    super.onInit();
  }

  void loadItems() {
    items.assignAll(_cartService.getItems(_username));
  }

  Future<void> addItem(Product product, int qty) async {
    final existing = _cartService.findItem(_username, product.id);
    final newQty = existing == null
        ? qty
        : min((existing['qty'] as int) + qty, product.stock);

    await _cartService.saveItem(_username, {
      'username': _username,
      'productId': product.id,
      'title': product.title,
      'price': product.price,
      'thumbnail': product.thumbnail,
      'stock': product.stock,
      'qty': newQty,
    });
    loadItems();
  }

  Future<void> removeItem(int productId) async {
    await _cartService.deleteItem(_username, productId);
    loadItems();
  }
}
