import 'package:flutter/material.dart';
import 'package:flutter_twitter/models/user.dart';
import 'package:flutter_twitter/screens/auth/signup.dart';
import 'package:flutter_twitter/screens/main/home.dart';
import 'package:flutter_twitter/screens/main/posts/add.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    print(user);
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return const SignUp();
    }

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const Add()
      },
    );

  }
}
