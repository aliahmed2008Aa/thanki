import 'dart:core';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thanki/modlels/user.dart' as model;
import 'package:thanki/resources/storge_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

Future<model.User> getUserDetails() async {
  try {
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    
    return model.User.fromSnap(snap); 

  } catch (e) {
    print('Error fetching user details: $e');
    throw Exception('Failed to fetch user details');
  }
}

  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "حدث بعض الخطأ";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorgeMethods()
            .uploadImageToStorage("profilePics", file, false);
        model.User _user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl);
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(_user.toJson());
        res = "تم انشاء حسابك بنجاح";
      } else {
        res = "يرجى ملء جميع الحقول";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "حدث بعض الخطأ";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "تم تسجيل الدخول بنجاح";
      } else {
        res = "يرجى ملء جميع الحقول";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
  
}
