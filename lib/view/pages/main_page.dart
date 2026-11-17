import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final RxInt _currentIndex = 0.obs;
  final List<Widget> _pages = [HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _pages[_currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex.value,
          onTap: (index) => _currentIndex.value = index,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
