import 'package:sqflite/sqflite.dart';

import '../database/db_helper.dart';
import '../database/model/battle_content_model.dart';
import '../database/model/battle_name_model.dart';

class DBService {
  // Future<List<SahihBukhariModel>> getFavourites() async {
  //   Database db = await HadithDatabaseHelper.instance.database;
  //   final result = await db.query(SahihBukhariTable,
  //       where: 'flag = ?',
  //       whereArgs: [1],
  //       orderBy: "volume_id ASC, bookId ASC, hadith_id ASC");

  //   return result.map((json) => SahihBukhariModel.fromJson(json)).toList();
  // }

  // Future<int> favoriteAction(int flagValue, int id) async {
  //   Database db = await HadithDatabaseHelper.instance.database;
  //   return await db.update(
  //     SahihBukhariTable,
  //     {'flag': flagValue},
  //     where: '_id = ?',
  //     whereArgs: [id],
  //   );
  // }

  Future<bool> bookmarkAction(
      {required int id, required int bookmarkId}) async {
    Database db = await DatabaseHelper.instance.database;

    return await db.transaction<bool>((txn) async {
      final b = await txn.update(
        nameTable,
        {BattleNameFields.openPage: bookmarkId},
        where: '${BattleNameFields.id} = ?',
        whereArgs: [id],
      );

      return b > 0;
    });
  }

  // Future<bool> removeBookmark(int vol, int bookId) async {
  //   Database db = await HadithDatabaseHelper.instance.database;

  //   final b = await db.update(
  //     ChapterTable,
  //     {ChapterFields.bookmarkHadithId: 0},
  //     where: '_id = ?',
  //     whereArgs: [bookId],
  //   );

  //   final volResult = await db.query(
  //     ChapterTable,
  //     where:
  //         '${ChapterFields.volume} = ? AND ${ChapterFields.bookmarkHadithId} > 0',
  //     whereArgs: [vol],
  //   );

  //   int a;

  //   if (volResult.isEmpty) {
  //     a = await db.update(
  //       volumeTable,
  //       {VolumeFields.flag: 0},
  //       where: '_id = ?',
  //       whereArgs: [vol],
  //     );
  //   } else {
  //     a = 1;
  //   }

  //   return a > 0 && b > 0;
  // }

  Future<List<BattleNameModel>> getStory() async {
    List<BattleNameModel> r = [];
    try {
      final Database db = await DatabaseHelper.instance.database;

      final result =
          await db.query(nameTable, orderBy: "${BattleNameFields.id} ASC");

      r = result.map((json) => BattleNameModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
    }
    return r;
  }

  Future<List<BattleContentListModel>> getChapters(
      int startIndex, int totalVolCount) async {
    int vol = startIndex;
    List<BattleContentListModel> chapters = [];
    final Database db = await DatabaseHelper.instance.database;

    for (vol; vol <= totalVolCount; vol++) {
      final result = await db.query(contentTable,
          where: '${BattleContentFields.storyid} = ?',
          whereArgs: [vol],
          orderBy: "${BattleContentFields.pageNumber} ASC");

      chapters.add(BattleContentListModel(
          contentNum: vol,
          contents: result
              .map((json) => BattleContentModel.fromJson(json))
              .toList()));
    }
    return chapters;
  }

  // Future<List<SahihBukhariListModel>> getHadithList(
  //     int vol, int startIndex, int totalCount) async {
  //   List<SahihBukhariListModel> hadithList = [];
  //   final Database db = await HadithDatabaseHelper.instance.database;
  //   for (int index = startIndex;
  //       index <= (startIndex + totalCount - 1);
  //       index++) {
  //     final result = await db.query(
  //       SahihBukhariTable,
  //       where: 'volume_id = ? and bookId = ?',
  //       whereArgs: [vol, index],
  //       orderBy: "hadith_id ASC",
  //     );

  //     hadithList.add(SahihBukhariListModel(
  //         bookNum: index,
  //         hadithList:
  //             result.map((json) => SahihBukhariModel.fromJson(json)).toList()));
  //   }
  //   return hadithList;
  // }

  // Future<List<NarratorsModel>> getNarrators() async {
  //   final Database db = await HadithDatabaseHelper.instance.database;
  //   final result = await db.rawQuery(
  //       "SELECT substr(REPLACE(heading, '''', ''), length('Narrated By') + 1) AS narrator_name, COUNT(*) AS hadith_count FROM $narratorsTable GROUP BY narrator_name");

  //   return result.map((json) => NarratorsModel.fromJson(json)).toList();
  // }

  // Future<List<SahihBukhariModel>> getNarratorHadithList(String narrator) async {
  //   final Database db = await HadithDatabaseHelper.instance.database;
  //   final result = await db.query(
  //     SahihBukhariTable,
  //     where:
  //         "substr(REPLACE(heading, '''', ''), length('Narrated By') + 1) = ?",
  //     whereArgs: [narrator],
  //     orderBy: "_id ASC",
  //   );
  //   // final result = await db.rawQuery(
  //   //     "SELECT * FROM $SahihBukhariTable where substr(heading, length('Narrated By') + 1) = $narrator");

  //   return result.map((json) => SahihBukhariModel.fromJson(json)).toList();
  // }

  // Future<List<SahihBukhariModel>> getSearch(String query) async {
  //   final Database db = await HadithDatabaseHelper.instance.database;
  //   // final result = await db.query(
  //   //   SahihBukhariTable,
  //   //   where: "${SahihBukhariFields.fullText} like ?",
  //   //   whereArgs: ['%$query%'],
  //   // );
  //   final result = await db.query(
  //     SahihBukhariTable,
  //     where: "INSTR(LOWER(${SahihBukhariFields.fullText}), ?)>0",
  //     whereArgs: [query],
  //   );

  //   return result.map((json) => SahihBukhariModel.fromJson(json)).toList();
  // }
}
