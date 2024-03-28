// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../const/consts.dart';
import '../../providers/authprovider.dart';
import '../../utils/utils.dart';
import '../../widget/customexpandedbutton.dart';
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
    // return WillPopScope(
    //   onWillPop: () async {
    //     return await Utils(context)
    //         .onWillPop(); // Allow popping the current route
    //   },
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) => Utils(context).onWillPop(),
          child: Consumer<AuthrizationProviders>(
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
                                // style: TextStyle(color: Colors.white),
                                textInputAction: TextInputAction.next,
                                onTap: () => setState(() {}),
                                onEditingComplete: () {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(passfocusNode);
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: authprovider.emailController,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: AppLocalizations.of(context)!
                                          .emailrequirederror),
                                  EmailValidator(
                                      errorText: AppLocalizations.of(context)!
                                          .emailvaliderror),
                                ]).call,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.email,
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
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: AppLocalizations.of(context)!
                                          .passrequirederror),
                                  MinLengthValidator(8,
                                      errorText: AppLocalizations.of(context)!
                                          .passlengthderror),
                                  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                      errorText: AppLocalizations.of(context)!
                                          .passvaliderror)
                                ]).call,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        AppLocalizations.of(context)!
                                            .rememberme,
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
                              const SizedBox(
                                height: 20,
                              ),
                              CustomExpanedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Show circular indicator while checking login credentials
                                    Utils(context).customLoading();
                                    try {
                                      if (authprovider.remember == true) {
                                        authprovider.saveRememberMe();
                                      } else {
                                        authprovider.removeRememberMe();
                                      }
                                      await authprovider.login();
                                    } on FirebaseAuthException catch (e) {
                                      ResponsiveSnackbar.show(
                                          context, e.message!);
                                    }
                                    // Close the circular indicator dialog
                                    Navigator.pop(context);
                                  }
                                },
                                text: AppLocalizations.of(context)!.loginbutton,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                        builder: (_) => const Signup()),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .donothaveaccount,
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
