import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../providers/authprovider.dart';
import '../../widget/sliding_clipped_nav_bar.dart';
import 'login.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthrizationProviders>(
      builder: (context, value, child) {
        return StreamBuilder<User?>(
          stream: value.auth.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const SlidingClippedNavBarWidget();
            }
            return const LoginScreen();
          },
        );
      },
    );
  }
}
