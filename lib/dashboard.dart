import 'package:flutter/material.dart';

import 'view/favorite/favorite_page.dart';
import 'view/home/home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int pageIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _list = [
    const HomePage(),
    const FavoritePage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (n) {
          setState(() {
            pageIndex = n;
          });
        },
        children: _list,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (int index) {
          _pageController.jumpToPage(index);
          setState(() {
            pageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            label: "Home",
            icon: Icon(
              Icons.dashboard,
            ),
            tooltip: "Home",
          ),
          NavigationDestination(
            label: "Favorites",
            icon: Icon(
              Icons.favorite,
            ),
            tooltip: "Favorites",
          ),
        ],
      ),
    );
  }
}
