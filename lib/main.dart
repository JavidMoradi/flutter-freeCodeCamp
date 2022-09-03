import 'package:crash_course/ui/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crash_course/ui/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // required for firebase's integration

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool bRedirect = (FirebaseAuth.instance.currentUser) != null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crash Course',
      home: bRedirect ? Home() : Authentication(),
    );
  }
}
