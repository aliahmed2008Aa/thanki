import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thanki/Screens/login_screen.dart';
import 'package:thanki/providers/user_provider.dart';
import 'package:thanki/responsive/mobile_screen_layout.dart';
import 'package:thanki/responsive/responsive_layout.dart';
import 'package:thanki/responsive/web_screen_layout.dart';
import 'package:thanki/utils/Colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDqxdJ7dP93kUwLc_xNpaAMIuWTYK4OLG0",
    appId: "1:40173828864:web:261d1168a02cfba9a3d1e5",
    messagingSenderId: "40173828864",
    projectId: "thanki-prod",
    storageBucket: "thanki-prod.appspot.com",
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        title: 'AKAD',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                  mobileScreenLayout: const MobileScreenLayout(),
                  webScreenLayout: const WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
