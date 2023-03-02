class DoctorModel {
  String id;
  String doctorname;
  String speciality;
  String degree;
  String workplace;
  String patient;
  String experience;
  String review;
  String bioGraphy;
  String appointmentNumber;
  String doctorimagePath;
  String location;

  DoctorModel({
    required this.id,
    required this.doctorname,
    required this.speciality,
    required this.degree,
    required this.workplace,
    required this.patient,
    required this.experience,
    required this.review,
    required this.bioGraphy,
    required this.doctorimagePath,
    required this.appointmentNumber,
    required this.location,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'],
      doctorname: map['doctorname'],
      speciality: map['speciality'],
      degree: map['degree'],
      workplace: map['workplace'],
      patient: map['patient'],
      experience: map['experience'],
      review: map['review'],
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
