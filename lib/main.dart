import 'package:flutter/material.dart';

import 'expression_evaluator_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 87, 24, 35),
  ),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: const ExpressionEvaluatorScreen());
  }
}
