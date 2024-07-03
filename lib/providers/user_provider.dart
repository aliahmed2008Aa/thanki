import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thanki/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  

  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user!;


  Future<void> refreshUser() async {
    User? user = (await _authMethods.getUserDetails()) as User;
    if (user != user) {
      _user = user;
    }
    notifyListeners();
  }
}
