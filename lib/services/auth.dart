import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter/models/user.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user) {
    // null安全のために User? を受け入れるように変更
    if (user != null) {
      return UserModel(id: user.uid);
    }
    return null; // ユーザーがnullの場合はnullを返す
  }

  Stream<UserModel?> get user {
    return auth.authStateChanges().map((user) => _userFromFirebaseUser(user));
  }

  Future signUp(email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        _userFromFirebaseUser(user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signIn(email, password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        _userFromFirebaseUser(user);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
