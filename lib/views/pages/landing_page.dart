import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/views/pages/auth_page.dart';
import 'package:e_commerce/views/pages/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
              create: (context) => AuthController(auth: auth),
              child: const AuthPage(),
            );
          }
          return ChangeNotifierProvider<AuthController>(
            create: (context) => AuthController(auth: auth),
            child: Provider<Database>(
                create: (context) => FirestoreDatabase(user.uid),
                child: const BottomNavbar()),
          );
          // return const BottomNavbar();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
