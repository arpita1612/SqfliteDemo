import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseClass {
  static final databasename = "product.db";
  static final tablename = "tablename";
  static final databaseversion = 1;
  static final id = "ID";
  static final name = "Name";
  static final contact = "Contact";
  static final email = "Email";
  static final password = "Password";

  static Database database;

  DataBaseClass._privateConstructor();
  static final DataBaseClass instance = DataBaseClass._privateConstructor();

  Future<Database> get getDatabase async {
    if (database != null) return database;

    database = await createDatabase();
    return database;
  }

  createDatabase() async {
    Directory documentdirecoty = await getApplicationDocumentsDirectory();
    String path = join(documentdirecoty.path, databasename);
    return await openDatabase(path,
        version: databaseversion, onCreate: onCreateDb);
  }

  // create a database since it doesn't exist
  Future onCreateDb(Database db, int version) async {
    // sql code
    await db.execute('''
      CREATE TABLE $tablename (
        $id INTEGER PRIMARY KEY,
        $name TEXT NOT NULL,
        $email TEXT NOT NULL,
        $password TEXT NOT NULL,
        $contact INTEGER NOT NULL
      )
      ''');
  }

  /// Functions to insert data
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.getDatabase;
    return await db.insert(tablename, row);
  }

  // // function to query all the rows
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.getDatabase;
    return await db.query(tablename);
  }

  // function to queryspecific
  Future<List<Map<String, dynamic>>> queryspecific(
      String email, String pass) async {
    Database db = await instance.getDatabase;
    var res = await db.rawQuery(
        'SELECT * FROM $tablename WHERE Email = ? AND Password = ?',
        [email, pass]);
    return res;
  }

  // function to delete some data
  Future<int> deletedata(int id) async {
    Database db = await instance.getDatabase;
    var res = await db.delete(tablename, where: "id = ?", whereArgs: [id]);
    return res;
  }

  // function to update some data
  Future<int> update(int id) async {
    Database db = await instance.getDatabase;
    var res = await db.update(
        tablename, {"name": "Arpita Devargaonkar", "contact": 8974563214},
        where: "id = ?", whereArgs: [id]);
    return res;
  }
}
