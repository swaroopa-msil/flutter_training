import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:march09/home/provider/widget_data_provider.dart';
import 'package:provider/provider.dart';

import 'home/ui/home_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 255, 255, 255),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const  App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => WidgetDataProvider())
    ],
    child: MaterialApp(theme: theme,
        home: HomeScreen())
    );
  }
}
