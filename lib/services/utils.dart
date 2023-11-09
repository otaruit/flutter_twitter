import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class UtilsService {
  Future<String> uploadFile(
      File _image, String path, String contentType) async {
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref(path);

    final metadata = firebase_storage.SettableMetadata(
      contentType: contentType,
    );

    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(_image, metadata);

    await uploadTask.whenComplete(() => debugPrint('File uploaded'));
    String returnURL = '';
    await storageReference
        .getDownloadURL()
        .then((fileURL) => returnURL = fileURL);
    return returnURL;
  }
}
