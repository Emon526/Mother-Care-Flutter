import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../const/consts.dart';
import '../../models/doctormodel.dart';
import '../../providers/doctorprovider.dart';
import '../../utils/exception_hander.dart';
import '../../widget/ResponsiveGridView.dart';
import '../../widget/emptywidget.dart';
import '../../widget/errorwidget.dart';
import 'doctor.dart';
import 'dart:convert';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Doctors",
        ),
      ),
      body: FutureBuilder<List<DoctorModel>>(
        future: context.watch<DoctorProvider>().doctorsList(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<DoctorModel> doctors = snapshot.data!;

            if (doctors.isEmpty) {
              return EmptyWidget(
                onRefresh: () => context.read<DoctorProvider>().refresh(),
                viewPadding: viewPadding,
                size: size,
                svgAsset: 'assets/images/doctor.svg',
                message: 'No Doctor Found!',
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<DoctorProvider>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ResponsiveGridView(
                    crossAxisCount: 2,
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      var doctordata = doctors[index];
                      return _buildDoctorcard(
                        doctorModel: doctordata,
                        context: context,
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: Doctor(
                              doctor: doctordata,
                            ),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            var error = snapshot.error as ErrorModel;

            return CustomErrorWidget(
              onRefresh: () => context.read<DoctorProvider>().refresh(),
              svgAsset: error.url,
              message: error.message,
              size: size,
              viewPadding: viewPadding,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildDoctorcard({
    required BuildContext context,
    required Function onTap,
    required DoctorModel doctorModel,
    double maxWidth = 210,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      onTap: () {
        onTap();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double containerWidth = constraints.maxWidth;
          final double width =
              containerWidth > maxWidth ? maxWidth : containerWidth;
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
            ),
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Consts.DefaultBorderRadius),
                    child: CachedNetworkImage(
                      height: 200,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      width: double.infinity,
                      imageUrl:
                          "data:image/png;base64,${doctorModel.doctorimagePath}",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => Image.memory(
                        base64Decode(doctorModel.doctorimagePath),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        doctorModel.doctorname,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctorModel.speciality,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctorModel.workplace,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
