import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:vk_example/features/data/data_sources/firebase_storage_provider.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/presentation/cubit/post/post_cubit.dart';
import 'package:vk_example/features/presentation/widgets/common.dart';
import 'package:vk_example/features/presentation/widgets/image_widget.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final firebaseStorageProvider = FirebaseStorageProvider();
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  late String _imageUrl;
  File? _image;

  Future<void> getImage() async {
    try {
      final picker = ImagePicker();
      final XFile? xFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        if (xFile != null) {
          _image = File(xFile.path);
          FirebaseStorageProvider.uploadImage(image: _image!).then((value) {
            setState(() {
              _imageUrl = value;
            });
          });
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // String getImage() {
    //   FirebaseStorageProvider.uploadImage(image: image).then((value) {
    //     setState(() {
    //       _imageUrl = value;
    //     });
    //   });
    //   return _imageUrl;
    // }

    _formKey.currentState!.save();

    BlocProvider.of<PostCubit>(context).createPost(
        postEntity: PostEntity(
            postID: FirebaseFirestore.instance.collection('posts').doc().id,
            userID: FirebaseAuth.instance.currentUser!.uid,
            userName: FirebaseAuth.instance.currentUser!.displayName!,
            timestamp: Timestamp.now(),
            imageUrl: _imageUrl,
            description: _descriptionController.text));
    _clear();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _clear() {
    _descriptionController.clear();
    _image = null;
    _imageUrl = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            ElevatedButton(
                onPressed: () => getImage(),
                child: const Text('Загрузить фото')),
            Container(
              height: 500,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: ImageWidget(image: _image)),
            ),
            TextFormField(
              onSaved: (value) => _descriptionController.text = value!,
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
              onFieldSubmitted: (_) => _submit(),
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
