import 'package:sqflite/sqflite.dart';
import 'dbhelper.dart';

class PicturesDB{
  static Future<List<Map<String, dynamic>>> getAllPictures() async {
    final Database  = await DBHelper.getDatabase();
    return Database.rawQuery('''SELECT 
            pictures.id,
            pictures.name,
            pictures.cookID,
            pictures.image
            from pictures
            ''');
  }

  
  static Future insertPicture(Map<String, dynamic> data) async {
   final database = await DBHelper.getDatabase();
   database.insert("pictures", data, conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future deletePicture(String name) async {
    final database = await DBHelper.getDatabase();
    database.rawQuery("""delete from  pictures where name=?""", [name]);
    print('deleted from local db');
  }
  static Future<bool> deleteAllPictures() async {
  try {
    final Database db = await DBHelper.getDatabase();

    int? countBeforeDeletion = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM pictures'));

    int rowsAffected = await db.delete("pictures");

    int? countAfterDeletion = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM pictures'));

    bool isSuccess = rowsAffected == countBeforeDeletion && countAfterDeletion == 0;

    return isSuccess;
  } catch (e) {
    print("Error deleting pictures: $e");
    return false;
  }
}

}



