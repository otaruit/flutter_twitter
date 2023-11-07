import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter/models/user.dart';
import 'package:flutter_twitter/services/utils.dart';

class UserService {
  UtilsService _utilsService = UtilsService();

  UserModel _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return snapshot != null
        ? UserModel(
            id: data['id'] ?? '',
            profileImageUrl: data['profileImageUrl'],
            name: data['name'] ?? '',
            email: data['email'] ?? '',
            bannerImageUrl: data['bannerImageUrl'] ?? '')
        : null;
  }

  Stream<UserModel> getUserInfo(uid, {required initialData}) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }

  Future<void> updateProfile(
      File _bannerImage, File _profileImage, String name) async {
    String bannerImageUrl = '';
    String profileImageUrl = '';

    if (_bannerImage != null) {
      bannerImageUrl = await _utilsService.uploadFile(_bannerImage,
          'user/profile/${FirebaseAuth.instance.currentUser?.uid}/banner.jpg');
    }

    if (_profileImage != null) {
      profileImageUrl = await _utilsService.uploadFile(_profileImage,
          'user/profile/${FirebaseAuth.instance.currentUser?.uid}/profile.jpg');
    }
    Map<String, Object> data = HashMap();
    if (name != '') data['name'] = name;
    if (bannerImageUrl != '') data['bannerImageUrl'] = bannerImageUrl;
    if (profileImageUrl != '') data['profileImageUrl'] = profileImageUrl;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(data);
  }
}
