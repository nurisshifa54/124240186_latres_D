import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import '../model/cart_item.dart';
import '../model/product.dart';

class CartController extends GetxController {
  final Box<CartItem> box = Hive.box<CartItem>('cart');

  int _findIndex(String username, int productId) {
    for (int i = 0; i < box.length; i++) {
      final item = box.getAt(i)!;
      if (item.username == username && item.productId == productId) {
        return i;
      }
    }
    return -1;
  }

  void addToCart(String username, Product product, int qty) {
    final index = _findIndex(username, product.id);

    if (index == -1) {
      box.add(
        CartItem(
          username: username,
          productId: product.id,
          title: product.title,
          price: product.price,
          image: product.images[0],
          stock: product.stock,
          qty: qty,
        ),
      );
    } else {
      final lama = box.getAt(index)!;
      box.putAt(
        index,
        CartItem(
          username: username,
          productId: product.id,
          title: product.title,
          price: product.price,
          image: product.images[0],
          stock: product.stock,
          qty: min(lama.qty + qty, product.stock),
        ),
      );
    }
  }

  void deleteItem(int index) {
    box.deleteAt(index);
  }
}
