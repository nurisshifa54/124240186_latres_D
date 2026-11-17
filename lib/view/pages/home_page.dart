import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../controller/product_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/product_card.dart';

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
        title: const Text('shifaaaashop.54'),
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
                'Selamat datang, ${authController.username}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  );
                }
                if (controller.isError) {
                  return const Center(child: Text('Gagal memuat produk'));
                }
                return GridView.builder(
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: controller.products[index],
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.detail,
                          arguments: controller.products[index],
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
