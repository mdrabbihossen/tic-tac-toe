import 'package:flutter/material.dart';
import 'package:tic_tae_toe/pages/screens/game_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
