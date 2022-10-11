import 'package:coffemate/constants.dart';
import 'package:coffemate/home.dart';
import 'package:coffemate/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

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
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'coffemate',
        theme: const CupertinoThemeData(primaryColor: secondaryColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // throw Exception('Failed to load data from API ${snapshot.error}');
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoPageScaffold(
                child: Center(
                  child: CupertinoActivityIndicator(
                    color: secondaryColor,
                  ),
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
