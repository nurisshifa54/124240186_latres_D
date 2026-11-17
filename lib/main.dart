import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'service/cart_service.dart';
import 'service/notification_service.dart';
import 'service/session_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(CartService.boxName);
  await NotificationService().init();

  final username = await SessionService.getUsername();

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Toko Online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialBinding: AppBinding(username),
      initialRoute: username == null ? AppRoutes.login : AppRoutes.main,
      getPages: AppPages.routes,
    );
  }
}
