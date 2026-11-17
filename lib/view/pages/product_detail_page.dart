import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../controller/cart_controller.dart';
import '../../model/product.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  final AuthController authController = Get.find<AuthController>();
  final CartController cartController = Get.find<CartController>();
  final RxInt _qty = 1.obs;

  void _addToCart(Product product) {
    final jumlah = _qty.value;
    cartController.addToCart(authController.username, product, jumlah);
    Get.back();
    Get.snackbar(
      '',
      '$jumlah item masuk keranjang!',
      titleText: const SizedBox.shrink(),
      backgroundColor: Colors.teal,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: Center(
                  child: product.images.length > 1
                      ? ListView.separated(
                          itemCount: product.images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              color: Colors.white,
                              child: Image.network(product.images[index]),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                        )
                      : Card(
                          elevation: 3,
                          color: Colors.white,
                          child: Image.network(
                            product.images[0],
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Rating: ${product.rating}'),
                ],
              ),
              Text('Brand: ${product.brand}'),
              Text('Kategori: ${product.category}'),
              Text('Sisa Stok: ${product.stock}'),
              const SizedBox(height: 10),
              Text(product.description, textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: product.tags
                      .map((tag) => Chip(label: Text(tag)))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Reviews',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              Column(
                children: product.reviews.map((review) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        review['reviewerName'].toString().substring(0, 1),
                      ),
                    ),
                    title: Text(review['reviewerName'].toString()),
                    subtitle: Text(review['comment'].toString()),
                    trailing: Text('${review['rating']}'),
                  );
                }).toList(),
              ),
              const Divider(height: 32),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      color: Colors.teal,
                      onPressed: _qty.value > 1 ? () => _qty.value-- : null,
                    ),
                    Text('${_qty.value}', style: const TextStyle(fontSize: 20)),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      color: Colors.teal,
                      onPressed:
                          _qty.value < product.stock ? () => _qty.value++ : null,
                    ),
                  ],
                ),
              ),
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
                  onPressed: product.stock < 1 ? null : () => _addToCart(product),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
