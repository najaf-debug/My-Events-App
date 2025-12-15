import 'package:flutter/material.dart';
import 'package:my_events_app/features/authentication/authentication%20screens/login.dart';
import 'package:my_events_app/features/authentication/authentication%20screens/sign_up.dart';
import 'package:my_events_app/practice/repository/auth_provider.dart';
import 'package:my_events_app/practice/repository/auth_repository.dart';
import 'package:my_events_app/views/splash_screen.dart';
import 'package:my_events_app/widgets/my_nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(AuthRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignUp(),
        '/myNavBar': (_) => const MyNavBar(),
      },
    );
  }
}
