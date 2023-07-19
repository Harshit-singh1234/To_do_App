import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_appp_project/pages/HomePage.dart';

// import 'package:firebase_app_web/Service/Auth_Service.dart';
// import 'package:firebase_app_web/pages/SignUpPage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../Service/Auth_Service.dart';
import 'SignUpPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonItem("assets/google.svg", "Continue with Google", 25, () {
                authClass.googleSignIn(context);
              }),
              const SizedBox(
                height: 15,
              ),
              buttonItem("assets/phone.svg", "Continue with Mobile", 30, () {}),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Or",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 18,
              ),
              textItem("Email....", _emailController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Password...", _pwdController, true),
              const SizedBox(
                height: 40,
              ),
              colorButton(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If you don't have an Account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => const SignUpPage()),
                          (route) => false);
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailController.text, password: _pwdController.text);
          print(userCredential.user!.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)
          ]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }

  Widget buttonItem(
      String imagepath, String buttonName, double size, Function onTap) {
    return InkWell(
      onTap: () =>onTap(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagepath,
                height: size,
                width: size,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String labeltext, TextEditingController controller, bool obscureText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}


// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController pwdcontroller = TextEditingController();
//   bool circular = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           color: Colors.black,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Sign In",
//                 style: TextStyle(
//                     fontSize: 35,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20.0),
//               buttonItem("assets/google.svg", "continue with Google", 25),
//               SizedBox(
//                 height: 15.0,
//               ),
//               buttonItem("assets/phone.svg", "continue with Mobile", 30),
//               SizedBox(height: 15.0),
//               SizedBox(height: 15.0),
//               Text(
//                 "Or",
//                 style: TextStyle(color: Colors.white, fontSize: 18.0),
//               ),
//               SizedBox(
//                 height: 15.0,
//               ),
//               textItem("Email ...", emailcontroller, false),
//               SizedBox(
//                 height: 15.0,
//               ),
//               textItem("Password...", pwdcontroller, true),
//               SizedBox(
//                 height: 30.0,
//               ),
//               colorButton(),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "If you don't have an account? ",
//                     style: TextStyle(color: Colors.white, fontSize: 18.0),
//                   ),
//                   Text(
//                     "SignUp",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Text(
//                 "Forget Password?",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget colorButton() {
//     return InkWell(
//       onTap: () async {
//         try {
//           firebase_auth.UserCredential userCredential =
//               await firebaseAuth.signInWithEmailAndPassword(
//                   email: emailcontroller.text, password: pwdcontroller.text);
//           print(userCredential.user!.email);
//           setState(() {
//             circular = false;
//           });
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (builder) => HomePage()),
//               (route) => false);
//         } catch (e) {
//           final snackbar = SnackBar(content: Text(e.toString()));
//           ScaffoldMessenger.of(context).showSnackBar(snackbar);
//           setState(() {
//             circular = false;
//           });
//         }
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width - 90,
//         height: 60,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0),
//           gradient: LinearGradient(colors: [
//             Color(0xfffd746c),
//             Color(0xffff9068),
//             Color(0xfffd746c)
//           ]),
//         ),
//         child: Center(
//           child: circular
//               ? CircularProgressIndicator()
//               : Text(
//                   "Sign In",
//                   style: TextStyle(color: Colors.white, fontSize: 20.0),
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget buttonItem(String imagepath, String buttonName, double size) {
//     return Container(
//       width: MediaQuery.of(context).size.width - 60,
//       height: 60,
//       child: Card(
//         color: Colors.black,
//         elevation: 8,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//           side: BorderSide(width: 1, color: Colors.grey),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(imagepath, height: size, width: size),
//             SizedBox(
//               width: 15,
//             ),
//             Text(
//               buttonName,
//               style: TextStyle(color: Colors.white, fontSize: 17),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget textItem(
//       String labeltext, TextEditingController controller, bool obscureText) {
//     return Container(
//       width: MediaQuery.of(context).size.width - 70,
//       height: 55,
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         style: TextStyle(fontSize: 17.0, color: Colors.white),
//         decoration: InputDecoration(
//           labelText: labeltext,
//           labelStyle: TextStyle(fontSize: 17.0, color: Colors.white),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(width: 1.5, color: Colors.amber),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(width: 1, color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }
//   //  Widget textItem(String labeltext) {
//   //   return Container(
//   //     width: MediaQuery.of(context).size.width - 70,
//   //     height: 55,
//   //     child: TextFormField(
//   //       decoration: InputDecoration(
//   //         labelText: labeltext,
//   //         labelStyle: TextStyle(fontSize: 17.0, color: Colors.white),
//   //         enabledBorder: OutlineInputBorder(
//   //           borderRadius: BorderRadius.circular(15),
//   //           borderSide: BorderSide(width: 1, color: Colors.grey),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
