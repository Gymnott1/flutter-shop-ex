import 'package:flutter/material.dart';
import 'login_signup_page.dart';
import 'home_page.dart';
import 'forgot_password_page.dart';
import 'theme/app_theme.dart';

final GlobalKey<_MyAppState> myAppKey = GlobalKey();

void main() {
  runApp(MyApp(key: myAppKey));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light; // Renamed from _themeMode (now public)

  void changeTheme(ThemeMode newThemeMode) { // Parameter renamed for clarity
    setState(() {
      themeMode = newThemeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazons Mock App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode, // Use the public themeMode
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginSignupPage(),
        '/home': (context) => const HomePage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
      },
    );
  }
}