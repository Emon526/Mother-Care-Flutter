import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/nav_bar_provider.dart';

class Awareness extends StatelessWidget {
  const Awareness({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      _buildHeader(
          context: context,
          headerTitle: "Check your breasts",
          headerSubtitle: "Save Your Lives",
          imagePath: 'assets/images/body.png'),
      _buildHeader(
          context: context,
          headerTitle: "Check your breasts",
          headerSubtitle: "Save Your Lives",
          imagePath: 'assets/images/bca_darkskintype.jpg'),
      _buildHeader(
        context: context,
        headerTitle: "Get the free",
        headerSubtitle: "SELF CHECK GUIDE",
        imagePath: 'assets/images/shutterstock_1797240619.jpg',
      ),
    ];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
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
              SizedBox(
                // height: 20,
                height: size.height * 0.03,
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
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              const Text(
                "The earlier breast cancer is is treated, the greater the chance of long-term survival. Regular self-checks can help you detect problems earlier and get treatment faster.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<NavBarProvider>().setControllerIndex = 1;
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
              SizedBox(
                // height: 20,
                height: size.height * 0.03,
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
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              const Text(
                "Checking your breasts for changes each month is free, easy and might save your life.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              const Text(
                "Why? Because the earlier signs of breast cancer are detected and treated, the better the chances of recovery.\n\nRegular check-ups with your gynaecologist or trusted health professional can help to detect breast cancer at an early stage. Your doctor may also recommend a mammogram.\n\nBut you can do more to protect yourself by checking your own breasts regularly!\n\nRegular self-checks are the best way to get to know what is normal for you, and will help you notice changes more quickly. The faster you notice, the sooner you'll be able to react and get treatment if needed.\n\nAnd if there's one thing we know about breast cancer, it's that the earlier it's treated, the greater the likelihood of survival.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                // height: 20,
                height: size.height * 0.03,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<NavBarProvider>().setControllerIndex = 2;
                },
                child: const Text('How to self-check'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader({
    required String headerTitle,
    required String headerSubtitle,
    required String imagePath,
    required BuildContext context,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            headerTitle,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            headerSubtitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
