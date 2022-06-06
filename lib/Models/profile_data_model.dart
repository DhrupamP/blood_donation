class UserDetailModel {
  String? address;
  int? age;
  String? bloodGroup;
  String? city;
  int? contactNo;
  String? dateOfBirth;
  String? dateOfLastDonationOfBlood;
  String? emailAddress;
  bool? isDonatedBloodBefore;
  bool? isMedico;
  String? medicalCollege;
  String? name;
  String? nearByBloodBank;
  int? noOfAchievments;
  int? noOfBloodDonations;
  String? profilePhoto;
  String? sex;

  UserDetailModel(
      {this.address,
      this.age,
      this.bloodGroup,
      this.city,
      this.contactNo,
      this.dateOfBirth,
      this.dateOfLastDonationOfBlood,
      this.emailAddress,
      this.isDonatedBloodBefore,
      this.isMedico,
      this.medicalCollege,
      this.name,
      this.nearByBloodBank,
      this.noOfAchievments,
      this.noOfBloodDonations,
      this.profilePhoto,
      this.sex});

  UserDetailModel.fromJson(Map<dynamic, dynamic> json) {
    address = json['address'];
    age = json['age'];
    bloodGroup = json['bloodGroup'];
    city = json['city'];
    contactNo = json['contactNo'];
    dateOfBirth = json['dateOfBirth'];
    dateOfLastDonationOfBlood = json['dateOfLastDonationOfBlood'];
    emailAddress = json['emailAddress'];
    isDonatedBloodBefore = json['isDonatedBloodBefore'];
    isMedico = json['isMedico'];
    medicalCollege = json['medicalCollege'];
    name = json['name'];
    nearByBloodBank = json['nearByBloodBank'];
    noOfAchievments = json['noOfAchievments'];
    noOfBloodDonations = json['noOfBloodDonations'];
    profilePhoto = json['profilePhoto'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['age'] = this.age;
    data['bloodGroup'] = this.bloodGroup;
    data['city'] = this.city;
    data['contactNo'] = this.contactNo;
    data['dateOfBirth'] = this.dateOfBirth;
    data['dateOfLastDonationOfBlood'] = this.dateOfLastDonationOfBlood;
    data['emailAddress'] = this.emailAddress;
    data['isDonatedBloodBefore'] = this.isDonatedBloodBefore;
    data['isMedico'] = this.isMedico;
    data['medicalCollege'] = this.medicalCollege;
    data['name'] = this.name;
    data['nearByBloodBank'] = this.nearByBloodBank;
    data['noOfAchievments'] = this.noOfAchievments;
    data['noOfBloodDonations'] = this.noOfBloodDonations;
    data['profilePhoto'] = this.profilePhoto;
    data['sex'] = this.sex;
    return data;
  }
}
