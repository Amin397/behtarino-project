import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../Screens/Calendar/Model/day_calendar_model.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'files.db');
    print(documentsDirectory.path);
    return await openDatabase(
      path,
      version: 4,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE files(myId INTEGER PRIMARY KEY AUTOINCREMENT, time TEXT, alarms TEXT)"
        //     'CREATE TABLE files (id INTEGER PRIMARY KEY, fileId TEXT, filePath TEXT, size TEXT)'

        );
  }

  Future<List<DayCalendarModel>> getFiles() async {
    Database db = await instance.database;
    var files = await db.query('files', orderBy: 'myId');
    List<DayCalendarModel> filesList = files.isNotEmpty
        ? files
            .map((c) => DayCalendarModel.fromJson(
                jsonDecode(c.toString().replaceAll('=', ':'))))
            .toList()
        : [];
    return filesList;
  }

  Future<int> add(DayCalendarModel file) async {
    Database db = await instance.database;
    return await db.insert('files', file.toMap());
  }

  Future<int> delete({List<dynamic>? whereArgs}) async {
    Database db = await instance.database;
    return db.rawDelete(
      'DELETE FROM files WHERE fileId = ?',
      whereArgs,
    );
  }
}
