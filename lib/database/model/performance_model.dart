const String performanceTable = "performance";

class PerformanceFields {
  static final List<String> values = [
    id,
    numberOfQuestion,
    score,
    correct,
    wrong,
    timestamp,
  ];

  static const String id = "_id";
  static const String numberOfQuestion = "numberofquestion";
  static const String score = "score";
  static const String correct = "correct";
  static const String wrong = "wrong";
  static const String timestamp = "timestamp";
}

class PerformanceListModel {
  final int num;
  final List<PerformanceModel> contents;

  PerformanceListModel({required this.num, required this.contents});
}

class PerformanceModel {
  final int id;
  final int numberOfQuestion;
  final int score;
  final int correct;
  final int wrong;
  final String timestamp;

  const PerformanceModel({
    required this.id,
    required this.numberOfQuestion,
    required this.score,
    required this.correct,
    required this.wrong,
    required this.timestamp,
  });

  PerformanceModel copy({
    required int id,
    required int numberOfQuestion,
    required int score,
    required int correct,
    required int wrong,
    required String timestamp,
  }) =>
      PerformanceModel(
        id: id,
        numberOfQuestion: numberOfQuestion,
        score: score,
        correct: correct,
        wrong: wrong,
        timestamp: timestamp,
      );

  static PerformanceModel fromJson(Map<String, Object?> json) =>
      PerformanceModel(
        id: json[PerformanceFields.id] as int,
        numberOfQuestion: json[PerformanceFields.numberOfQuestion] as int,
        score: json[PerformanceFields.score] as int,
        correct: json[PerformanceFields.correct] as int,
        wrong: json[PerformanceFields.wrong] as int,
        timestamp: json[PerformanceFields.timestamp] as String,
      );

  Map<String, Object?> toJson() => {
        PerformanceFields.id: id,
        PerformanceFields.numberOfQuestion: numberOfQuestion,
        PerformanceFields.score: score,
        PerformanceFields.correct: correct,
        PerformanceFields.wrong: wrong,
        PerformanceFields.timestamp: timestamp,
      };
}
