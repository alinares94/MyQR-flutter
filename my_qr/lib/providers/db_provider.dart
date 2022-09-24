import 'dart:io';

import 'package:my_qr/models/scan_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  static Database? _dataBase;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get dataBase async {
    if (_dataBase != null) {
      return _dataBase!;
    }

    _dataBase = await initAsync();
    return _dataBase!;
  }

  Future<Database> initAsync() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'myQR.db3');

    return await openDatabase(path, version: 1,
    onOpen: (db){},
    onCreate: (Database db, int version) async {
      await db.execute(''' 
        create table Scans (
          id integer primary key,
          value text null,
          latitude double null,
          longitude double null,
          name text null,
          description text null,
          date text null
        )
      ''');
    });
  }

  Future<int> addScanModel( ScanModel model) async {

    final db = await dataBase;
    final res = await db.insert('Scans', model.toJson());
    return res;
  }

  Future<ScanModel> getScanModelById( int id ) async {

    final db = await dataBase;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return ScanModel.fromJson(res.first);
  }

  Future<List<ScanModel>> getAllScanModel() async {

    final db = await dataBase;
    final res = await db.query('Scans');
    return res.isEmpty ? [] : res.map((e) => ScanModel.fromJson(e)).toList();
  }

  Future<int> updateScanModel(ScanModel model) async {

    final db = await dataBase;
    final res = await db.update(
      'Scans', 
      model.toJson(), 
      where: 'id = ?', 
      whereArgs: [model.id]
    );
    return res;
  }

  Future<int> deleteById(int id) async {

    final db = await dataBase;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteTable() async {

    final db = await dataBase;
    final res = await db.delete('Scans');
    return res;
  }
}