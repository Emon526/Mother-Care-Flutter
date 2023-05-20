import 'dart:convert';

class DoctorModel {
  dynamic doctorname;
  dynamic speciality;
  dynamic degree;
  dynamic workplace;
  int experience;
  double rating;
  dynamic bioGraphy;
  String appointmentNumber;
  String doctorimagePath;
  dynamic location;

  DoctorModel({
    required this.doctorname,
    required this.speciality,
    required this.degree,
    required this.workplace,
    required this.experience,
    required this.rating,
    required this.bioGraphy,
    required this.doctorimagePath,
    required this.appointmentNumber,
    required this.location,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    final decodeddoctorname = json.decode(map['doctorname']);
    final decodedspeciality = json.decode(map['speciality']);
    final decodeddegree = json.decode(map['degree']);
    final decodedworkplace = json.decode(map['workplace']);
    final decodedbiography = json.decode(map['biography']);
    final decodedlocation = json.decode(map['location']);
    return DoctorModel(
      doctorname: decodeddoctorname,
      speciality: decodedspeciality,
      degree: decodeddegree,
      workplace: decodedworkplace,
      experience: int.parse(map['experience']),
      rating: double.parse(map['rating']),
      bioGraphy: decodedbiography,
      doctorimagePath: map['image'],
      appointmentNumber: map['appointmentNumber'],
      location: decodedlocation,
    );
  }
}
