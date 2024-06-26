// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usermodel.dart';
import '../utils/utils.dart';

class AuthrizationProviders with ChangeNotifier {
  AuthrizationProviders() {
    getrememberme();
    fatchsaverememberme();
  }
  bool _isObscured = true;
  bool get isObscured => _isObscured;
  set isObscured(bool value) {
    _isObscured = value;
    notifyListeners();
  }

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance.collection('users');
  var firestorage = FirebaseStorage.instance.ref().child('profileimage');
  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;
  UserModel? user;
  bool _remember = true;
  bool get remember => _remember;
  set remember(bool value) {
    _remember = value;
    rememberme(rememberme: value);
    notifyListeners();
  }

  bool _acceptpolicy = true;
  bool get acceptpolicy => _acceptpolicy;
  set acceptpolicy(bool value) {
    _acceptpolicy = value;
    notifyListeners();
  }

  void rememberme({required bool rememberme}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberme', rememberme);
    notifyListeners();
  }

  getrememberme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _remember = prefs.getBool('rememberme') ?? _remember;
    notifyListeners();
  }

  void logout() async {
    await auth.signOut();
    notifyListeners();
  }

  Future<void> login() async {
    await auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );
    notifyListeners();
  }

  Future<void> signup({
    required String name,
    required String dob,
    required String email,
    required String password,
    required File? profilephoto,
  }) async {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await addUserData(
      name: name,
      email: email,
      dob: dob,
      profilephoto: profilephoto,
    );
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  void delete({required BuildContext context}) async {
    try {
      var user = auth.currentUser!;
      await user.delete();
      await deleteUserData(user.uid);
    } on FirebaseAuthException catch (e) {
      await Utils(context).showsnackbar(message: e.message!);
    }

    notifyListeners();
  }

  void saveRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text.trim());
    await prefs.setString('password', passController.text.trim());
    fatchsaverememberme();
    notifyListeners();
  }

  void removeRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', '');
    await prefs.setString('password', '');
    fatchsaverememberme();
    notifyListeners();
  }

  fatchsaverememberme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? _email;
    _password = prefs.getString('password') ?? _password;
    emailController.text = _email;
    passController.text = _password;
    notifyListeners();
  }

  Future<void> addUserData(
      {required String name,
      required String email,
      required String dob,
      required File? profilephoto}) async {
    String? profilephotoUrl;
    if (profilephoto?.path != null) {
      final ref = firestorage.child('${auth.currentUser!.uid}.jpg');
      await ref.putFile(profilephoto!);
      profilephotoUrl = await ref.getDownloadURL();
    }
    UserModel user = UserModel(
      name: name,
      email: email,
      dateofbirth: dob,
      uid: auth.currentUser!.uid,
      profilepicture: profilephotoUrl,
    );
    await firestore.doc(auth.currentUser!.uid).set(user.toJson());
    notifyListeners();
  }

  Future<void> deleteUserData(String user) async {
    await firestore.doc(user).delete();
    final ref = firestorage.child('$user.jpg');
    await ref.delete();

    notifyListeners();
  }

  Stream<UserModel?> getUserData() {
    final CollectionReference usersCollection = firestore;
    return usersCollection
        .doc(auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        user = UserModel.fromJson(data);
        return user;
      } else {
        return null;
      }
    });
  }

  Future<void> updateUserData(
      {required String name,
      required String email,
      required String dob,
      required File? profilephoto}) async {
    String? profilephotoUrl;
    if (profilephoto?.path != null) {
      final ref = firestorage.child('${auth.currentUser!.uid}.jpg');
      await ref.putFile(profilephoto!);
      profilephotoUrl = await ref.getDownloadURL();
    }
    UserModel userdata = UserModel(
      name: name,
      email: email,
      dateofbirth: dob,
      uid: auth.currentUser!.uid,
      profilepicture: profilephotoUrl ?? user!.profilepicture,
    );
    await firestore.doc(auth.currentUser!.uid).update(userdata.toJson());
    notifyListeners();
  }
}
