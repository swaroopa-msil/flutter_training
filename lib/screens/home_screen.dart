import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTapCall(int index){
    navigationShell.goBranch(index,initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Watchlist'),
          BottomNavigationBarItem(icon: Icon(Icons.cases),label: 'WishList')
        ],
        onTap: _onTapCall,
      ),
    );
  }
}

