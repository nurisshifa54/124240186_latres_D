import 'package:hive_flutter/hive_flutter.dart';

class CartService {
  static const String boxName = 'cart';

  Box get _box => Hive.box(boxName);

  String _key(String username, int productId) => '$username-$productId';

  List<Map<String, dynamic>> getItems(String username) {
    return _box.values
        .where((item) => item['username'] == username)
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }

  Future<void> saveItem(String username, Map<String, dynamic> item) {
    return _box.put(_key(username, item['productId']), item);
  }

  Map<String, dynamic>? findItem(String username, int productId) {
    final item = _box.get(_key(username, productId));
    if (item == null) return null;
    return Map<String, dynamic>.from(item as Map);
  }

  Future<void> deleteItem(String username, int productId) {
    return _box.delete(_key(username, productId));
  }
}
