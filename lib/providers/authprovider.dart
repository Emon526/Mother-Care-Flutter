import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usermodel.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getrememberme();
    fatchsaverememberme();
  }
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;
  bool _remember = true;
  bool get remember => _remember;
  set remember(bool value) {
    _remember = value;
    rememberme(rememberme: value);
    notifyListeners();
  }

  void rememberme({required bool rememberme}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberme', rememberme);
    log(name: 'rememberme', rememberme.toString());
    notifyListeners();
  }

  getrememberme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _remember = prefs.getBool('rememberme') ?? _remember;
    log('getrememberme ');
    notifyListeners();
  }

  Future<void> logout() async {
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

  Future<void> signup(
      {required String firstname,
      required String lastname,
      required String dob,
      required String email,
      required String password}) async {
    UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    UserModel user = UserModel(
      firstName: firstname,
      lastName: lastname,
      email: email,
      dateofbirth: dob,
      uid: cred.user!.uid,
    );
    await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  Future<void> delete() async {
    await auth.currentUser!.delete();
    await firestore.collection('users').doc(auth.currentUser!.uid).delete();
    notifyListeners();
  }

  void saveRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text.trim());
    await prefs.setString('password', passController.text.trim());
    log('$email $password', name: 'saveRememberMe');
    fatchsaverememberme();
    notifyListeners();
  }

  void removeRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', '');
    await prefs.setString('password', '');
    log('removeRememberMe ');
    fatchsaverememberme();
    notifyListeners();
  }

  fatchsaverememberme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? _email;
    _password = prefs.getString('password') ?? _email;
    log('fatchsaverememberme ');
    emailController.text = _email;
    passController.text = _password;
    notifyListeners();
  }
}
