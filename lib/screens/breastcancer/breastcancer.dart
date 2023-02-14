import 'package:flutter/material.dart';

import '../../const/consts.dart';
import '../../widget/drawer_widget.dart';

class BreastCancerPage extends StatelessWidget {
  const BreastCancerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            Consts.APP_NAME,
          ),
        ),
        drawer: const DrawerWidget(),
        body: const Placeholder());
  }
}
