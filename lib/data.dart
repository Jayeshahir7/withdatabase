import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class database{
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'data.db');
    return await openDatabase(databasePath);
  }

// copy to root Function

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "data.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets', 'data.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }
  Future<List<Map<String,Object?>>> getData() async {
    Database db= await initDatabase();
    var data= await db.rawQuery("select * from mytable");
    print(data);
    return data;
  }

    Future<int> daleteData(int id) async {
    Database db=await initDatabase();
    var data= db.delete("mytable",where: "id=?",whereArgs: [id] );

    return data;
  }

    Future<int> insertData({name,spi}) async {
    Database db= await initDatabase();
    Map<String,Object?> map={};
    map['name']=name;
    map['spi']=spi;
    var data =db.insert("mytable", map);
    return data;
    }

  updateDate({name,spi,id}) async {
    Database db= await initDatabase();
    Map<String,Object?> map={};
    map['name']=name;
    map['spi']=spi;
    var data = db.update("mytable", map,where: "id=?",whereArgs: [id]);
    return data;
  }

}