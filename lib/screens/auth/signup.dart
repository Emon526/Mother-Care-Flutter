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
import '../../widget/showcalenderwidget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //TODO:: check is photos permission is granted or not.if needed use separate page to naviagte system settings
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: 'test');
  final emailController = TextEditingController(text: 'test@gmail.com');
  final passController = TextEditingController(text: 'Abc123456@');
  final confirmpassController = TextEditingController(text: 'Abc123456@');
  final dobController = TextEditingController();
  bool _isObscured = true;
  FocusNode dobfocusNode = FocusNode();
  FocusNode confirmpassfocusNode = FocusNode();
  FocusNode namefocusNode = FocusNode();
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
                    Utils(context).verticalSpace,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onEditingComplete: () {
                              namefocusNode.unfocus();
                              _showCalender();
                            },
                            focusNode: namefocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            controller: nameController,
                            validator: RequiredValidator(
                                    errorText: AppLocalizations.of(context)!
                                        .namerequirederror)
                                .call,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.name,
                              hintText: AppLocalizations.of(context)!.name,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          Utils(context).verticalSpace,
                          TextFormField(
                            onTap: () => _showCalender(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.none,
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
                          Utils(context).verticalSpace,
                          TextFormField(
                            // onTap: () => setState(() {}),
                            onEditingComplete: () {
                              passfocusNode.requestFocus();
                            },
                            focusNode: emailfocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.words,
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
                          Utils(context).verticalSpace,
                          TextFormField(
                            // onTap: () => setState(() {}),
                            onEditingComplete: () {
                              confirmpassfocusNode.requestFocus();
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
                          Utils(context).verticalSpace,
                          TextFormField(
                            // onTap: () => setState(() {}),
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
                          Utils(context).verticalSpace,
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
                          Utils(context).verticalSpace,
                          CustomExpanedButton(
                            onPressed: () async {
                              authprovider.acceptpolicy
                                  ? null
                                  : await Utils(context).showsnackbar(
                                      message: AppLocalizations.of(context)!
                                          .termsconditionSnakeBar,
                                    );
                              if (_formKey.currentState!.validate() &&
                                  authprovider.acceptpolicy) {
                                Utils(context).customLoading();
                                try {
                                  await authprovider.signup(
                                    name: nameController.text.trim(),
                                    dob: dobController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: confirmpassController.text.trim(),
                                    profilephoto: pickedimage,
                                  );
                                  Navigator.pop(context);
                                } on FirebaseAuthException catch (e) {
                                  await Utils(context)
                                      .showsnackbar(message: e.message!);
                                }
                                Navigator.pop(context);
                              }
                            },
                            text: AppLocalizations.of(context)!.signupbutton,
                          ),
                          Utils(context).verticalSpace,
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.haveaccount,
                            ),
                          ),
                          Utils(context).verticalSpace,
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
                    DateTime.now().toIso8601String(),
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
      await Utils(context).showsnackbar(
        message: error.toString(),
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
        emailfocusNode.requestFocus();
      },
    );
  }
}
