// import 'package:bc_app/login.dart';
// import 'package:bc_app/widget/temblets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'diagnosis.dart';
// import 'firebaseservices/auth.dart';
// import 'home.dart';

// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   String name, email, pasworrd, phone, address, job, age;
//   GlobalKey<FormState> globalKey = GlobalKey<FormState>();
//   Auth auth = Auth();
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           "Register",
//           style: TextStyle(color: Colors.pink),
//         ),
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
//                 child: Column(
//                   children: [
//                     Temblet(
//                       hint: "Enter Your Full Name",
//                       iconData: Icons.person,
//                     ),
//                     Temblet(
//                       hint: "Enter Your Email",
//                       iconData: Icons.account_box,
//                       onChanged: (value) {
//                         email = value;
//                       },
//                     ),
//                     Temblet(
//                       hint: "Enter Your Password",
//                       iconData: Icons.lock,
//                       onChanged: (value) {
//                         pasworrd = value;
//                       },
//                     ),
//                     Temblet(
//                       hint: "Enter Your Phone",
//                       iconData: Icons.phone,
//                     ),
//                     Temblet(
//                       hint: "Enter Your Address",
//                       iconData: Icons.add_location,
//                     ),
//                     Temblet(
//                       hint: "Enter Your Job",
//                       iconData: Icons.work,
//                     ),
//                     Temblet(
//                       hint: "Enter Your Age",
//                       iconData: Icons.circle,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(30.0),
//                       child: Container(
//                         width: screenWidth * 0.3,
//                         child: FlatButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                           onPressed: () async {
//                             try {
//                               if (globalKey.currentState.validate()) {
//                                 globalKey.currentState.save();
//                                 await auth.register(
//                                     email: email, password: pasworrd);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => HomeScreen(),
//                                   ),
//                                 );
//                               } else {
//                                 print("can't login");
//                               }
//                             } on FirebaseAuthException catch (error) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(error.message),
//                                 ),
//                               );
//                             }
//                           },
//                           child: Text(
//                             "Register",
//                             style: TextStyle(color: Colors.black, fontSize: 20),
//                           ),
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Positioned(
//                   bottom: 30,
//                   right: 30,
//                   left: 30,
//                   child: Container(
//                     child: Row(
//                       children: [
//                         Text("I Have Account."),
//                         FlatButton(
//                             height: 30,
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Login(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               "Login Now",
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
