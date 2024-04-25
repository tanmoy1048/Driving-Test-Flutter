import 'package:flutter/material.dart';

import '../../database/model/question_model.dart';
import '../../service/db_service.dart';

class FavoriteViewModel extends ChangeNotifier {
  DBService dBService = DBService();
  late Future isInitCompleted;
  List<QuestionModel> _favQuestions = [];
  List<QuestionModel> get favQuestions => _favQuestions;

  FavoriteViewModel() {
    getData();
  }

  Future<void> getData() async {
    isInitCompleted = _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    _favQuestions = await dBService.getFavQuestion();
    notifyListeners();
  }

  Future<bool> favoriteAction(
      {required int id, required bool isFav, required int index}) async {
    final int favNum = isFav ? 1 : 0;
    final data = await dBService.favoriteAction(id: id, favNum: favNum);
    if (data) {
      // _favQuestions[index].favorite = favNum;
      // notifyListeners();
      // _favQuestions.add(QuestionModel(
      //   id: 0,
      //   answer: 0,
      //   image: 0,
      //   question: "",
      //   answer1: "",
      //   answer2: "",
      //   answer3: "",
      // ));
      return data;
    } else {
      return false;
    }
  }
}
