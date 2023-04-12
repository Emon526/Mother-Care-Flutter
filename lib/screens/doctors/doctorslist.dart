import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              openFilterDialog(
                context: context,
                doctorlist: context.read<DoctorProvider>().doctorlist,
              );
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: context.watch<DoctorProvider>().filterdoctorList.isNotEmpty
          ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ResponsiveGridView(
                  crossAxisCount: 2,
                  itemCount:
                      context.watch<DoctorProvider>().filterdoctorList.length,
                  itemBuilder: (context, index) {
                    var doctordata =
                        context.watch<DoctorProvider>().filterdoctorList[index];
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
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    );
                  },
                ),
              ),
            )
          : FutureBuilder<List<DoctorModel>>(
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
                    color: Theme.of(context).primaryColor,
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
    // double maxWidth = 210,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      onTap: () {
        onTap();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double containerWidth = constraints.maxWidth;
          final double maxWidth = MediaQuery.of(context).size.width * 0.8;
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Consts.DefaultBorderRadius),
                      child: FutureBuilder(
                        future: context
                            .watch<DoctorProvider>()
                            .getDoctorImage(doctorModel.doctorimagePath),
                        builder: (BuildContext context,
                            AsyncSnapshot<Uint8List?> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!,
                              errorBuilder: (context, error, stackTrace) =>
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.error_outline),
                                  Text('Unable to Load Image'),
                                ],
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.error_outline),
                                Text('Unable to Load Image'),
                              ],
                            );
                          }

                          return const CircularProgressIndicator();
                        },
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

  openFilterDialog({
    required BuildContext context,
    required List<DoctorModel> doctorlist,
  }) {
    final formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Filter Doctor List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Content(
                    title: 'Locations',
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          FormField<List<String>>(
                            autovalidateMode: AutovalidateMode.always,
                            initialValue:
                                context.watch<DoctorProvider>().filterChoice,
                            onSaved: (val) => context
                                .read<DoctorProvider>()
                                .filterChoice = val ?? [],
                            // validator: (value) {
                            //   if (value?.isEmpty ?? value == null) {
                            //     return 'Please select some categories';
                            //   }
                            //   if (value!.length > 5) {
                            //     return "Can't select more than 5 categories";
                            //   }
                            //   return null;
                            // },
                            builder: (state) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: ChipsChoice<String>.multiple(
                                      value: state.value ?? [],
                                      onChanged: (val) => state.didChange(val),
                                      choiceItems:
                                          C2Choice.listFrom<String, String>(
                                        source: context
                                            .watch<DoctorProvider>()
                                            .getAllDoctorLocations(),
                                        value: (index, value) =>
                                            value.toLowerCase(),
                                        label: (index, value) => value,
                                        tooltip: (index, value) => value,
                                      ),
                                      choiceStyle: C2ChipStyle.outlined(
                                        borderWidth: 2,
                                        selectedStyle: C2ChipStyle(
                                          borderColor:
                                              Theme.of(context).primaryColor,
                                          foregroundColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      wrapped: true,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          // const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Apply'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<DoctorProvider>().filterChoice =
                                      [];
                                  context
                                      .read<DoctorProvider>()
                                      .filterdoctorList
                                      .clear();

                                  formKey.currentState!.reset();
                                  Navigator.pop(context);
                                },
                                child: const Text('Reset'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Content extends StatefulWidget {
  final String title;
  final Widget child;

  const Content({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  ContentState createState() => ContentState();
}

class ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          // color: Colors.blueGrey[50],
          child: Text(
            widget.title,
            style: const TextStyle(
              // color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Flexible(fit: FlexFit.loose, child: widget.child),
      ],
    );
  }
}
