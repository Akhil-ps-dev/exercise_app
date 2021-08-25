//@dart=2.9
import 'package:fitness_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: OnBoardingScreen(),
      theme: ThemeData(appBarTheme: AppBarTheme(color: Color(0XFF192A56))),
    );
  }
}
