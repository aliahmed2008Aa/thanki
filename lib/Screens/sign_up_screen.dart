import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thanki/Widgets/tetx_field_input.dart';
import 'package:thanki/Screens/login_screen.dart';
import 'package:thanki/resources/auth_methods.dart';
import 'package:thanki/responsive/mobile_screen_layout.dart';
import 'package:thanki/responsive/responsive_layout.dart';
import 'package:thanki/responsive/web_screen_layout.dart';
import 'package:thanki/utils/Colors.dart';
import 'package:thanki/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwrdController = TextEditingController();
  final bioController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwrdController.dispose();
    super.dispose();
  }

  selectImage() async {
    Uint8List img = await picImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signupUser(
        email: emailController.text,
        password: passwrdController.text,
        username: nameController.text,
        bio: bioController.text,
        file: _image!);
    if (res == "تم انشاء حسابك بنجاح") {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout())),(route) => false);
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      setState(() {
        isLoading = false;
      });

      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/11.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: 30, vertical: 40), // تم تعديل ال Padding هنا
              children: [
                SizedBox(height: 6),
                Text(
                  "AKKAD",
                  style: TextStyle(
                    fontFamily: "fontspring",
                    fontSize: 60,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),

                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 46,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 55,
                              backgroundImage: AssetImage("images/user.png")),
                      Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: Icon(Icons.add_a_photo),
                          )),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
                // Text(
                //   "اهلا بك في أفضل تطبيق تواصل عراقي",
                //   style: TextStyle(
                //     fontFamily: "fontspring",
                //     fontSize: 20,
                //     color: Colors.white,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: 40), // تم تعديل ال SizedBox هنا
                TetxFieldInput(
                  textEditingController: nameController,
                  hintText: "ادخل اسم مستخدم",
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20), // تم تعديل ال SizedBox هنا
                TetxFieldInput(
                  textEditingController: emailController,
                  hintText: "ادخل بريدك الالكتروني",
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TetxFieldInput(
                  textEditingController: passwrdController,
                  hintText: " كلمة السر",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                SizedBox(height: 20), // تم تعديل ال SizedBox هنا
                TetxFieldInput(
                  textEditingController: bioController,
                  hintText: "ادخل سيرتك الذاتية  ",
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: signUpUser,
                  child: Container(
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: primaryColor,
                          )
                        : Text(
                            "انشاء حساب",
                            style: TextStyle(
                              fontFamily: "fontspring",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),

                SizedBox(height: 50),
                Divider(),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontFamily: "fontspring",
                            fontWeight: FontWeight.bold,
                            height: 1.6,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "   لديك حساب؟ ",
                        style: TextStyle(
                          fontFamily: "fontspring",
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
