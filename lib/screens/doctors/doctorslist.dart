import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../const/consts.dart';
import '../../models/doctormodel.dart';
import '../../providers/doctorprovider.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: context.watch<DoctorProvider>().doctorlist.length,
            itemBuilder: (context, index) {
              var doctordata =
                  context.watch<DoctorProvider>().doctorlist[index];
              return _buildDoctorcard(
                doctorModel: doctordata,
                context: context,
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: Doctor(
                      doctor: doctordata,
                    ),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorcard({
    required BuildContext context,
    required Function onTap,
    required DoctorModel doctorModel,
  }) {
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
                    doctorModel.doctorimagePath,
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
                  children: [
                    Text(
                      doctorModel.doctorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(doctorModel.speciality),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(doctorModel.medicalCollege),
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
