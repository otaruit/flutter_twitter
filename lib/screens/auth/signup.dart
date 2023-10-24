import 'package:flutter/material.dart';
import 'package:flutter_twitter/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _authService = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8,
        title: const Text("Sign up"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              onChanged: (val) => setState(() {
                email = val;
              }),
            ),
            TextFormField(
              onChanged: (val) => setState(() {
                password = val;
              }),
            ),
            ElevatedButton(
                onPressed: () async => {_authService.signUp(email, password)},
                child: const Text('Sign up')),
            ElevatedButton(
                onPressed: () async => {_authService.signIn(email, password)},
                child: const Text('Sign in'))
          ],
        )),
      ),
    );
  }
}
