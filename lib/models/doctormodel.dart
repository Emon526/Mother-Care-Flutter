class DoctorModel {
  String doctorname;
  String speciality;
  String degree;
  String workplace;
  String experience;
  String rating;
  String bioGraphy;
  String appointmentNumber;
  String doctorimagePath;
  String location;

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
    return DoctorModel(
      doctorname: map['doctorname'],
      speciality: map['speciality'],
      degree: map['degree'],
      workplace: map['workplace'],
      experience: map['experience'],
      rating: map['rating'],
      bioGraphy: map['biography'],
      doctorimagePath: map['image'],
      appointmentNumber: map['appointmentNumber'],
      location: map['location'],
    );
  }
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'userid': userid,
  //     'title': title,
  //     'content': content,
  //     'dateAdded': dateAdded!.toIso8601String()
  //   };
  // }
}
