import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String decoration;
  final String uid;
  final String username;
  final String postId;
  final  datePublished;
  final String postUtl;
  final String profImage;
  final  likes;


  Post({
    required this.decoration,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUtl,
    required this.profImage,
    required this.likes,

  });

  Map<String, dynamic> toJson() => {
        "decoration": decoration,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUtl": postUtl,
        "profImage": profImage,
        "likes": likes,

      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      decoration: snapshot['decoration'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      datePublished: (snapshot['datePublished'] ),
      postUtl: (snapshot['postUtl'] ),
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],

    );
  }
}
