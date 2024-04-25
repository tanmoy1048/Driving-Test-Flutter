import 'package:flutter/material.dart';

import '../../database/model/question_model.dart';
import '../../service/db_service.dart';

class HomeViewModel extends ChangeNotifier {
  DBService dBService = DBService();
  late Future isInitCompleted;
  List<QuestionModel> _questions = [];
  List<QuestionModel> get questions => _questions;
  // List<QuestionModel> get favotiteQuestions =>
  //     _questions.where((element) => element.favorite == 1).toList();

  HomeViewModel() {
    getData();
  }

  Future<void> getData() async {
    isInitCompleted = _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    _questions = await dBService.getStory();
    notifyListeners();
  }

  Future<bool> favoriteAction(
      {required int id, required bool isFav, required int index}) async {
    final int favNum = isFav ? 1 : 0;
    final data = await dBService.favoriteAction(id: id, favNum: favNum);
    if (data) {
      _questions[index].favorite = favNum;
      notifyListeners();
      return data;
    } else {
      return false;
    }
  }

  // Future<bool> favoriteFavoriteAction({
  //   required int id,
  //   required bool isFav,
  //   required int index,
  // }) async {
  //   final int favNum = isFav ? 1 : 0;
  //   final data = await dBService.favoriteAction(id: id, favNum: favNum);
  //   if (data) {
  //     for (int i = 0; i < _questions.length; i++) {
  //       if (_questions[i].id == id) _questions[i].favorite = favNum;
  //     }

  //     notifyListeners();
  //     return data;
  //   } else {
  //     return false;
  //   }
  // }
}
