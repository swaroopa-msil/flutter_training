import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/screens/first_screen.dart';
import 'package:march09/screens/home.dart';
import 'package:march09/screens/second_screen.dart';
import 'package:march09/screens/third_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
         theme: theme,
        routerConfig: _router,
    );
  }
}

// can use onGenerateRoute instead.
/* onGenerateRoute: (settings) {
        switch (settings.name) {
          case FirstScreen.route:
            return MaterialPageRoute(builder: (_) => FirstScreen(settings.arguments));
            break;
          case SecondScreen.route:
            return MaterialPageRoute(builder: (_) => SecondScreen());
            break;
          default:
            return MaterialPageRoute(builder: (_) => HomeScreen());
        }
      }
 */

final _router = GoRouter(initialLocation: '/home', routes: [
  GoRoute(
      path: '/home',
      name: '/home',
      builder: (context, state) => const HomeScreen()),
  GoRoute(
      path: '/first/:name',
      name: '/first',
      builder: (context, state) {
        final String name = state.pathParameters['name'] ?? '';
        return FirstScreen(name: name);
      }),
  GoRoute(
      path: '/second',
      name: '/second',
      builder: (context, state) => const SecondScreen(),
      routes: <RouteBase>[
        GoRoute(
            path: 'third',
            name: 'third',
            builder: (context, state) => const ThirdScreen()),
      ]),
]);
