import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../model/product.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  final Product product = Get.arguments as Product;
  final CartController cartController = Get.find<CartController>();
  final RxInt qty = 1.obs;

  Future<void> addToCart() async {
    final jumlah = qty.value;
    await cartController.addItem(product, jumlah);
    Get.back();
    Get.snackbar(
      '',
      '$jumlah item masuk keranjang!',
      titleText: const SizedBox.shrink(),
      backgroundColor: Colors.teal,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.thumbnail, height: 200)),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Text('Brand: ${product.brand}'),
            Text('Kategori: ${product.category}'),
            Text('Rating: ${product.rating}'),
            Text('Sisa Stok: ${product.stock}'),
            const Divider(height: 32),
            const Text(
              'Deskripsi Produk',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(product.description),
            const SizedBox(height: 24),
            Obx(
              () => Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    color: Colors.teal,
                    onPressed: qty.value > 1 ? () => qty.value-- : null,
                  ),
                  Text('${qty.value}', style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: Colors.teal,
                    onPressed:
                        qty.value < product.stock ? () => qty.value++ : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Tambah ke Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: product.stock < 1 ? null : addToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
