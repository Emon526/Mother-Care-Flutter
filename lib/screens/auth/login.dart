import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../const/consts.dart';
import '../../providers/authprovider.dart';
import '../../providers/themeprovider.dart';
import '../../utils/utils.dart';
import '../../widget/customexpandedbutton.dart';
import 'forgotpassword.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  FocusNode passfocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    passfocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic) =>
            Utils(context).onWillPop(),
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: context.read<ThemeProvider>().isDarkTheme
                ? Colors.black
                : Colors.white,
            systemNavigationBarIconBrightness:
                context.read<ThemeProvider>().isDarkTheme
                    ? Brightness.light
                    : Brightness.dark,
            statusBarColor: context.read<ThemeProvider>().isDarkTheme
                ? Colors.black
                : Colors.white,
            statusBarIconBrightness: context.read<ThemeProvider>().isDarkTheme
                ? Brightness.light
                : Brightness.dark,
          ),
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
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                // style: TextStyle(color: Colors.white),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  passfocusNode.requestFocus();
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
                                focusNode: passfocusNode,
                                obscureText: authprovider.isObscured,
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
                                      authprovider.isObscured =
                                          !authprovider.isObscured;
                                    },
                                    borderRadius: BorderRadius.circular(
                                        Consts.DefaultBorderRadius),
                                    child: Icon(
                                      authprovider.isObscured
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
                                      Utils(context)
                                          .push(widget: const ForgotPassword());
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
                                  if (formKey.currentState!.validate()) {
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
                                      _onerror(e.message);
                                    }
                                    // Close the circular indicator dialog
                                    _stopCustomLoading();
                                  }
                                },
                                text: AppLocalizations.of(context)!.loginbutton,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                onPressed: () async {
                                  await Utils(context)
                                      .push(widget: const Signup());
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

  void _onerror(String? message) async {
    await Utils(context).showsnackbar(message: message!);
  }

  _stopCustomLoading() {
    Navigator.pop(context);
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
