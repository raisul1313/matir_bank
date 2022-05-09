class AppUser {
  int? userID;
  String? userName;
  String? fullName;
  String? fatherName;
  String? motherName;
  String? address;
  String? phoneNumber;
  String? birthDate;
  String? gender;
  String? password;

  AppUser(
      {this.userID,
      this.userName,
      this.fullName,
      this.fatherName,
      this.motherName,
      this.address,
      this.phoneNumber,
      this.birthDate,
      this.gender,
      this.password});

  AppUser.fromJson(Map<String, dynamic> json) {
    userID = json['user_id'];
    userName = json['user_name'];
    fullName = json['full_name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userID;
    data['user_name'] = this.userName;
    data['full_name'] = this.fullName;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['birth_date'] = this.birthDate;
    data['gender'] = this.gender;
    data['password'] = this.password;
    return data;
  }
}
