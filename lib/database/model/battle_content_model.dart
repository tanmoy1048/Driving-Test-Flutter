const String contentTable = "battle_content";

class BattleContentFields {
  static final List<String> values = [
    storyid,
    pageNumber,
    content,
  ];

  static const String storyid = "story_id";
  static const String pageNumber = "page_number";
  static const String content = "content";
}

class BattleContentListModel {
  final int contentNum;
  final List<BattleContentModel> contents;

  BattleContentListModel({required this.contentNum, required this.contents});
}

class BattleContentModel {
  final int storyid;
  final int pageNum;
  final String content;

  const BattleContentModel({
    required this.storyid,
    required this.content,
    required this.pageNum,
  });

  BattleContentModel copy({
    required int storyid,
    required String content,
    required int pageNum,
  }) =>
      BattleContentModel(
        storyid: storyid,
        content: content,
        pageNum: pageNum,
      );

  static BattleContentModel fromJson(Map<String, Object?> json) =>
      BattleContentModel(
        storyid: json[BattleContentFields.storyid] as int,
        content: json[BattleContentFields.content] as String,
        pageNum: json[BattleContentFields.pageNumber] as int,
      );

  Map<String, Object?> toJson() => {
        BattleContentFields.storyid: storyid,
        BattleContentFields.content: content,
        BattleContentFields.pageNumber: pageNum,
      };
}
