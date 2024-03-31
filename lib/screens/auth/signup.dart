// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../const/consts.dart';
import '../../providers/authprovider.dart';
import '../../utils/utils.dart';
import '../../widget/customexpandedbutton.dart';
import '../../widget/responsivesnackbar.dart';
import '../../widget/showcalenderwidget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();
  final dobController = TextEditingController();
  bool _isObscured = true;
  FocusNode dobfocusNode = FocusNode();
  FocusNode confirmpassfocusNode = FocusNode();
  FocusNode passfocusNode = FocusNode();
  FocusNode emailfocusNode = FocusNode();
  ImagePicker picker = ImagePicker();
  File? pickedimage;
  DateTime date = DateTime.now().subtract(
    const Duration(days: 30),
  );
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.signupbutton,
        ),
      ),
      body: Consumer<AuthrizationProviders>(
        builder: (context, authprovider, child) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _profilephoto(context: context, size: size),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            controller: firstnameController,
                            validator: RequiredValidator(
                                    errorText: AppLocalizations.of(context)!
                                        .addReminder)
                                .call,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.firstname,
                              hintText: AppLocalizations.of(context)!.firstname,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onEditingComplete: () {
                              //TODO: fix showcalender error
                              FocusScope.of(context).unfocus();
                              // FocusScope.of(context).requestFocus(dobfocusNode);
                              _showCalender();
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            controller: lastnameController,
                            validator: RequiredValidator(
                                    errorText: AppLocalizations.of(context)!
                                        .lastnamerequirederror)
                                .call,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.lastname,
                              hintText: AppLocalizations.of(context)!.lastname,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onTap: () => _showCalender(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.none,
                            // textCapitalization: TextCapitalization.words,
                            controller: dobController,
                            validator: RequiredValidator(
                                    errorText: AppLocalizations.of(context)!
                                        .dobrequirederror)
                                .call,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.dob,
                              hintText: AppLocalizations.of(context)!.dob,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onTap: () => setState(() {}),
                            onEditingComplete: () {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(passfocusNode);
                              });
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.sentences,
                            controller: emailController,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: AppLocalizations.of(context)!
                                      .emailrequirederror),
                              EmailValidator(
                                  errorText: AppLocalizations.of(context)!
                                      .emailvaliderror),
                            ]).call,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.email,
                              hintText: AppLocalizations.of(context)!.email,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onTap: () => setState(() {}),
                            onEditingComplete: () {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(confirmpassfocusNode);
                              });
                            },
                            obscureText: _isObscured,
                            focusNode: passfocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passController,
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
                              labelText: AppLocalizations.of(context)!.password,
                              hintText: AppLocalizations.of(context)!.password,
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
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onTap: () => setState(() {}),
                            obscureText: _isObscured,
                            focusNode: confirmpassfocusNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            controller: confirmpassController,
                            validator: (val) => MatchValidator(
                                    errorText: AppLocalizations.of(context)!
                                        .passmatcherror)
                                .validateMatch(
                                    val!, passController.text.trim()),
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.confirmpassword,
                              hintText:
                                  AppLocalizations.of(context)!.confirmpassword,
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
                                  color: confirmpassfocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: authprovider.acceptpolicy,
                                onChanged: (value) {
                                  authprovider.acceptpolicy = value!;
                                },
                              ),
                              Flexible(
                                child: Utils(context).boldsentenceword(
                                    text: AppLocalizations.of(context)!
                                        .sighupnotice,
                                    boldTextList: [
                                      {
                                        'text': AppLocalizations.of(context)!
                                            .privacypolicy,
                                        'url': Consts.PRIVACY_POLICY_URL,
                                      },
                                      {
                                        'text': AppLocalizations.of(context)!
                                            .termsservices,
                                        'url': Consts.TERMS_CONDITIONS_URL,
                                      },
                                      {
                                        'text': AppLocalizations.of(context)!
                                            .notificationsettings,
                                        'url':
                                            Consts.NOTIFICATIONS_SETTINGS_URL,
                                      },
                                    ]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomExpanedButton(
                            onPressed: () async {
                              pickedimage == null
                                  ? ResponsiveSnackbar.show(
                                      context,
                                      AppLocalizations.of(context)!
                                          .pickimageSnakeBar)
                                  : null;
                              authprovider.acceptpolicy
                                  ? null
                                  : ResponsiveSnackbar.show(
                                      context,
                                      AppLocalizations.of(context)!
                                          .termsconditionSnakeBar,
                                    );
                              if (pickedimage != null &&
                                  _formKey.currentState!.validate() &&
                                  authprovider.acceptpolicy) {
                                Utils(context).customLoading();
                                try {
                                  await authprovider.signup(
                                    firstname: firstnameController.text.trim(),
                                    lastname: lastnameController.text.trim(),
                                    dob: dobController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: confirmpassController.text.trim(),
                                    profilephoto: pickedimage!,
                                  );
                                  Navigator.pop(context);
                                } on FirebaseAuthException catch (e) {
                                  ResponsiveSnackbar.show(context, e.message!);
                                }
                                Navigator.pop(context);
                              }
                            },
                            text: AppLocalizations.of(context)!.signupbutton,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.haveaccount,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
    );
  }

  _profilephoto({
    required BuildContext context,
    required Size size,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: size.height * 0.2,
          child: pickedimage != null
              ? CircleAvatar(
                  radius: size.height * 0.2,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      pickedimage!,
                      height: size.height * 0.2,
                      width: size.height * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: size.height * 0.2,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: RandomAvatar(
                    'profilephoto',
                    trBackground: true,
                  ),
                ),
        ),
        Positioned(
          bottom: 10,
          right: 80,
          child: InkWell(
            onTap: () {
              pickImage();
            },
            child: Icon(
              pickedimage == null
                  ? Icons.add_a_photo_outlined
                  : Icons.change_circle_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void pickImage() async {
    try {
      var image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() {
        pickedimage = File(image.path);
      });
    } catch (error) {
      ResponsiveSnackbar.show(
        context,
        error.toString(),
      );
    }
  }

  _showCalender() {
    ShowCalenderWidget(
      context: context,
      maxDate: date,
      enablePastDates: true,
      initialDisplayDate: date,
      initialSelectedDate: date,
      onSubmit: (date) {
        DateFormat dateFormat = DateFormat('EEE, dd MMMM yyyy', 'en');
        dobController.text = dateFormat.format(DateTime.parse(date.toString()));
        Navigator.pop(context);
        //TODO:fix focus for emailfocus node
        // FocusScope.of(context).requestFocus(emailfocusNode);
      },
    );
  }
}
