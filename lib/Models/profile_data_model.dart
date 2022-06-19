import 'package:blood_donation/Models/request_form_model.dart';
import 'package:blood_donation/Models/request_model.dart';

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
  String? uid;
  Map<dynamic, dynamic>? requestList;
  bool? isAvailable;

  UserDetailModel(
      {this.uid,
      this.address,
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
      this.sex,
      this.requestList,
      this.isAvailable});

  UserDetailModel.fromJson(Map json, String key) {
    uid = key;
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
    requestList = json['requestList'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['age'] = age;
    data['bloodGroup'] = bloodGroup;
    data['city'] = city;
    data['contactNo'] = contactNo;
    data['dateOfBirth'] = dateOfBirth;
    data['dateOfLastDonationOfBlood'] = dateOfLastDonationOfBlood;
    data['emailAddress'] = emailAddress;
    data['isDonatedBloodBefore'] = isDonatedBloodBefore;
    data['isMedico'] = isMedico;
    data['medicalCollege'] = medicalCollege;
    data['name'] = name;
    data['nearByBloodBank'] = nearByBloodBank;
    data['noOfAchievments'] = noOfAchievments;
    data['noOfBloodDonations'] = noOfBloodDonations;
    data['profilePhoto'] = profilePhoto;
    data['sex'] = sex;
    data['requestList'] = requestList;
    data['isAvailable'] = isAvailable;
    return data;
  }
}
