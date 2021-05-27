import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ulkebayraklari_quiz/db/flagsDAO.dart';
import 'package:ulkebayraklari_quiz/flags/flags.dart';
import 'package:ulkebayraklari_quiz/screens/endScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var sorular = <Flags>[];
  var yanlisCevaplar = <Flags>[];
  Flags dogruSoru;
  var tumSecenekler = HashSet<Flags>(); //Seçenek yerlerini random değiştirir.

  int soruSayaci = 0;
  int dogruSayaci = 0;
  int yanlisSayaci = 0;

  String bayrakResimAdlari = "placeholder.png";
  String button1metin = "";
  String button2metin = "";
  String button3metin = "";
  String button4metin = "";

  @override
  void initState() {
    super.initState();
    sorulariAl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sorular"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Doğru Sayısı : ${dogruSayaci}"),
                Text("Yanlış Sayısı : ${yanlisSayaci}")
              ],
            ),
            soruSayaci != 15 ? Text("${soruSayaci + 1} .Soru") : Text("15.Soru"),
            Image.asset("img/${bayrakResimAdlari}"),
            Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(button1metin),
                  onPressed: () {
                    dogruKontrolu(button1metin);
                    soruSayacKontrolu();
                  },
                )),
            Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(button2metin),
                  onPressed: () {
                    dogruKontrolu(button2metin);
                    soruSayacKontrolu();
                  },
                )),
            Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(button3metin),
                  onPressed: () {
                    dogruKontrolu(button3metin);
                    soruSayacKontrolu();
                  },
                )),
            Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(button4metin),
                  onPressed: () {
                    dogruKontrolu(button4metin);
                    soruSayacKontrolu();
                  },
                )),
          ],
        ),
      ),
    );
  }

  Future<void> sorulariAl() async {
    sorular = await FlagsDAO().bayraklariGetir();
    soruEkle();
  }

  Future<void> soruEkle() async {
    dogruSoru = sorular[soruSayaci];
    bayrakResimAdlari = dogruSoru.bayrak_resim;
    yanlisCevaplar = await FlagsDAO().yanlisCevaplar(dogruSoru.bayrak_id);
    tumSecenekler.clear();
    tumSecenekler.add(dogruSoru);
    tumSecenekler.add(yanlisCevaplar[0]);
    tumSecenekler.add(yanlisCevaplar[1]);
    tumSecenekler.add(yanlisCevaplar[2]);
    button1metin = tumSecenekler.elementAt(0).bayrak_ad;
    button2metin = tumSecenekler.elementAt(1).bayrak_ad;
    button3metin = tumSecenekler.elementAt(2).bayrak_ad;
    button4metin = tumSecenekler.elementAt(3).bayrak_ad;

    setState(() {});
  }

  void soruSayacKontrolu() {
    soruSayaci++;
    if (soruSayaci != 15) {
      soruEkle();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EndScreen(
                    dogruSayisi: dogruSayaci,
                  )));
    }
  }

  void dogruKontrolu(String buttonMetin) {
    if (dogruSoru.bayrak_ad == buttonMetin) {
      dogruSayaci++;
    } else {
      yanlisSayaci++;
    }
  }
}
