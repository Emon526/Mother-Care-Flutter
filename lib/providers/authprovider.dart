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
  UserModel? user;
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
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await addUserData(
      firstName: firstname,
      lastName: lastname,
      email: email,
      dob: dob,
    );
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  Future<void> delete() async {
    var user = auth.currentUser!;
    await user.delete();
    await deleteUserData(user.uid);
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

  Future<void> addUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String dob,
  }) async {
    UserModel user = UserModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateofbirth: dob,
      uid: auth.currentUser!.uid,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson());
    notifyListeners();
  }

  Future<void> deleteUserData(String user) async {
    await firestore.collection('users').doc(user).delete();
    notifyListeners();
  }

  Stream<UserModel?> getUserData() {
    final CollectionReference usersCollection = firestore.collection('users');
    return usersCollection
        .doc(auth.currentUser!.uid)
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
}
