import 'package:flutter/material.dart';

class SelfCheckSteps extends StatelessWidget {
  const SelfCheckSteps({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _showDialog(context),
      builder: (context, snapshot) => const Scaffold(
        body: Placeholder(),
      ),
    );
  }

  Future<void> _showDialog(
    BuildContext context,
  ) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Text(
                    'Helpful Hint : Shower',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/shower.jpg',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'You can do your self-check under the shower. Sometimes it’s easier when the breast is wet and soapy.',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
