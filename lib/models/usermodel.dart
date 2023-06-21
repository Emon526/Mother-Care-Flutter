class UserModel {
  String uid;
  String firstName;
  String lastName;
  String email;
  String dateofbirth;
  String profilepicture;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateofbirth,
    required this.profilepicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dateofbirth': dateofbirth,
      'uid': uid,
      'profilepicture': profilepicture,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      dateofbirth: json['dateofbirth'],
      uid: json['uid'],
      profilepicture: json['profilepicture'],
    );
  }
}
