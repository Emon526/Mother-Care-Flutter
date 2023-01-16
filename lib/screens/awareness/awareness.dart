import 'package:flutter/material.dart';

class Awareness extends StatefulWidget {
  const Awareness({super.key});

  @override
  State<StatefulWidget> createState() => _AwarenessState();
}

class _AwarenessState extends State<Awareness> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.pink[300],
                          child: const Text(
                            "BCR",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const ListTile(
              title: Text("About"),
              leading: Icon(Icons.settings, color: Colors.pinkAccent),
              //trailing: Icon(Icons.list),
            ),
            const ListTile(
              title: Text("Diagnosis"),
              leading: Icon(
                Icons.account_box_sharp,
                color: Colors.pinkAccent,
              ),
              //trailing: Icon(Icons.account_box_sharp),
            ),
            const ListTile(
              title: Text("Awareness"),
              leading: Icon(Icons.theaters, color: Colors.pinkAccent),
              //trailing: Icon(Icons.theaters),
            ),
            const ListTile(
              title: Text("Others"),
              leading: Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.pinkAccent,
              ),
              //trailing: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Image(image: AssetImage("app_images/awareness-icon.png")),
              ),*/
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
        ),
      ),
    );
  }
}
