import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:provider/provider.dart';

import 'dashboard.dart';
import 'view/favorite/favorite_viewmodel.dart';
import 'view/home/home_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
            create: (context) => HomeViewModel(), lazy: false),
        ChangeNotifierProvider<FavoriteViewModel>(
            create: (context) => FavoriteViewModel(), lazy: false),
      ],
      child: MaterialApp(
        title: 'Driving Test',
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const DashboardPage(),
      ),
    );
  }
}
