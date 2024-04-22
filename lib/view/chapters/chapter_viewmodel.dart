import 'package:flutter/material.dart';

import '../../database/model/battle_content_model.dart';

import '../../service/db_service.dart';

class ChapterViewModel extends ChangeNotifier {
  DBService dBService = DBService();
  late Future isInitCompleted;
  List<BattleContentListModel> _chapterList = [];
  List<BattleContentListModel> get chapterList => _chapterList;

  ChapterViewModel() {
    getData();
  }

  Future<void> getData() async {
    isInitCompleted = _fetchVolume();
  }

  Future<void> _fetchVolume() async {
    final data = await dBService.getChapters(1, 10);
    _chapterList = data;
    notifyListeners();
  }
}
