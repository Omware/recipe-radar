import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes/screens/bottom_navigation.dart';
import 'package:recipes/validation/authentication_validators.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var username = '';
  var email = '';
  var password = '';
  var isSending = false;
  bool _obscureText = true;
  bool isSignUp = true;

  void _onSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() => isSending = true);
      if (isSignUp) {
        //signup
        final signup = await _firebase.createUserWithEmailAndPassword(
            email: email, password: password);
        print("@@@@@@@@@ $signup");

        await FirebaseFirestore.instance
            .collection('users')
            .doc(signup.user!.uid)
            .set({
          'username': username,
          'email': email,
          'password': password,
          'profilePic': ''
        });

        if (mounted) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const BottomNav())));
        }
      } else {
        // login
        final login = await _firebase.signInWithEmailAndPassword(
            email: email, password: password);
        print("######## $login");
        if (mounted) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const BottomNav())));
        }
      }

      if (mounted) {
        setState(() => isSending = false);
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        setState(() => isSending = false);
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Recipe Radar App',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Please fill in your accout details below',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color.fromARGB(255, 48, 48, 48),
                        ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isSignUp)
                          TextFormField(
                            onChanged: (value) => username = value,
                            keyboardType: TextInputType.emailAddress,
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
                        if (isSignUp) const SizedBox(height: 24),
                        TextFormField(
                          onChanged: (value) => email = value,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              hintText: 'Enter your email'),
                          validator: emailValidator,
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          onChanged: (value) => password = value,
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
                      _onSignUp();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xfffe8d15)),
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 55)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: isSending
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isSignUp ? 'Sign Up' : 'Login',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSignUp = !isSignUp;
                      });
                    },
                    child: Text(
                      isSignUp ? 'Login' : 'SignUp',
                      style: const TextStyle(
                          color: Color(0xfffe8d15),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
