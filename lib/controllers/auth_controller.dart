import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/user_data.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/utilities/constans.dart';
import 'package:e_commerce/utilities/enums.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthformType authformType;

  final database = FirestoreDatabase('123');

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.authformType = AuthformType.login,
  });

  Future<void> submit() async {
    try {
      if (authformType == AuthformType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        final user = await auth.singUpWithEmailAndPassword(email, password);
        await database.setUserData(UserData(
          uid: user?.uid ?? documentIdFromLocalData(),
          email: email,
        ));
      }
    } catch (e) {
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = authformType == AuthformType.login
        ? AuthformType.register
        : AuthformType.login;
    copyWith(
      email: '',
      password: '',
      authformType: formType,
    );
  }

  void updateEmail(String email) => copyWith(email: email);
  void updatePassword(String password) => copyWith(password: password);

  void copyWith({
    String? email,
    String? password,
    AuthformType? authformType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authformType = authformType ?? this.authformType;
    notifyListeners();
  }

  Future<void> logOut() async {
    try {
      await auth.logOut();
    } catch (e) {
      rethrow;
    }
  }
}
