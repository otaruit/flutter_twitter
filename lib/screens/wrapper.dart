import 'package:flutter/widgets.dart';
import 'package:flutter_twitter/models/user.dart';
import 'package:flutter_twitter/screens/auth/signup.dart';
import 'package:flutter_twitter/screens/main/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return const SignUp();
    }
    return const Home();
  }
}
