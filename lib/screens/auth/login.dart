// import 'dart:math';

// import 'package:bc_app/register.dart';
// import 'package:bc_app/widget/temblets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'diagnosis.dart';
// import 'firebaseservices/auth.dart';
// import 'home.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool isLoading = false;
//   String email, password;
//   GlobalKey<FormState> globalKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Login Screen"),
//       ),
//       body: Form(
//         key: globalKey,
//         child: SingleChildScrollView(
//           child: Stack(
//             children: [
//               Container(
//                 height: screenHeight,
//                 width: screenWidth,
//                 color: Colors.pink,
//               ),
//               Positioned(
//                 right: 30,
//                 left: 30,
//                 top: 50,
//                 bottom: 90,
//                 child: Container(
//                   width: screenWidth * 0.7,
//                   height: screenHeight * 0.7,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(50)),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Temblet(
//                         onClick: (value) {
//                           email = value;
//                         },
//                         hint: "Enter Your Email",
//                         iconData: Icons.person,
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Temblet(
//                         onClick: (value) {
//                           password = value;
//                         },
//                         hint: "Enter Your Password",
//                         iconData: Icons.lock,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(30.0),
//                         child: Container(
//                           width: screenWidth * 0.3,
//                           child: FlatButton(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20)),
//                             onPressed: () async {
//                               try {
//                                 Auth auth = Auth();
//                                 if (globalKey.currentState.validate()) {
//                                   globalKey.currentState.save();
//                                   await auth.loginWithEmailAndPassword(
//                                     email,
//                                     password,
//                                   );
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => HomeScreen(),
//                                     ),
//                                   );
//                                 } else {
//                                   print("can't login");
//                                 }
//                               } on FirebaseAuthException catch (error) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(error.message),
//                                   ),
//                                 );
//                               }
//                             },
//                             child: Text(
//                               "Login",
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 20),
//                             ),
//                             color: Colors.pink,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                   bottom: 10,
//                   right: 30,
//                   left: 30,
//                   child: Container(
//                     child: Row(
//                       children: [
//                         Text("Don't Have Any Account ? "),
//                         FlatButton(
//                             height: 30,
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Register(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               "Register Now",
//                               style: TextStyle(color: Colors.black),
//                             ))
//                       ],
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
