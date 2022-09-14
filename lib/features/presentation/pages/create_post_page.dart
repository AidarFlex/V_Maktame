import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:vk_example/features/data/data_sources/firebase_storage_provider.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/presentation/cubit/post/post_cubit.dart';

class CreatePostPage extends StatefulWidget {
  static const id = 'create_post_page';
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final firebaseStorageProvider = FirebaseStorageProvider();
  final _formKey = GlobalKey<FormState>();
  late String _description;
  late String _imageUrl;

  Future<void> _submit({required File image}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String getImage() {
      FirebaseStorageProvider.uploadImage(image: image).then((value) {
        setState(() {
          _imageUrl = value;
        });
      });
      return _imageUrl;
    }

    _formKey.currentState!.save();

    BlocProvider.of<PostCubit>(context).createPost(
        postEntity: PostEntity(
            postID: FirebaseFirestore.instance.collection('posts').doc().id,
            userID: FirebaseAuth.instance.currentUser!.uid,
            userName: FirebaseAuth.instance.currentUser!.displayName!,
            timestamp: Timestamp.now(),
            imageUrl: getImage(),
            description: _description));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final File imageFile = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Image.file(imageFile, fit: BoxFit.cover),
            TextFormField(
              onSaved: (value) => _description = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide description";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'что то с чем то',
              ),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(image: imageFile),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
