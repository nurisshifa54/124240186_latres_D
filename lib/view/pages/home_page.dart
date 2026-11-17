import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../controller/product_controller.dart';
import '../../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthController authController = Get.find<AuthController>();
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Toko Online'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed(AppRoutes.cart),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: Obx(
              () => Text(
                'Selamat datang, ${authController.username.value ?? ''}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rekomendasi Produk',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.isError) {
                return Center(
                  child: ElevatedButton(
                    onPressed: controller.retrieveData,
                    child: const Text('Gagal memuat, coba lagi'),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ListTile(
                    leading: Image.network(product.thumbnail, width: 56),
                    title: Text(product.title),
                    subtitle: Text(
                      '\$${product.price}',
                      style: const TextStyle(color: Colors.teal),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: Colors.pink),
                    onTap: () => Get.toNamed(AppRoutes.detail, arguments: product),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
