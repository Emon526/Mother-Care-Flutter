import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/authprovider.dart';
import '../../utils/utils.dart';
import '../../widget/customexpandedbutton.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.forgotpassword,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Consumer<AuthrizationProviders>(
        builder: (context, authprovider, child) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.resetpassword,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.resettext,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.done,
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
                            height: 20,
                          ),
                          CustomExpanedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                authprovider
                                    .resetPassword(emailController.text.trim());

                                Navigator.pop(context);
                                await Utils(context).showsnackbar(
                                  message: AppLocalizations.of(context)!
                                      .forgotpasswordSnakeBar,
                                );
                              }
                            },
                            text: AppLocalizations.of(context)!.resetpassword,
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
}
