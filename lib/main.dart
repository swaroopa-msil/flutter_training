import 'package:flutter/material.dart';

import 'home/ui/screens/home_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 0, 85, 131),
  )
);

void main() {
  runApp( const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}
