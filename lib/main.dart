import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'common/font_viewmodel.dart';
import 'view/chapters/chapter_viewmodel.dart';
import 'view/main/main_page.dart';
import 'view/main/main_viewmodel.dart';

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
        ChangeNotifierProvider<MainViewModel>(
            create: (context) => MainViewModel(), lazy: false),
        ChangeNotifierProvider<ChapterViewModel>(
            create: (context) => ChapterViewModel(), lazy: false),
        ChangeNotifierProvider<FontSizeViewModel>(
            create: (context) => FontSizeViewModel(), lazy: false),
      ],
      child: MaterialApp(
        title: 'Driving Test',
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const MainPage(),
      ),
    );
  }
}
