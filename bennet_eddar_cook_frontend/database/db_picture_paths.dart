import 'package:sqflite/sqflite.dart';
import 'dbhelper.dart';

class PicturesPathDB{
  static Future<List<Map<String, dynamic>>> getAllPicturesPaths() async {
    final Database  = await DBHelper.getDatabase();
    return Database.rawQuery('''SELECT 
            picture_paths.id,
            picture_paths.cookID,
            picture_paths.image
            from picture_paths
            ''');
  }

  
  static Future insertPicturePath(Map<String, dynamic> data) async {
   final database = await DBHelper.getDatabase();
   database.insert("picture_paths", data, conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future deletePicturePath(int id) async {
    final database = await DBHelper.getDatabase();
    database.rawQuery("""delete from  picture_paths where id=?""", [id]);
  }
    static Future<int> deleteAllpicturePaths() async {
    final Database db = await DBHelper.getDatabase();
    return await db.delete("picture_paths");
  }
}



