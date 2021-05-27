
import 'package:ulkebayraklari_quiz/db/dbHelper.dart';
import 'package:ulkebayraklari_quiz/flags/flags.dart';

class FlagsDAO {

  Future<List<Flags>> bayraklariGetir() async {
    var db = await DBHelper.veriTabaniErisimi();

    List<Map<String,dynamic>> maps = await db.rawQuery("Select * From Bayraklar order by random() limit 15");

    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return Flags(satir["bayrak_id"], satir["bayrak_ad"], satir["bayrak_resim"]);
    });

  }
  Future<List<Flags>> yanlisCevaplar(int bayrak_id) async {
    var db = await DBHelper.veriTabaniErisimi();
    List<Map<String,dynamic>> maps = await db.rawQuery("Select * From Bayraklar Where bayrak_id != $bayrak_id order by random() limit 3");

    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return Flags(satir["bayrak_id"], satir["bayrak_ad"], satir["bayrak_resim"]);
    });

  }


}