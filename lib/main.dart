
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:march09/providers/data_List_change_provider.dart';
import 'package:march09/screens/home_screen.dart';
import 'package:march09/screens/watchlist_screen.dart';
import 'package:march09/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 0, 85, 131),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

final _rootNavKey = GlobalKey<NavigatorState>(debugLabel: 'root');

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => DataListChangeProvider() )
    ],
        child: MaterialApp.router(theme: theme, routerConfig: _router));
  }
}


final _router = GoRouter(
     initialLocation: '/watchlist',
    navigatorKey: _rootNavKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context,state,navigationShell){
          return  HomeScreen(navigationShell: navigationShell);
        },
          branches: [
            StatefulShellBranch(
                routes:<RouteBase>[
                  GoRoute(path: '/watchlist',
                    builder: (context,state){
                          return const Watchlist();
                    }
                  )
                ]),
            StatefulShellBranch(
                routes:<RouteBase>[
                  GoRoute(path: '/wishlist',
                      builder: (context,state){
                        return const Wishlist();
                      }
                  )
                ])
          ])
    ]

);
