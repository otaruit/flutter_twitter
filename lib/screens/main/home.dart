import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_twitter/services/auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Scaffold(
        appBar: AppBar(
      title: const Text("Home"),
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: () async {
            _authService.signOut();
          },
          icon: Icon(
            // <-- Icon
            Icons.person,
            size: 24.0,
          ),
          label: Text('SignOut'), // <-- Text
        ),
      ],
    ));
  }
}
