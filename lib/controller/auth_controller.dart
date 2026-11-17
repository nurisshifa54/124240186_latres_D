import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../service/session_service.dart';

class AuthController extends GetxController {
  final RxnString username = RxnString();

  AuthController(String? savedUsername) {
    username.value = savedUsername;
  }

  Future<void> login(String name, String password) async {
    if (name.trim().isEmpty) {
      _pesan('Username wajib diisi!', Colors.red);
      return;
    }
    if (password.trim().isEmpty) {
      _pesan('Password wajib diisi!', Colors.red);
      return;
    }
    if (password.trim() != '124240186') {
      _pesan('Password salah, gunakan NIM kamu!', Colors.red);
      return;
    }

    await SessionService.saveUsername(name.trim());
    username.value = name.trim();
    Get.offAllNamed(AppRoutes.main);
    _pesan('Login Berhasil!', Colors.teal);
  }

  Future<void> logout() async {
    await SessionService.clear();
    username.value = null;
    Get.offAllNamed(AppRoutes.login);
    _pesan('Berhasil logout', Colors.teal);
  }

  void _pesan(String text, Color color) {
    Get.snackbar(
      '',
      text,
      titleText: const SizedBox.shrink(),
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
