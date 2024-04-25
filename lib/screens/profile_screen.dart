import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/screens/update_profile_screen.dart';
import 'package:recipes/widgets/profile_menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authenticatedUser = FirebaseAuth.instance;
  var username = '';
  var useremail = '';
  var imageUrl = '';

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  void getUserProfile() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(authenticatedUser.currentUser!.uid)
        .get();

    setState(() {
      username = userData.data()!['username'];
      imageUrl = userData.data()!['profilePic'];
      useremail = userData.data()!['email'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        surfaceTintColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage: imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : const AssetImage('assets/avatar.png')
                              as ImageProvider<Object>)
                ],
              ),
              const SizedBox(height: 10),
              Text(username, style: Theme.of(context).textTheme.titleLarge),
              Text(useremail, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UpdateProfileScreen())),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfffe8d15),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Edit Profile',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Settings", icon: Icons.settings, onPress: () {}),

              // const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information", icon: Icons.info, onPress: () {}),
              const SizedBox(height: 10),

              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout_rounded,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
