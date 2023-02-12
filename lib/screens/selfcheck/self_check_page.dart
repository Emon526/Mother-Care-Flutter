import 'package:flutter/material.dart';
import 'package:mothercare/screens/selfcheck/self_check_steps.dart';

class SelfCheckPage extends StatelessWidget {
  const SelfCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "WHAT TO LOOK FOR",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildDataCard(
            size: size,
            imagepath: 'assets/images/change_1.jpeg',
            title: "Lumps, knots, thickening",
            subtitle:
                "Lumps, hardened knots or thickenings in the breast tissue can be a sign of breast cancer. They can occur right under the skin, in the middle of the breast or in the deep tissue near the bones.",
          ),
          _buildDataCard(
            size: size,
            imagepath: 'assets/images/change_2.jpeg',
            title: "Changes in size or shape",
            subtitle:
                "Unusual changes in size, contour or shape should be checked. The same is true for distortions or swellings. Keep in mind that your left and right breast might look different. Know what is normal for you.",
          ),
          _buildDataCard(
            size: size,
            imagepath: 'assets/images/change_3.jpeg',
            title: "Skin changes",
            subtitle:
                "There should be no strange wrinkling or bulging of the skin. Get checked if there is any persistent redness, soreness or rash, especially if only on one side.",
          ),
          _buildDataCard(
            size: size,
            imagepath: 'assets/images/change_4.jpeg',
            title: "Nipple discharge",
            subtitle:
                "The nipple should look normal to you, and should be free from irritation. Check for unusual discharge of fluid or blood.",
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              // log('Navigate to Cancer Details Page');
              // context.read<NavBarProvider>().selectedIndex = 1;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelfCheckSteps(),
                  ));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('CHECK YOURSELF STEP BY STEP'),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.arrow_forward_ios_outlined),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _buildDataCard({
    required Size size,
    required String imagepath,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagepath,
            // height: size.width / 2,
            width: size.width / 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
