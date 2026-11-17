import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../controller/auth_controller.dart';
import '../../controller/cart_controller.dart';
import '../../model/cart_item.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final AuthController authController = Get.find<AuthController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Keranjang Belanja'),
      ),
      body: Obx(() {
        final username = authController.username;

        return ValueListenableBuilder<Box<CartItem>>(
          valueListenable: cartController.box.listenable(),
          builder: (context, box, child) {
            final indexes = [
              for (int i = 0; i < box.length; i++)
                if (box.getAt(i)!.username == username) i,
            ];

            if (indexes.isEmpty) {
              return const Center(
                child: Text('Keranjang kamu masih kosong nih.'),
              );
            }

            double total = 0;
            for (final index in indexes) {
              final item = box.getAt(index)!;
              total += item.price * item.qty;
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: indexes.length,
                    itemBuilder: (context, i) {
                      final index = indexes[i];
                      final item = box.getAt(index)!;
                      return ListTile(
                        leading: Image.network(item.image, width: 56),
                        title: Text(item.title),
                        subtitle: Text('Qty: ${item.qty}  |  \$${item.price}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.pink),
                          onPressed: () {
                            cartController.deleteItem(index);
                            Get.snackbar(
                              '',
                              'Item dihapus dari cart',
                              titleText: const SizedBox.shrink(),
                              backgroundColor: Colors.teal,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
