import 'package:flutter/material.dart';
import 'package:thanki/Widgets/tetx_field_input.dart';
import 'package:thanki/resources/auth_methods.dart';
import 'package:thanki/responsive/mobile_screen_layout.dart';
import 'package:thanki/responsive/responsive_layout.dart';
import 'package:thanki/responsive/web_screen_layout.dart';
import 'package:thanki/Screens/sign_up_screen.dart';
import 'package:thanki/utils/Colors.dart';
import 'package:thanki/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwrdController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwrdController.dispose();
    super.dispose();
  }

  loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwrdController.text);
    if (res == "تم انشاء حسابك بنجاح") {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout())),(route)=>false);
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
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
                Text(
                  "AKKAD",
                  style: TextStyle(
                    fontFamily: "fontspring",
                    fontSize: 60,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "اهلا بك في أفضل تطبيق تواصل عراقي",
                  style: TextStyle(
                    fontFamily: "fontspring",
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60), // تم تعديل ال SizedBox هنا
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
                SizedBox(height: 20),
                GestureDetector(
                  onTap: loginUser,
                  child: Container(
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: primaryColor,
                          )
                        : Text(
                            " تسجيل الدخول",
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
                SizedBox(height: 200),
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
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          "انشاء حساب",
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
                        "  ليس لديك حساب؟ ",
                        style: TextStyle(
                          fontFamily: "fontspring",
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
