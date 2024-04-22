const String nameTable = "battle_name";

class BattleNameFields {
  static final List<String> values = [
    id,
    name,
    openPage,
    drawable,
  ];

  static const String id = "_id";
  static const String name = "name";
  static const String openPage = "open_page";
  static const String drawable = "battle_drawable";
}

class BattleNameListModel {
  final int nameNum;
  final List<BattleNameModel> names;

  BattleNameListModel({required this.nameNum, required this.names});
}

class BattleNameModel {
  final int id;
  final String name;
  int? openPage;
  final String drawable;

  BattleNameModel({
    required this.id,
    this.openPage,
    required this.name,
    required this.drawable,
  });

  BattleNameModel copy({
    required int id,
    required String name,
    int? openpage,
    required String drawable,
  }) =>
      BattleNameModel(
        id: id,
        name: name,
        drawable: drawable,
        openPage: openpage ?? this.openPage,
      );

  static BattleNameModel fromJson(Map<String, Object?> json) => BattleNameModel(
        id: json[BattleNameFields.id] as int,
        openPage: json[BattleNameFields.openPage] as int?,
        name: json[BattleNameFields.name] as String,
        drawable: json[BattleNameFields.drawable] as String,
      );

  Map<String, Object?> toJson() => {
        BattleNameFields.id: id,
        BattleNameFields.name: name,
        BattleNameFields.drawable: drawable,
        BattleNameFields.openPage: openPage,
      };
}
