import 'package:flutter/material.dart';

class Awareness extends StatelessWidget {
  const Awareness({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.20,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              children: const [
                Text(
                  "Help Support Women In Need",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We provide help and inspire hope to those affected by breast cancer through early detection, education, and support services",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: screenHeight * 0.20,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              children: const [
                Text(
                  "We Are Making Progress",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Breast cancer death rates declined 40% from 2018 to 2021 among women. The progress is attributed to improvements in early detection.",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: screenHeight * 0.20,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              children: const [
                Text(
                  "Breast Health Education",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  " Together with our outreach partners, we're empowering women to take control of their health by educating them about their body and providing important breast cancer resources",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: screenHeight * 0.20,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              children: const [
                Text(
                  "Navigating Breast Cancer In The Workplace",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  " We're here to help your employees at every step of the breast health journey - from wellness education to survivor support and everything in between.",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: screenHeight * 0.20,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              children: const [
                Text(
                  "Breast Cancer Research",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  " NBCF supports research projects to study and improve existing programs in order to help improve quality of life for metastatic breast cancer patients and their caregivers as well as increase access to knowledge",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
