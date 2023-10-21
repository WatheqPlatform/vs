import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/StartBackground.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Color.fromARGB(141, 2, 74, 141),
        ),
      ),
    );
  }
}