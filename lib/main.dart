import 'package:flutter/material.dart';
// import 'package:firebase_app_web/Service/Auth_Service.dart';
// import 'package:firebase_app_web/pages/HomePage.dart';
// import 'package:firebase_app_web/pages/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_appp_project/Service/Auth_Service.dart';
import 'package:todo_appp_project/pages/HomePage.dart';
import 'package:todo_appp_project/pages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const SignUpPage();
  AuthClass authClass = AuthClass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    String? token = await authClass.getToken();
    print("token");
    if (token != null) {
      setState(() {
        currentPage = const HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}
