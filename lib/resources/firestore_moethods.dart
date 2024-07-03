import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thanki/modlels/post.dart';
import 'package:thanki/resources/storge_methods.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorgeMethods _storageMethods = StorgeMethods();

  Future<String> uploadPost(String decoration, Uint8List file, String uid,
      String username, String profImage) async {
    try {
      String photoUrl =
          await _storageMethods.uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        decoration: decoration,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUtl: photoUrl,
        profImage: profImage,
      );
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      return "تمت العملية بنجاح";
    } catch (err) {
      print("Error uploading post: $err");
      return "حدث خطأ أثناء رفع المنشور";
    }
  }
}
