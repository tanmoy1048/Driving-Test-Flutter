import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String firstTimeUserVolume = "@firstTimeVolume";
  static const String firstTimeUserDetails = "@firstTimeDetails";
  static const String _fontSizeKey = "@fontSizeKey";

  static const String _adsPurchaseKey = "@adsPurchase";

  Future<bool> showFirstTimeUiVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstTimeUserVolume) ?? true;
  }

  Future<bool> showFirstTimeUiDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstTimeUserDetails) ?? true;
  }

  Future<void> setFirstTimeUiVolume(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(firstTimeUserVolume, value);
  }

  Future<void> setFirstTimeUiDetails(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(firstTimeUserDetails, value);
  }

  // Future<void> reset() async {
  //   //TODO: For debug and test only. Remove before release
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await setFirstTimeUiVolume(true);
  //   await setFirstTimeUiDetails(true);
  // }

  Future<double> getFontSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_fontSizeKey) ?? 18.0;
  }

  Future<void> setFontSize(double v) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, v);
  }
}
