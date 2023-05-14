import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../models/doctormodel.dart';
import '../../providers/doctorprovider.dart';
import '../../utils/exception_hander.dart';
import '../../utils/utils.dart';
import '../../widget/emptywidget.dart';
import '../../widget/errorwidget.dart';
import '../../widget/responsivegridview.dart';
import 'doctor.dart';
import 'doctorcard.dart';
import 'doctorlistshimmer.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Consumer<DoctorProvider>(
      builder: (context, doctorProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Doctors",
            ),
            actions: [
              doctorProvider.doctorLocations.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        Utils(context).showCustomDialog(
                          child: _doctorFilterWidget(
                            context: context,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.filter_list,
                        semanticLabel: 'Filters',
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          body: doctorProvider.filterdoctorList.isNotEmpty
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ResponsiveGridView(
                      crossAxisCount: 2,
                      itemCount: doctorProvider.filterdoctorList.length,
                      itemBuilder: (context, index) {
                        var doctordata = doctorProvider.filterdoctorList[index];
                        return DoctorCardWidget(
                          doctorModel: doctordata,
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
                )
              : FutureBuilder<List<DoctorModel>>(
                  future: doctorProvider.doctorsList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      List<DoctorModel> doctors = snapshot.data!;

                      if (doctors.isEmpty) {
                        return EmptyWidget(
                          onRefresh: () => doctorProvider.refresh(),
                          viewPadding: viewPadding,
                          size: size,
                          svgAsset: 'assets/images/doctor.svg',
                          message: 'No Doctor Found!',
                        );
                      }

                      return RefreshIndicator(
                        color: Theme.of(context).primaryColor,
                        onRefresh: () => doctorProvider.refresh(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ResponsiveGridView(
                              crossAxisCount: 2,
                              itemCount: doctors.length,
                              itemBuilder: (context, index) {
                                var doctordata = doctors[index];
                                return DoctorCardWidget(
                                  doctorModel: doctordata,
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
                        onRefresh: () => doctorProvider.refresh(),
                        svgAsset: error.url,
                        message: error.message,
                        size: size,
                        viewPadding: viewPadding,
                      );
                    }

                    return const DoctorsListShimmer();
                  },
                ),
        );
      },
    );
  }

  _doctorFilterWidget({
    required BuildContext context,
  }) {
    final formKey = GlobalKey<FormState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Filter Doctor List',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'Locations',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      // color: Colors.green,
                      // alignment: Alignment.centerLeft,
                      child: FormField<List<String>>(
                        autovalidateMode: AutovalidateMode.always,
                        initialValue:
                            context.read<DoctorProvider>().filterChoice,
                        onSaved: (val) => context
                            .read<DoctorProvider>()
                            .filterChoice = val ?? [],
                        validator: (value) {
                          if (value?.isEmpty ?? value == null) {
                            return 'Please select some locations';
                          }
                          // if (value!.length > 5) {
                          //   return "Can't select more than 5 categories";
                          // }
                          return null;
                        },
                        builder: (state) {
                          return Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChipsChoice<String>.multiple(
                                value: state.value ?? [],
                                onChanged: (val) => state.didChange(val),
                                choiceItems: C2Choice.listFrom<String, String>(
                                  source: context
                                      .watch<DoctorProvider>()
                                      .doctorLocations,
                                  value: (index, value) => value.toLowerCase(),
                                  label: (index, value) => value,
                                  tooltip: (index, value) => value,
                                ),
                                choiceStyle: C2ChipStyle.outlined(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderWidth: 2,
                                  selectedStyle: C2ChipStyle(
                                    borderColor: Theme.of(context).primaryColor,
                                    foregroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                ),
                                wrapped: true,
                              ),
                              if (state.hasError)
                                Text(
                                  state.errorText!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                            context.read<DoctorProvider>().filterChoice = [];
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
              )
            ],
          ),
        )
      ],
    );
  }
}
