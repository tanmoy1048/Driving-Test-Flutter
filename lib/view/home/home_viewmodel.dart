import 'package:flutter/material.dart';

import '../../database/model/question_model.dart';
import '../../service/db_service.dart';

class HomeViewModel extends ChangeNotifier {
  DBService dBService = DBService();
  late Future isInitCompleted;
  List<QuestionModel> _questions = [];
  List<QuestionModel> get questions => _questions;

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

  // Future<bool> bookmarkAction(
  //     {required int bookmarkId, required int id, required int index}) async {
  //   final data = await dBService.bookmarkAction(bookmarkId: bookmarkId, id: id);
  //   _names[index].openPage = bookmarkId;
  //   notifyListeners();
  //   return data;
  // }
}
