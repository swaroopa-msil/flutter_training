import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:march09/bloc/movie_bloc.dart';
import 'package:march09/bloc/bloc_provider.dart';
import 'package:march09/screens/movie_home_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 12, 42, 87),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {

    return    BlocProvider(widgetObject: MaterialApp(
          theme: theme,
          home:  const MovieHomeScreen() ),
              blocObject: MovieBloc());
  }
}
