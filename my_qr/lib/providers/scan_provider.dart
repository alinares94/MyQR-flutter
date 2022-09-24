import 'package:flutter/material.dart';
import 'package:my_qr/models/models.dart';
import 'package:my_qr/providers/providers.dart';

class ScanProvider extends ChangeNotifier {
  
  List<ScanModel> scans = [];

  Future<ScanModel> addScan( String scanValue ) async {
    final nuevoScan = ScanModel(value: scanValue);
    nuevoScan.id = await DbProvider.db.addScanModel(nuevoScan);
    
    await loadScans();
    notifyListeners();

    return nuevoScan;
  }

  loadScans() async {
    final dbScans = await DbProvider.db.getAllScanModel();
    scans = [...dbScans];
    notifyListeners();
  }

  deleteScans() async {
    await DbProvider.db.deleteTable();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DbProvider.db.deleteById(id);
  }
}