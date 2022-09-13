import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageProvider {
  static Future<String> uploadImage({required File image}) async {
    final ref =
        FirebaseStorage.instance.ref("images/${UniqueKey().toString()}.png");
  }
}
