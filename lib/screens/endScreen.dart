import 'package:flutter/material.dart';

class EndScreen extends StatefulWidget {
  int dogruSayisi;
  EndScreen({this.dogruSayisi});
  @override
  _EndScreenState createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonuç"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.dogruSayisi} Doğru ${15-widget.dogruSayisi} Yanlış"),
            Text("%${((widget.dogruSayisi*100)/15).toInt()} Başarı",style: TextStyle(color: Colors.red,fontSize: 30),),
            ElevatedButton(child: Text("Tekrar Deneyin"),onPressed: () {
              Navigator.pop(context);
            },),
          ],
        ),
      ),
    );
  }
}
