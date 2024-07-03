import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:thanki/providers/user_provider.dart';
import 'package:thanki/resources/firestore_moethods.dart';
import 'package:thanki/utils/Colors.dart';
import 'package:thanki/utils/utils.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
  bool _isLoading = false;
  final _descriptionController = TextEditingController();

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_file != null) {
        String res = await FirestoreMethods().uploadPost(
          _descriptionController.text,
          _file!,
          uid,
          username,
          profImage,
        );
        if (res == "تمت") {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(context, 'Posted');
          clearImage();
        } else {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(context, res);
          print(res.toString());
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, 'يرجى اختيار صورة أولاً');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  Future<void> _selectImage() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('انشاء منشور'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('اختيار صوره'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List? file = await picImage(ImageSource.gallery);
                if (file != null) {
                  setState(() {
                    _file = file;
                  });
                }
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('الغاء '),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: _selectImage,
              icon: Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: clearImage,
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(
                "Post to",
                style: TextStyle(
                  fontFamily: "fontspring",
                ),
              ),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () {
                    
                    
                    var user;
                    postImage(user.uid, user.username, user.photoUrl);
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: "fontspring",
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? LinearProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://img.pikbest.com/origin/10/25/40/69wpIkbEsTnyJ.jpg!w700wp"),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              controller: _descriptionController,
                              textDirection: TextDirection.rtl,
                              decoration: InputDecoration(
                                hintText: 'اكتب الوصف....',
                                border: InputBorder.none,
                              ),
                              maxLines: 8,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(_file!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider()
                        ],
                      )
              ],
            ),
          );
  }
}
