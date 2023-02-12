import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'self_check_steps.dart';

class SelfCheckPage extends StatefulWidget {
  const SelfCheckPage({super.key});

  @override
  State<SelfCheckPage> createState() => _SelfCheckPageState();
}

class _SelfCheckPageState extends State<SelfCheckPage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> items = [
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
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "WHAT TO LOOK FOR",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Theme.of(context).primaryColor),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider(
              items: items,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                viewportFraction: 0.8,
                aspectRatio: 1.1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < items.length; i++)
                  if (i == _current)
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.07,
                          height: size.width * 0.03,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 5.0,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
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
      ],
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
        children: [
          Image.asset(
            imagepath,
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
          Expanded(
            child: Text(
              subtitle,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
