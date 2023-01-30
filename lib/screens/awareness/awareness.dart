import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Awareness extends StatelessWidget {
  const Awareness({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColor,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: 8,
              child: Image.asset('assets/images/body.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Flexible(
              flex: 2,
              child: Text(
                "Check your breasts",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Flexible(
              flex: 3,
              child: Text(
                "Save Your Lives",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bca_darkskintype.jpg'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              "Check your breasts",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Save Your Lives",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/shutterstock_1797240619.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              "Get the free",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "SELF CHECK GUIDE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ];
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: items,
              options: CarouselOptions(
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                // enlargeFactor: 0.3,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Early Detection Saves Lives",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "The earlier breast cancer is is treated, the greater the chance of long-term survival. Regular self-checks can help you detect problems earlier and get treatment faster.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                log('Navigate to Cancer Details Page');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Learn more'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "WHY IT MATTERS",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Checking your breasts for changes each month is free, easy and might save your life.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Why? Because the earlier signs of breast cancer are detected and treated, the better the chances of recovery.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Regular check-ups with your gynaecologist or trusted health professional can help to detect breast cancer at an early stage. Your doctor may also recommend a mammogram.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "But you can do more to protect yourself by checking your own breasts regularly!",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Regular self-checks are the best way to get to know what is normal for you, and will help you notice changes more quickly. The faster you notice, the sooner you'll be able to react and get treatment if needed.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "And if there's one thing we know about breast cancer, it's that the earlier it's treated, the greater the likelihood of survival.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                log('Naviagte to self check page');
              },
              child: const Text('How to self-check'),
            ),
          ],
        ),
      ),
    );
  }
}
