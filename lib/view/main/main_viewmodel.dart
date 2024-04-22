import 'package:flutter/material.dart';

import '../../database/model/battle_name_model.dart';
import '../../service/db_service.dart';

class MainViewModel extends ChangeNotifier {
  DBService dBService = DBService();
  late Future isInitCompleted;
  List<BattleNameModel> _names = [];
  List<BattleNameModel> get names => _names;

  MainViewModel() {
    getData();
  }

  Future<void> getData() async {
    isInitCompleted = _fetchVolume();
  }

  Future<void> _fetchVolume() async {
    final data = await dBService.getStory();

    _names = data;
    notifyListeners();
  }

  Future<bool> bookmarkAction(
      {required int bookmarkId, required int id, required int index}) async {
    final data = await dBService.bookmarkAction(bookmarkId: bookmarkId, id: id);
    _names[index].openPage = bookmarkId;
    notifyListeners();
    return data;
  }
}
