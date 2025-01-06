import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../models/doctormodel.dart';
import '../../providers/doctorprovider.dart';
import '../../providers/languageprovider.dart';
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
        var doctorLocations = getAllDoctorLocations(
          doctorlist: doctorProvider.doctorlist,
          locale: context.watch<LanguageProvider>().languageCode,
        );
        List<DoctorModel> filterdoctorList = getFilteredDoctor(
          doctorlist: doctorProvider.doctorlist,
          locale: context.watch<LanguageProvider>().languageCode,
          searchQuery: context.read<DoctorProvider>().filterChoice,
        );
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.doctors,
            ),
            actions: [
              doctorLocations.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        Utils(context).showCustomDialog(
                          child: _doctorFilterWidget(
                            context: context,
                            doctorLocations: doctorLocations,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.filter_list,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          body: filterdoctorList.isNotEmpty
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ResponsiveGridView(
                      itemCount: filterdoctorList.length,
                      itemBuilder: (context, index) {
                        var doctordata = filterdoctorList[index];
                        return DoctorCardWidget(
                          doctorModel: doctordata,
                          onTap: () async {
                            await Utils(context).push(
                              widget: Doctor(
                                doctor: doctordata,
                              ),
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
                          message: AppLocalizations.of(context)!.nodoctorfound,
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
                              itemCount: doctors.length,
                              itemBuilder: (context, index) {
                                var doctordata = doctors[index];
                                return DoctorCardWidget(
                                  doctorModel: doctordata,
                                  onTap: () async {
                                    await Utils(context).push(
                                      widget: Doctor(
                                        doctor: doctordata,
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

  List<DoctorModel> getFilteredDoctor({
    required List<String> searchQuery,
    required List<DoctorModel> doctorlist,
    required String locale,
  }) {
    return doctorlist.where((doctor) {
      final doctorLocation = doctor.location[locale].toString().toLowerCase();
      return searchQuery
          .any((query) => doctorLocation.contains(query.toLowerCase()));
    }).toList();
  }

  List<String> getAllDoctorLocations(
      {required List<DoctorModel> doctorlist, required String locale}) {
    Set<String> uniqueLocations = <String>{};
    for (DoctorModel doctor in doctorlist) {
      uniqueLocations.add(doctor.location[locale]);
    }
    List<String> doctorLocations = uniqueLocations.toList()..sort();
    return doctorLocations;
  }

  _doctorFilterWidget({
    required BuildContext context,
    required List<String> doctorLocations,
  }) {
    final formKey = GlobalKey<FormState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.filterDoctorList,
          style: const TextStyle(
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  AppLocalizations.of(context)!.locations,
                  style: const TextStyle(
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
                            return AppLocalizations.of(context)!
                                .filterDoctorListError;
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
                                  source: doctorLocations,
                                  value: (index, value) => value.toLowerCase(),
                                  label: (index, value) => value,
                                  tooltip: (index, value) => value,
                                ),
                                choiceStyle: C2ChipStyle.outlined(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color,
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
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.applybutton,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<DoctorProvider>().filterChoice = [];
                              // context
                              //     .read<DoctorProvider>()
                              //     .filterdoctorList
                              //     .clear();
                              //     filterdoctorList.

                              formKey.currentState!.reset();
                              Navigator.pop(context);
                            },
                            child: Text(
                                AppLocalizations.of(context)!.resetbutton,
                                textAlign: TextAlign.center),
                          ),
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
