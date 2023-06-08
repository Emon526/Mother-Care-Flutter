import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../const/consts.dart';
import '../../providers/authprovider.dart';
import '../../utils/utils.dart';
import '../../widget/responsivesnackbar.dart';
import 'forgotpassword.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  FocusNode passfocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return await Utils(context)
            .onWillPop(); // Allow popping the current route
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Consumer<AuthProvider>(
          builder: (context, authprovider, child) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // const Flexible(
                      //   child: RiveAnimation.asset('assets/rive/auth.riv'),
                      // ),
                      _logo(context: context, size: size),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onTap: () => setState(() {}),
                              onEditingComplete: () {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(passfocusNode);
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.sentences,
                              controller: authprovider.emailController,
                              validator: Utils(context).emailValidator,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.email,
                                hintText: AppLocalizations.of(context)!.email,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onTap: () => setState(() {
                                passfocusNode.requestFocus();
                              }),
                              focusNode: passfocusNode,
                              obscureText: _isObscured,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              controller: authprovider.passController,
                              validator: Utils(context).passwordValidator,
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context)!.password,
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                border: const OutlineInputBorder(),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isObscured = !_isObscured;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(
                                      Consts.DefaultBorderRadius),
                                  child: Icon(
                                    _isObscured
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: passfocusNode.hasFocus
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      value: authprovider.remember,
                                      onChanged: (value) {
                                        authprovider.remember = value!;
                                      },
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.rememberme,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                          builder: (_) =>
                                              const ForgotPassword()),
                                    );
                                  },
                                  child: Text(
                                    '${AppLocalizations.of(context)!.forgotpassword}?',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await authprovider.login();
                                    if (authprovider.remember == true) {
                                      authprovider.saveRememberMe();
                                    } else {
                                      authprovider.removeRememberMe();
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    ResponsiveSnackbar.show(
                                        context, e.message!);

                                    // if (e.code == 'user-not-found') {
                                    //   ResponsiveSnackbar.show(context,
                                    //       'No user found for that email.');
                                    // } else if (e.code == 'wrong-password') {
                                    //   ResponsiveSnackbar.show(context,
                                    //       'Wrong password provided for that user.');
                                    // }
                                  }
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.loginbutton,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (_) => const Signup()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.donothaveaccount,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _logo({
    required BuildContext context,
    required Size size,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: size.height * 0.4,
          // color: Theme.of(context).primaryColor,
          child: Image.asset(
            color: Theme.of(context).primaryColor,
            Consts.LOGO,
          ),
        ),
        Positioned(
          // bottom: 20,
          child: Text(
            AppLocalizations.of(context)!.appname,
            style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
