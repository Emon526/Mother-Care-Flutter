import 'package:flutter/material.dart';
import 'package:cool_stepper/cool_stepper.dart';

class SelfCheckSteps extends StatefulWidget {
  const SelfCheckSteps({super.key});

  @override
  State<SelfCheckSteps> createState() => _SelfCheckStepsState();
}

class _SelfCheckStepsState extends State<SelfCheckSteps> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final steps = [
      CoolStep(
        isHeaderEnabled: false,
        title: 'Step 1',
        subtitle: 'Begin',
        content: _buildStepCard(
          size: size,
          stepimagepath: 'assets/images/self-check_step_1.jpg',
          steptitle: "Begin",
          stepsubtitle:
              "Start in an upright position, hands on your hips. Look at your breasts with the help of a mirror, your mobile phone, or a friend.",
        ),
        validation: () {},
      ),
      CoolStep(
        isHeaderEnabled: false,
        title: 'Step 2',
        subtitle: 'Look',
        content: _buildStepCard(
          size: size,
          stepimagepath: 'assets/images/self-check_step_2.jpg',
          steptitle: "Look",
          stepsubtitle:
              "Do you see any changes in size, shape or colour. Swelling? Puckering of the skin? Raise your arms and check again.",
        ),
        validation: () {},
      ),
      CoolStep(
        isHeaderEnabled: false,
        title: 'Step 3',
        subtitle: 'Feel',
        content: _buildStepCard(
          size: size,
          stepimagepath: 'assets/images/self-check_step_3.jpg',
          steptitle: "Feel",
          stepsubtitle:
              "Use the pads of your fingers and feel your breast. Follow a pattern. Feel for lumps, hardened knots and thickenings.",
        ),
        validation: () {},
      ),
      CoolStep(
        isHeaderEnabled: false,
        title: 'Step 4',
        subtitle: 'Circles',
        content: _buildStepCard(
          size: size,
          stepimagepath: 'assets/images/self-check_step_4.jpg',
          steptitle: "Circles",
          stepsubtitle:
              "Keep your fingers together and flat. Move in small circles. Repeat using light, medium and then firm pressure. With firm pressure you should feel your ribcage.",
        ),
        validation: () {},
      ),
      CoolStep(
        isHeaderEnabled: false,
        title: 'Step 5',
        subtitle: 'Armpit',
        content: _buildStepCard(
          size: size,
          stepimagepath: 'assets/images/self-check_step_5.jpg',
          steptitle: "Armpit",
          stepsubtitle:
              "Cover all the way up to your armpit. The left hand feels the right side and the right hand feels the left side.",
        ),
        validation: () {},
      ),
      CoolStep(
        isHeaderEnabled: false,
        title: 'Step 6',
        subtitle: 'Nipple',
        content: _buildStepCard(
          size: size,
          stepimagepath: 'assets/images/self-check_step_6.jpg',
          steptitle: "Nipple",
          stepsubtitle: "Squeeze the nipple. Is there any unusual discharge?",
        ),
        validation: () {},
      ),
      CoolStep(
        isHeaderEnabled: false,
        title: 'Step 7',
        subtitle: 'Lie down',
        content: _buildStepCard(
          size: size,
          stepimagepath: 'assets/images/self-check_step_7.jpg',
          steptitle: "Lie down",
          stepsubtitle:
              "Lie down so the tissue spreads out evenly. Repeat the examination of your breasts.",
        ),
        validation: () {},
      ),
    ];

    return FutureBuilder(
      future: _showDialog(context),
      builder: (context, snapshot) => Scaffold(
        body: CoolStepper(
          showErrorSnackbar: false,
          onCompleted: () {
            // print('Steps completed!');
          },
          steps: steps,
          config: const CoolStepperConfig(
            backText: 'PREV',
          ),
        ),
      ),
    );
  }

  _buildStepCard({
    required Size size,
    required String stepimagepath,
    required String steptitle,
    required String stepsubtitle,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          width: size.width,
          child: Text(
            steptitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 50,
          ),
          child: Column(
            children: [
              Image.asset(
                stepimagepath,
                width: size.width / 2,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                stepsubtitle,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )
      ],
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
