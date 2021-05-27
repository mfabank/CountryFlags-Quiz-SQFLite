import 'package:flutter/material.dart';
import 'package:ulkebayraklari_quiz/screens/quizScreen.dart';

void main () {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData.dark(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ülke Bayrakları Quiz"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Başlamak İçin Butona Dokunun"),
            SizedBox(height: 20),
            ElevatedButton(child: Text("BAŞLA"),onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
            },),
          ],
        ),
      ),
    );
  }
}
