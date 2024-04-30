import 'package:flutter/material.dart';
import 'package:march09/screens/watchlist_screen.dart';
import 'package:march09/screens/wishlist_screen.dart';

import '../utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;

  final List<Widget> _screenWidget = <Widget>[
    const Watchlist(),
    const Wishlist()
  ];

  void _onTapCall(int index){
     setState(() {
       _selectedIndex = index;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items:  [
          BottomNavigationBarItem(icon: const Icon(Icons.home_filled),label: AppConstants.watchListLabel),
          BottomNavigationBarItem(icon: const Icon(Icons.cases),label: AppConstants.wishListLabel)
        ],
        onTap: _onTapCall,
      ),
    );
  }
}

