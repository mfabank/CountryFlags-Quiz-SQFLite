import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final String veritabaniAdi = "flags.db";

  static Future <Database> veriTabaniErisimi() async {
    String veriTabaniYolu = join(await getDatabasesPath(), veritabaniAdi);

    if (await databaseExists(veriTabaniYolu)) {
      print("Veri tabanı zaten mevcut.");
    }
    else {
      ByteData data = await rootBundle.load("database/$veritabaniAdi");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veriTabaniYolu).writeAsBytes(bytes,flush: true);
      print("Veri Tabanı Kopyalama İşlemi Başarılı...");
    }
    return openDatabase(veriTabaniYolu);
  }
}