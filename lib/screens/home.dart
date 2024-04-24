import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              context.pushNamed('/first',pathParameters: {'name':'A'});
            }, child: const Text('Screen A')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              context.pushNamed('/second');
            }, child: const Text('Screen B'))
          ],
        ),
      ),
    );
  }
}
