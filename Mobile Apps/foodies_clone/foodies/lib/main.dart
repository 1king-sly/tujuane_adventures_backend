import 'package:flutter/material.dart';
import 'package:foodies/pages/intro_pages/intro_screens.dart';

void main() {
  runApp(const FoodiesApp());
}

class FoodiesApp extends StatelessWidget {
  const FoodiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodies',
      theme: _buildThemeData(),
      home: const IntroScreens(),
      debugShowCheckedModeBanner: false,
    );
  }
}

ThemeData _buildThemeData() {
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: _CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(), // iOS-style transition
      },
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFEFEFF)),
    useMaterial3: true,
  );
}

class _CustomPageTransitionBuilder extends PageTransitionsBuilder {
  const _CustomPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0), // Slide in from right
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut, // Smooth curve
      )),
      child: child,
    );
  }
}
