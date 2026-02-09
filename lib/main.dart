import 'package:flutter/material.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(const PassKeep());
}

class PassKeep extends StatelessWidget {
  const PassKeep({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(
          context,
        ).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        scaffoldBackgroundColor: Color.fromARGB(255, 18, 18, 18),
      ),

      home: Homescreen(),
    );
  }
}
