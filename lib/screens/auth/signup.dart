import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../const/consts.dart';
import '../../providers/authprovider.dart';
import '../../providers/languageprovider.dart';
import '../../providers/reminderprovider.dart';
import '../../utils/utils.dart';
import '../../widget/responsivesnackbar.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController(text: 'Asradful');
  final lastnameController = TextEditingController(text: 'islam');
  final emailController = TextEditingController(text: 'Emonats526@gmail.com');
  final passController = TextEditingController(text: 'Abc123456@');
  final confirmpassController = TextEditingController(text: 'Abc123456@');
  final dobController = TextEditingController();
  bool _isObscured = true;
  FocusNode dobfocusNode = FocusNode();
  FocusNode confirmpassfocusNode = FocusNode();
  FocusNode passfocusNode = FocusNode();
  FocusNode emailfocusNode = FocusNode();

  // final emailValidator =
  // final confirmValidator = MatchValidator(errorText: '');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<AuthProvider>(
        builder: (context, authprovider, child) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _logo(context: context, size: size),
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
                                errorText:
                                    AppLocalizations.of(context)!.addReminder),
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
                                    .lastnamerequirederror),
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
                                    .dobrequirederror),
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
                            ]),
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
                            ]),
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
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Utils(context).customLoading();
                                try {
                                  await authprovider.signup(
                                    firstname: firstnameController.text.trim(),
                                    lastname: lastnameController.text.trim(),
                                    dob: dobController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: confirmpassController.text.trim(),
                                  );
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                } on FirebaseAuthException catch (e) {
                                  ResponsiveSnackbar.show(context, e.message!);
                                }
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signupbutton,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.haveaccount,
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
    );
  }

  _showCalender() {
    return showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yyyy',
                                  context.read<LanguageProvider>().languageCode)
                              .format(context
                                  .watch<ReminderProvider>()
                                  .seletedDate),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateFormat('EEE, MMM dd',
                                  context.read<LanguageProvider>().languageCode)
                              .format(context
                                  .watch<ReminderProvider>()
                                  .seletedDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SfDateRangePicker(
                    cancelText: AppLocalizations.of(context)!.cancelbutton,
                    confirmText: AppLocalizations.of(context)!.okbutton,
                    maxDate: DateTime.now(),
                    onSelectionChanged: (args) {
                      context.read<ReminderProvider>().seletedDate =
                          DateTime.parse(args.value.toString());
                    },
                    onSubmit: (date) {
                      DateFormat dateFormat =
                          DateFormat('EEE, dd MMMM yyyy', 'en');
                      dobController.text =
                          dateFormat.format(DateTime.parse(date.toString()));

                      Navigator.pop(context);
                      //TODO:fix focus
                      // FocusScope.of(context).requestFocus(emailfocusNode);
                    },
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    headerStyle: const DateRangePickerHeaderStyle(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    selectionTextStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    monthCellStyle: const DateRangePickerMonthCellStyle(
                      todayTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    yearCellStyle: DateRangePickerYearCellStyle(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      todayTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    selectionColor: Theme.of(context).colorScheme.secondary,
                    todayHighlightColor: Colors.white,
                    showActionButtons: true,
                    enablePastDates: true,
                    showNavigationArrow: true,
                    selectionMode: DateRangePickerSelectionMode.single,
                    view: DateRangePickerView.month,
                    initialDisplayDate: DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    navigationDirection:
                        DateRangePickerNavigationDirection.vertical,
                    navigationMode: DateRangePickerNavigationMode.snap,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
          height: size.height * 0.2,
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
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
