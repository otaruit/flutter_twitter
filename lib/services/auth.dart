import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter/models/user.dart';
import 'package:flutter_twitter/services/user.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            id: user.uid,
            bannerImageUrl: '',
            profileImageUrl: '',
            name: '',
            email: '')
        : null;
  }

  // UserServiceを使って_userFromFirebaseSnapshotメソッドを呼び出す
  UserModel? _userFromFirebaseSnapshot(User? user) {
    if (user != null) {
      UserService _userService = UserService();
      // UserServiceから_userFromFirebaseSnapshotを呼び出し、UserオブジェクトからUserModelを取得
      return _userService
          .userFromFirebaseSnapshot(user as DocumentSnapshot<Object?>);
    }
    return null;
  }

  Stream<UserModel?> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signUp(email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .set({'name': email, 'email': email});
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
      UserService _userService = UserService();

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      // _userFromFirebaseSnapshotメソッドを使ってUserModelを取得
      UserModel? userModel = _userFromFirebaseSnapshot(user);

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
