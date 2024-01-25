
import 'dart:io';

import 'package:animecrunch/favourites/localProvider/sqlImp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/item.dart';

class LocalData {

  Database? _db ;
  String dbname = 'anime.db' ;

  Future<Database?> init() async {
    Directory directory = await getApplicationCacheDirectory();
    _db = await openDatabase(directory.path+dbname,
        version: 1,
        onCreate: (Database dbn,int version)async {
          dbn.execute(
              'CREATE TABLE Anime( id INTEGER PRIMARY KEY AUTOINCREMENT ,mal_id INTEGER , title TEXT NOT NULL , imageUrl TEXT NOT NULL )'
          );
        });
    return _db;
  }
  
  Future<List<Item>> getLocal() async {
    List<Item> values = [];
    final db = await LocalData().init();
    List<Map<String, Object?>>? data = await db?.query('Anime');
    for(int i=0; i < data!.length ; i++){
      values.add(Item.fromLocal(data[i]));
    }
    return values;
  }
  
  Future<void> deleteItem(Item item) async {
    final db = await LocalData().init();
    db?.delete('Anime',where: 'mal_id = ?',whereArgs: [item.id]);
  }

  Future<void> insertItem(Item item) async {
    final db = await LocalData().init();
    db?.insert('Anime', item.toMap(item));
  }
}