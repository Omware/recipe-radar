import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final user = FirebaseAuth.instance.currentUser!;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 70, maxWidth: 150);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImage = File(pickedImage.path);
    });

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${user.uid}.jpg');

    await storageRef.putFile(_pickedImage!);
    final profilePic = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'profilePic': profilePic});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  foregroundImage:
                      _pickedImage != null ? FileImage(_pickedImage!) : null),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xfffe8d15),
                  ),
                  child:
                      const Icon(Icons.camera, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
