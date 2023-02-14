import 'package:flutter/material.dart';

import '../../widget/drawer_widget.dart';

class Doctor extends StatelessWidget {
  const Doctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dr.Jakaria Sajib',
        ),
      ),
      drawer: const DrawerWidget(),
      body: const Placeholder(),
    );
  }
}
