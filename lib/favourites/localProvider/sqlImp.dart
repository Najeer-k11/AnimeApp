import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
   Database? _db ;
   String dbname = 'anime.db' ;
   Database? get db=> _db ;

   void init() async {
      Directory directory = await getApplicationCacheDirectory();
      _db ??= await openDatabase(directory.path+dbname,version: 1,onCreate: (Database dbn,int version)async {
         dbn.execute(
            'CREATE TABLE Anime( id INTEGER PRIMARY KEY AUTOINCREMENT ,mal_id INTEGER , title TEXT NOT NULL , imageUrl TEXT NOT NULL )'
         );
      });
   }

}