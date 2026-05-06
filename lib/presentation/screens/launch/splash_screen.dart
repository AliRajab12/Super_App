import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A simple splash screen to be shown while initializing the app
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'orgLogo',
          child: Lottie.asset('images/lottie/SuperApp1.json'),
        ),
      ),
    );
  }
}
