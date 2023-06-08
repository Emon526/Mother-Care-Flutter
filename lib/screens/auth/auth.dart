import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../providers/authprovider.dart';
import '../../widget/persistent_nav_bar.dart';
import 'login.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return StreamBuilder<User?>(
          stream: value.auth.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const PersistentNavBar();
            }
            return const LoginScreen();
          },
        );
      },
    );
  }
}
