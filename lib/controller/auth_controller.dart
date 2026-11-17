import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final RxString _username = ''.obs;

  String get username => _username.value;

  @override
  void onInit() {
    _loadUsername();
    super.onInit();
  }

  Future<void> _loadUsername() async {
    final loginData = await SharedPreferences.getInstance();
    _username.value = loginData.getString('username') ?? '';
  }

  Future<void> checkLogin() async {
    final loginData = await SharedPreferences.getInstance();
    final adaLogin = loginData.getBool('loginData') ?? false;
    if (adaLogin) {
      Get.offAllNamed(AppRoutes.main);
    }
  }

  Future<void> login(String name, String password) async {
    if (name.isEmpty) {
      _showMessage('Username wajib diisi!', Colors.red);
      return;
    }
    if (password.isEmpty) {
      _showMessage('Password wajib diisi!', Colors.red);
      return;
    }
    if (password != '124240186') {
      _showMessage('Password salah, gunakan NIM kamu!', Colors.red);
      return;
    }

    final loginData = await SharedPreferences.getInstance();
    await loginData.setBool('loginData', true);
    await loginData.setString('username', name);
    _username.value = name;

    Get.offAllNamed(AppRoutes.main);
    _showMessage('Login Berhasil!', Colors.teal);
  }

  Future<void> logout() async {
    final loginData = await SharedPreferences.getInstance();
    await loginData.remove('loginData');
    await loginData.remove('username');
    _username.value = '';

    Get.offAllNamed(AppRoutes.login);
    _showMessage('Berhasil logout', Colors.teal);
  }

  void _showMessage(String message, Color color) {
    Get.snackbar(
      '',
      message,
      titleText: const SizedBox.shrink(),
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
