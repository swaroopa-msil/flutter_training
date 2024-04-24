import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key,required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('Screen $name'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              context.pushNamed('/second');
            }, child: const Text('Screen B')),
            const SizedBox(height: 20),
            TextButton(onPressed: (){
              context.pop();
            }, child: const Text('Back'))
          ],
        ),
      ),
    );
  }
}