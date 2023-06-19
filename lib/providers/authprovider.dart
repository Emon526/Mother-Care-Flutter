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
  bool _isLoading = false;
  bool get Loading => _isLoading;
  set Loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

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
    notifyListeners();
  }

  getrememberme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _remember = prefs.getBool('rememberme') ?? _remember;
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
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    await addUserData();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  Future<void> delete() async {
    await deleteUserData();
    await auth.currentUser!.delete();
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

  Future<void> addUserData() async {
    UserModel user = UserModel(
      firstName: 'firstname',
      lastName: 'lastname',
      email: 'email',
      dateofbirth: 'dob',
      uid: auth.currentUser!.uid,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson());
    notifyListeners();
  }

  Future<void> deleteUserData() async {
    await firestore.collection('users').doc(auth.currentUser!.uid).delete();
    notifyListeners();
  }
}
