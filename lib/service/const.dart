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

  static const List<String> questionImages = [
    "i_4",
    "i_6",
    "i_7",
    "i_10",
    "i_12",
    "i_14",
    "i_15",
    "i_18",
    "i_19",
    "i_20",
    "i_21",
    "i_23",
    "i_24",
    "i_25",
    "i_27",
    "i_28",
    "i_29",
    "i_30",
    "i_31",
    "i_38",
    "i_39",
    "i_40",
    "i_42",
    "i_43",
    "i_44",
    "i_46",
    "i_47",
    "i_50",
    "i_52",
    "i_53",
    "i_54",
    "i_55",
    "i_58",
    "i_61",
    "i_66",
    "i_71",
    "i_73",
    "i_75",
    "i_76",
    "i_77",
    "i_79",
    "i_82",
    "i_83",
    "i_85",
    "i_86",
    "i_88",
    "i_91",
    "i_92",
    "i_93",
    "i_103",
    "i_104",
    "i_109",
    "i_110",
    "i_115",
    "i_116",
    "i_123",
    "i_125",
    "i_134",
    "i_137",
    "i_139",
    "i_141",
    "i_143",
    "i_148",
    "i_150",
    "i_151",
    "i_155",
    "i_175",
    "i_178",
    "i_183",
    "i_199",
    "i_200",
    "i_202",
    "i_205",
    "i_211",
    "i_212",
    "i_214",
    "i_217",
    "i_222",
    "i_228",
    "i_247",
    "i_248",
    "i_251",
    "i_261",
    "i_262",
    "i_268",
    "i_272",
    "i_273",
    "i_287",
    "i_297",
    "i_313"
  ];
}
