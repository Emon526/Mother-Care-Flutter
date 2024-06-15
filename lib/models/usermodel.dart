class UserModel {
  String uid;
  String name;
  String email;
  String dateofbirth;
  String? profilepicture;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.dateofbirth,
    required this.profilepicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'dateofbirth': dateofbirth,
      'uid': uid,
      'profilepicture': profilepicture,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      dateofbirth: json['dateofbirth'],
      uid: json['uid'],
      profilepicture: json['profilepicture'],
    );
  }
}
