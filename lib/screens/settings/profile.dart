import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../models/usermodel.dart';
import '../../providers/authprovider.dart';
import '../../utils/utils.dart';
import '../auth/auth.dart';
import 'editprofile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  DateTime date = DateTime.now().subtract(
    const Duration(days: 30),
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //TODO:: Add update information

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Utils(context).push(
                widget: const EditProfileScreen(),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.editprofilebutton,
            ),
          ),
        ],
      ),
      body: Consumer<AuthrizationProviders>(
        builder: (context, value, child) {
          return StreamBuilder<UserModel?>(
            stream: value.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!;

                return _buildProfile(
                  context: context,
                  size: size,
                  userData: userData,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SpinKitDoubleBounce(
                  color: Theme.of(context).primaryColor,
                );
              }
            },
          );
        },
      ),
    );
  }

  _buildButtonListtile({
    required IconData iconData,
    required String tiletitle,
    required Function onTap,
  }) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      ),
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: ListTile(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          title: Text(tiletitle),
          trailing: Icon(iconData),
        ),
      ),
    );
  }

  _deleteAccount({required BuildContext context}) {
    return Utils(context).showCustomDialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.deleteaccount,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            Utils(context).verticalSpace,
            Text(
              AppLocalizations.of(context)!.deleteaccounttext,
            ),
            Utils(context).verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    AppLocalizations.of(context)!.nobutton,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Show circular indicator while deleting credentials
                    Utils(context).customLoading();

                    context
                        .read<AuthrizationProviders>()
                        .delete(context: context);

                    Navigator.pop(context);
                    await Utils(context).pushUntil(widget: const Auth());
                  },
                  child: Text(
                    AppLocalizations.of(context)!.yesbutton,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildProfile({
    required BuildContext context,
    required Size size,
    required UserModel userData,
  }) {
    nameController.text = userData.name;
    dobController.text = userData.dateofbirth;
    emailController.text = userData.email;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.personalinformation,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Utils(context).verticalSpace,
          SizedBox(
            height: size.height * 0.2,
            child: Center(
              child: userData.profilepicture != null
                  ? CachedNetworkImage(
                      imageUrl: userData.profilepicture!,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: size.height * 0.1,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: imageProvider,
                            height: size.height * 0.2,
                            width: size.height * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SpinKitDoubleBounce(
                        color: Theme.of(context).primaryColor,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Icon(
                      Icons.account_circle,
                      size: size.height * 0.2,
                      // color: iconColor,
                    ),
            ),
          ),
          Utils(context).verticalSpace,
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            readOnly: true,
            controller: nameController,
            validator: RequiredValidator(
                    errorText: AppLocalizations.of(context)!.addReminder)
                .call,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.name,
              hintText: AppLocalizations.of(context)!.name,
              border: const OutlineInputBorder(),
            ),
          ),
          Utils(context).verticalSpace,
          TextFormField(
            // onTap: () => _showCalender(),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.none,
            readOnly: true,
            // textCapitalization: TextCapitalization.words,
            controller: dobController,
            validator: RequiredValidator(
                    errorText: AppLocalizations.of(context)!.dobrequirederror)
                .call,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.dob,
              hintText: AppLocalizations.of(context)!.dob,
              border: const OutlineInputBorder(),
            ),
          ),
          Utils(context).verticalSpace,
          Text(
            AppLocalizations.of(context)!.accountinformation,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Utils(context).verticalSpace,
          TextFormField(
            onTap: () => {
              //setState(() {})
            },
            onEditingComplete: () {
              // setState(() {
              //   FocusScope.of(context).requestFocus(passfocusNode);
              // });
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.words,
            controller: emailController,
            readOnly: true,
            validator: MultiValidator([
              RequiredValidator(
                  errorText: AppLocalizations.of(context)!.emailrequirederror),
              EmailValidator(
                  errorText: AppLocalizations.of(context)!.emailvaliderror),
            ]).call,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.email,
              hintText: AppLocalizations.of(context)!.email,
              border: const OutlineInputBorder(),
            ),
          ),
          Utils(context).verticalSpace,
          Text(
            AppLocalizations.of(context)!.more,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Utils(context).verticalSpace,
          _buildButtonListtile(
            iconData: Icons.delete_outline,
            tiletitle: AppLocalizations.of(context)!.deleteaccount,
            onTap: () => _deleteAccount(context: context),
          ),
          Utils(context).verticalSpace,
          _buildButtonListtile(
            tiletitle: AppLocalizations.of(context)!.logoutbutton,
            iconData: Icons.logout,
            onTap: () async {
              context.read<AuthrizationProviders>().logout();
              await Utils(context).pushUntil(widget: const Auth());
            },
          ),
        ],
      ),
    );
  }
}
