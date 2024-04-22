import 'package:flutter/foundation.dart';

class Strings {
  Strings._();

  // static const Color darkGreen = Color.fromARGB(255, 3, 20, 14);
  // static const Color lightGreen = Color.fromARGB(255, 12, 80, 51);

  // static List<Color> dividerGradient = [
  //   Colors.yellow.withOpacity(0.1),
  //   const Color.fromARGB(255, 249, 199, 13),
  //   Colors.yellow.withOpacity(0.1),
  // ];

  // static const backgroundGradient = RadialGradient(
  //   colors: [
  //     Strings.lightGreen,
  //     Strings.darkGreen,
  //   ],
  //   radius: 1.5,
  // );

  // static const Color fontColorYellow = Color.fromARGB(255, 249, 199, 13);
  // static const Color borderColor = Color.fromARGB(255, 249, 199, 13);
  // static const double borderWidth = 6;

  // static const String searchPageSuggestion =
  //     "Write any keyword/sentence to search";
  // static const String onEmptyResponse = "No Data found";

  static String getBannerAdIdAndroid() {
    if (kDebugMode) {
      return "ca-app-pub-3940256099942544/6300978111"; // debug test id
    } else {
      return "ca-app-pub-5253224370915598/5294630665"; //release id
    }
  }

  // static String getBannerAdIdIOS() {
  //   if (kDebugMode) {
  //     return "ca-app-pub-3940256099942544/2934735716"; // debug test id
  //   } else {
  //     return "ca-app-pub-5253224370915598/5913564266"; //release id
  //   }
  // }
}
