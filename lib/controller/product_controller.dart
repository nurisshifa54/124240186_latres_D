import 'package:get/get.dart';
import '../model/product.dart';
import '../service/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  final RxList<Product> _products = <Product>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isError = false.obs;

  List<Product> get products => _products;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;

  @override
  void onInit() {
    _retrieveData();
    super.onInit();
  }

  Future<void> _retrieveData() async {
    try {
      _isLoading.value = true;
      final data = await _productService.fetchProducts();
      _products.assignAll(data);
    } catch (e) {
      _isError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }
}
