import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Centered logo
          Center(
            child: Image.asset(
              'assets/images/icon.png',
              height: 150,
              width: 150,
            ),
          ),
          // Positioned Text at the bottom center
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: const Text(
              'Quiz App',
              textAlign: TextAlign.center, // Center-align the text
              style: TextStyle(
                color: Color(0xff3E2723),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
