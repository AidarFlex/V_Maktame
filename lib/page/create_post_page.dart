import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';

class CreatePostPage extends StatefulWidget {
  static const id = 'create_post_page';
  CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  String _description = '';

  Future<void> _submit({required File image}) async {
    FocusScope.of(context).unfocus();
    if (_description.trim().isNotEmpty) {
      late String imageUrl;
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;

      await storage
          .ref("images/${UniqueKey().toString()}.png")
          .putFile(image)
          .then((taskSnapshot) async {
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      });

      FirebaseFirestore.instance.collection("posts").add({
        'timestamp': Timestamp.now(),
        'userID': FirebaseAuth.instance.currentUser!.uid,
        'description': _description,
        'userName': FirebaseAuth.instance.currentUser!.displayName,
        'imageUrl': imageUrl,
      }).then((docRef) => docRef.update({'postID': docRef.id}));

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final File imageFile = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(imageFile),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'что то с чем то',
                  ),
                  textInputAction: TextInputAction.done,
                  inputFormatters: [LengthLimitingTextInputFormatter(150)],
                  onChanged: (value) {
                    _description = value;
                  },
                  onEditingComplete: () {
                    _submit(image: imageFile);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
