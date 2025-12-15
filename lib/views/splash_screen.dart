import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_events_app/features/authentication/authentication%20screens/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(child: Lottie.asset('assets/images/animation_cal.json')),
      nextScreen: LoginScreen(),
      splashIconSize: 300,
      duration: 4000,
    );
  }
}
