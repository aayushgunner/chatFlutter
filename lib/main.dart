import 'package:flutter/material.dart';
import 'package:newchat/auth/auth_gate.dart';
import 'package:newchat/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newchat/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: lightMode,
    );
  }
}
