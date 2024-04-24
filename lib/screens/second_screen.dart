import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Screen B'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              context.pushNamed('/first',pathParameters: {'name':'A'});
            }, child: const Text('Screen A')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              context.goNamed('third');
            }, child: const Text('Screen C')),
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

/*
    Navigator.pushNamed(
    context,
    FirstScreen.route,
    arguments: {'name':'A'},
    );
   */