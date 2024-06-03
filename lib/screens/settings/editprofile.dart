// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../models/usermodel.dart';
import '../../providers/authprovider.dart';
import '../../services/permissionservice.dart';
import '../../utils/utils.dart';
import '../../widget/customexpandedbutton.dart';
import '../../widget/showcalenderwidget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  ImagePicker picker = ImagePicker();
  File? pickedimage;
  DateTime date = DateTime.now().subtract(
    const Duration(days: 30),
  );
  UserModel? user;

  PermissionService permissionService = PermissionService();

  @override
  void initState() {
    super.initState();
    // Initialize form fields with user data
    user = context.read<AuthrizationProviders>().user!;
    nameController.text = user!.name;
    dobController.text = user!.dateofbirth;
    emailController.text = user!.email;
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    context.read<PermissionService>().photosStatus =
        await permissionService.hasPermission(Permission.photos);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.editprofilebutton,
        ),
      ),
      body: Consumer<AuthrizationProviders>(
          builder: (context, authprovider, child) {
        return _buildProfile(
          context: context,
          size: size,
          user: authprovider.user!,
          onTap: () async {
            Utils(context).customLoading();
            try {
              await authprovider.updateUserData(
                name: nameController.text,
                email: user!.email,
                dob: dobController.text,
                profilephoto: pickedimage,
              );
              Navigator.pop(context);
            } on FirebaseAuthException catch (e) {
              await Utils(context).showsnackbar(message: e.message!);
            }
            Navigator.pop(context);
          },
        );
      }),
    );
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
      },
    );
  }

  Widget _buildProfile({
    required BuildContext context,
    required Size size,
    required Function() onTap,
    required UserModel user,
  }) {
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
              child: pickedimage != null
                  ? userpickedImage(size: size)
                  : user.profilepicture != null
                      ? userProfilePicture(user: user, size: size)
                      : usernoprofilepicture(size: size),
            ),
          ),
          Utils(context).verticalSpace,
          TextFormField(
            onEditingComplete: () {
              nameFocusNode.unfocus();
              _showCalender();
            },
            focusNode: nameFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
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
            onTap: () => _showCalender(),
            readOnly: true,
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
            controller: emailController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.email,
              hintText: AppLocalizations.of(context)!.email,
              border: const OutlineInputBorder(),
            ),
          ),
          Utils(context).verticalSpace,
          Text(
            AppLocalizations.of(context)!.emailchangenotice,
          ),
          const Spacer(),
          CustomExpanedButton(
            onPressed: onTap,
            text: AppLocalizations.of(context)!.updatebutton,
          )
        ],
      ),
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

  Widget userpickedImage({required Size size}) {
    return Stack(
      children: [
        CircleAvatar(
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
        ),
        Positioned(
          bottom: 0,
          right: 100,
          child: InkWell(
            onTap: () {
              context.read<PermissionService>().photosStatus.isGranted
                  ? pickImage()
                  : context
                          .read<PermissionService>()
                          .photosStatus
                          .isPermanentlyDenied
                      ? permissionService.showPermissionDeniedDialog(context)
                      : requestPermission();
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

  void requestPermission() async {
    context.read<PermissionService>().photosStatus =
        await Permission.photos.request();
  }

  Widget usernoprofilepicture({required Size size}) {
    return Stack(
      children: [
        Icon(
          Icons.account_circle,
          size: size.height * 0.2,
          // color: iconColor,
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: InkWell(
            onTap: () {
              context.read<PermissionService>().photosStatus.isGranted
                  ? pickImage()
                  : context
                          .read<PermissionService>()
                          .photosStatus
                          .isPermanentlyDenied
                      ? permissionService.showPermissionDeniedDialog(context)
                      : requestPermission();
            },
            child: Icon(
              Icons.add_a_photo_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget userProfilePicture({required UserModel user, required Size size}) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: user.profilepicture!,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: size.height * 0.1,
            backgroundColor: Theme.of(context).colorScheme.secondary,
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
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: InkWell(
            onTap: () {
              context.read<PermissionService>().photosStatus.isGranted
                  ? pickImage()
                  : context
                          .read<PermissionService>()
                          .photosStatus
                          .isPermanentlyDenied
                      ? permissionService.showPermissionDeniedDialog(context)
                      : requestPermission();
            },
            child: Icon(
              Icons.change_circle_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
