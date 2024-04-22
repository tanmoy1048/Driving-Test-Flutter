import 'package:flutter/material.dart';

import '../../service/shared_pref_service.dart';

class FontSizeViewModel extends ChangeNotifier {
  double _fontSize = 18.0;
  double get fontSize => _fontSize;

  FontSizeViewModel() {
    _getData();
  }

  Future<void> _getData() async {
    _fontSize = await SharedPrefService().getFontSize();
    notifyListeners();
  }

  Future<void> setFontData(double fontSize) async {
    _fontSize = fontSize;
    await SharedPrefService().setFontSize(fontSize);
    notifyListeners();
  }
}
