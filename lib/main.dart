import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march09/screen/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:march09/screen/chat_screen.dart';
import 'package:march09/screen/splash_screen.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 29, 101, 38),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  void setUpPushNotification() async{
    final fcm =  FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    setUpPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme,
        title: 'FlutterChat',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const SplashScreen();
            }
               if(snapshot.hasData){
                  return const ChatScreen();
               }
               return const AuthenticationScreen();
            },
        ));
  }
}
