import 'package:flutter/material.dart';
import 'package:flutter_twitter/firebase_options.dart';
import 'package:flutter_twitter/models/user.dart';
import 'package:flutter_twitter/screens/wrapper.dart';
import 'package:flutter_twitter/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserModel?>.value(
            value: AuthService().user,
            initialData: null,
            child: const MaterialApp(home: Wrapper()),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Text("Loading");
      },
    );
  }
}
