import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Keranjang Belanja'),
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const Center(
            child: Text('Keranjang kamu masih kosong nih.'),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return ListTile(
                    leading: Image.network(item['thumbnail'], width: 56),
                    title: Text(item['title']),
                    subtitle: Text('Qty: ${item['qty']}  |  \$${item['price']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.pink),
                      onPressed: () {
                        controller.removeItem(item['productId']);
                        Get.snackbar(
                          '',
                          'Item dihapus dari cart',
                          titleText: const SizedBox.shrink(),
                          backgroundColor: Colors.teal,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(16),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${controller.totalPrice.toStringAsFixed(2)}',
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
      }),
    );
  }
}
