import 'package:flutter/material.dart';
import '../../const/consts.dart';
import '../../widget/drawer_widget.dart';
import 'doctor.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Doctors",
        ),
      ),
      // drawer: const DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 15,
            itemBuilder: (context, index) {
              return _buildDoctorcard(
                context: context,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Doctor(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorcard(
      {required BuildContext context, required Function onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Consts.DefaultBorderRadius),
                  child: Image.asset(
                    'assets/images/doctor.jpg',
                    height: 400,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Dr.Jakaria Sajib',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Medicine'),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Dhaka Medical College'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
