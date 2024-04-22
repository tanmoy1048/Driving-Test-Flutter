import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('sqlite.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    var databasesPath = await getDatabasesPath();
    final path = join(databasesPath, filepath);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      if (kDebugMode) {
        print("Creating new copy from asset");
      }

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }

      ByteData data =
          await rootBundle.load(url.join("assets", "db", "sqlite.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }
}
