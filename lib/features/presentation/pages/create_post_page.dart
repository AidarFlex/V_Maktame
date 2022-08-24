import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/features/data/data_sources/firebase_storage_provider.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/presentation/cubit/post/post_cubit.dart';
import 'package:vk_example/features/presentation/widgets/common.dart';

final _scafflodState = GlobalKey<ScaffoldState>();

class CreatePostPage extends StatefulWidget {
  static const id = 'create_post_page';
  final String postId;
  const CreatePostPage({Key? key, required this.postId}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final firebaseStorageProvider = FirebaseStorageProvider();
  final _descriptionController = TextEditingController();

  Future<void> _submit({required File image}) async {
    FocusScope.of(context).unfocus();

    if (_descriptionController.text.isEmpty) {
      toast('enter description');
      return;
    }

    BlocProvider.of<PostCubit>(context).createPost(
        postEntity: PostEntity(
            postId: FirebaseFirestore.instance.doc('post').id,
            userId: FirebaseAuth.instance.currentUser!.uid,
            userName: FirebaseAuth.instance.currentUser!.displayName!,
            timestamp: Timestamp.now(),
            imageURL:
                firebaseStorageProvider.uploadImage(image: image).toString(),
            description: _descriptionController.text));

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final File imageFile = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      key: _scafflodState,
      appBar: AppBar(
        title: const Text('Create Post'),
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
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'что то с чем то',
                  ),
                  textInputAction: TextInputAction.done,
                  inputFormatters: [LengthLimitingTextInputFormatter(150)],
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
