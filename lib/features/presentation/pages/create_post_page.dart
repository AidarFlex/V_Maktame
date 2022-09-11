import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:vk_example/features/data/data_sources/firebase_storage_provider.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/presentation/cubit/post/post_cubit.dart';

final _scafflodState = GlobalKey<ScaffoldState>();

class CreatePostPage extends StatefulWidget {
  static const id = 'create_post_page';
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final firebaseStorageProvider = FirebaseStorageProvider();
  final _formKey = GlobalKey<FormState>();
  String _description = '';

  Future<void> _submit({required File image}) async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    late String imageUrl;
    await firebaseStorage
        .ref('image/${UniqueKey().toString()}.png')
        .putFile(image)
        .then((taskSnapshot) async {
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    });

    BlocProvider.of<PostCubit>(context).createPost(
        postEntity: PostEntity(
            postID: FirebaseFirestore.instance.collection('posts').doc().id,
            userID: FirebaseAuth.instance.currentUser!.uid,
            userName: FirebaseAuth.instance.currentUser!.displayName!,
            timestamp: Timestamp.now(),
            imageUrl: imageUrl,
            description: _description));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final File imageFile = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      key: _scafflodState,
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
