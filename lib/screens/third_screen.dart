import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Screen C'),
            const SizedBox(height: 20),
            TextButton(onPressed: (){
              context.go('/home');
            }, child: const Text('Home'))
          ],
        ),
      ),
    );
  }
}