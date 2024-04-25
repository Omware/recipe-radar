import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/screens/bottom_navigation.dart';
import 'package:recipes/screens/signup_screen.dart';
import 'package:recipes/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xfffe8d15),
  background: const Color.fromARGB(247, 255, 255, 255),
  // brightness: Brightness.light
);

OutlineInputBorder defaultOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(color: Color.fromARGB(255, 209, 208, 208)),
);

final theme = ThemeData().copyWith(
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.poppinsTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFFFBFBFB),
      filled: true,
      border: defaultOutlineInputBorder,
      enabledBorder: defaultOutlineInputBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xfffe8d15)),
      ),
    ));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Radar',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          // to listen to auth changes
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const BottomNav();
            }
            return const SplashScreen();
          })),
    );
  }
}
