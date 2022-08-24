import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageProvider {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late final String imageUrl;

  Future<String> uploadImage({required File image}) async {
    await _storage
        .ref("images/${UniqueKey().toString()}.png")
        .putFile(image)
        .then((taskSnapshot) async {
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    });
    return imageUrl;
  }
}
