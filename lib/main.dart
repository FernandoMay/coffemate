import 'package:coffemate/home.dart';
import 'package:coffemate/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAETnXyEz8KHah6VkJK8KDBfxEuQNyVqPU",
    databaseURL: "https://approh-274c5.firebaseio.com",
    projectId: "approh-274c5",
    storageBucket: "approh-274c5.appspot.com",
    messagingSenderId: "121215789607",
    appId: "1:192908009452:android:57b8a17e32b898e8892ac9",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CoffeMate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF795548)),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData &&
                FirebaseAuth.instance.currentUser != null) {
              return const Home();
            } else {
              return const Login();
            }
          },
        ));
  }
}
