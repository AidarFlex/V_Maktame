import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vk_example/common/color_theme.dart';
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
    final circulareShape = MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text('Создать пост'),
        foregroundColor: Colors.black,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              thickness: 2,
              height: 0,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => getImage(),
                    child: Ink(
                        child: CircleAvatar(
                      radius: 35,
                      child: ClipOval(
                          child: ImageWidget(
                        image: _image,
                      )),
                    )),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: TextFormField(
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
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _submit(),
                        child: const Text('Создать пост'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              ColorTheme.registerColor),
                          foregroundColor:
                              MaterialStateProperty.all(ColorTheme.appBarColor),
                          shape: circulareShape,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
