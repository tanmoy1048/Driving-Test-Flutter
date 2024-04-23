const String questionTable = "question";

class QuestionFields {
  static final List<String> values = [
    id,
    question,
    answer1,
    answer2,
    answer3,
    answer,
    image,
    favorite,
  ];

  static const String id = "_id";
  static const String question = "question";
  static const String answer = "answer";
  static const String answer1 = "answer1";
  static const String answer2 = "answer2";
  static const String answer3 = "answer3";
  static const String image = "image";
  static const String favorite = "favorite";
}

class QuestionListModel {
  final int ind;
  final List<QuestionModel> questions;

  QuestionListModel({required this.ind, required this.questions});
}

class QuestionModel {
  final int id;
  final int answer;
  final int image;
  int? favorite;

  final String question;
  final String answer1;
  final String answer2;
  final String answer3;

  QuestionModel({
    required this.id,
    required this.answer,
    required this.image,
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    this.favorite,
  });

  QuestionModel copy({
    required int id,
    required int answer,
    required int image,
    int? favorite,
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
  }) =>
      QuestionModel(
        id: id,
        answer: answer,
        image: image,
        favorite: favorite ?? this.favorite,
        question: question,
        answer1: answer1,
        answer2: answer2,
        answer3: answer3,
      );

  static QuestionModel fromJson(Map<String, Object?> json) => QuestionModel(
        id: json[QuestionFields.id] as int,
        answer: json[QuestionFields.answer] as int,
        image: json[QuestionFields.image] as int,
        favorite: json[QuestionFields.favorite] as int?,
        question: json[QuestionFields.question] as String,
        answer1: json[QuestionFields.answer1] as String,
        answer2: json[QuestionFields.answer2] as String,
        answer3: json[QuestionFields.answer3] as String,
      );

  Map<String, Object?> toJson() => {
        QuestionFields.id: id,
        QuestionFields.answer: answer,
        QuestionFields.image: image,
        QuestionFields.favorite: favorite,
        QuestionFields.question: question,
        QuestionFields.answer1: answer1,
        QuestionFields.answer2: answer2,
        QuestionFields.answer3: answer3,
      };
}
