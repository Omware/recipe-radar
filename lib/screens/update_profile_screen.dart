import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/validation/authentication_validators.dart';
import 'package:recipes/widgets/image_picker.dart';

final _firebase = FirebaseAuth.instance;

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();
  var isUpdating = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void getUserProfile() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_firebase.currentUser!.uid)
        .get();

    _usernameController.text = userData.data()!['username'];
    _emailController.text = userData.data()!['email'];
    _passwordController.text = userData.data()!['password'];
  }

  void updateUserProfile() async {
    if (!_key.currentState!.validate()) {
      return;
    }
    _key.currentState!.save();

    try {
      setState(() => isUpdating = true);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebase.currentUser!.uid)
          .update({
        'username': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text
      });

      // update password
      await _firebase.currentUser!.updatePassword(_passwordController.text);

      // update username
      await _firebase.currentUser!.updateDisplayName(_usernameController.text);

      if (mounted) {
        setState(() => isUpdating = false);
        Navigator.pop(context);
      }

      
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        setState(() => isUpdating = false);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        surfaceTintColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              // -- IMAGE with ICON
              const UserImagePicker(),
              const SizedBox(height: 50),
              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: 'Enter your username'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            readOnly: true,
                            decoration: const InputDecoration(
                                hintText: 'Enter your email'),
                            validator: emailValidator,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            validator: passwordValidator,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        updateUserProfile();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xfffe8d15)),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 55)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: isUpdating
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Update Profile',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
