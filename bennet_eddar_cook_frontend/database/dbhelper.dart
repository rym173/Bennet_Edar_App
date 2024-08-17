import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _database_name = "BennetEddar.db";
  static const _database_version = 4;
  static Database? database;

  static Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }
    database = await openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE pictures (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            cookID INTEGER,
            image BLOB
          )
        ''');
        await database.execute('''
          CREATE TABLE picture_paths (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            cookID INTEGER,
            image TEXT
          )
        ''');
      },
      version: _database_version,
      onUpgrade: (db, oldVersion, newVersion) {},
    );
    return database!;
  }
}
