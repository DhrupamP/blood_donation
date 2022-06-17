class RequestModel {
  String? bloodGroup;
  String? bloodRequirementForm;
  String? dateCreated;
  String? donorID;
  String? donorName;
  bool? isResolved;
  String? mainProblem;
  String? nearByBloodBank;
  int? patientAge;
  String? patientIDPhoto;
  String? patientId;
  String? patientName;
  String? requirementType;
  String? status;
  String? yourLocation;

  RequestModel(
      {this.bloodGroup,
      this.bloodRequirementForm,
      this.dateCreated,
      this.donorID,
      this.donorName,
      this.isResolved,
      this.mainProblem,
      this.nearByBloodBank,
      this.patientAge,
      this.patientIDPhoto,
      this.patientId,
      this.patientName,
      this.requirementType,
      this.status,
      this.yourLocation});

  RequestModel.fromJson(Map<dynamic, dynamic> json) {
    bloodGroup = json['bloodGroup'];
    bloodRequirementForm = json['bloodRequirementForm'];
    dateCreated = json['dateCreated'];
    donorID = json['donorID'];
    donorName = json['donorName'];
    isResolved = json['isResolved'];
    mainProblem = json['mainProblem'];
    nearByBloodBank = json['nearByBloodBank'];
    patientAge = json['patientAge'];
    patientIDPhoto = json['patientIDPhoto'];
    patientId = json['patientId'];
    patientName = json['patientName'];
    requirementType = json['requirementType'];
    status = json['status'];
    yourLocation = json['yourLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bloodGroup'] = bloodGroup;
    data['bloodRequirementForm'] = bloodRequirementForm;
    data['dateCreated'] = dateCreated;
    data['donorID'] = donorID;
    data['donorName'] = donorName;
    data['isResolved'] = isResolved;
    data['mainProblem'] = mainProblem;
    data['nearByBloodBank'] = nearByBloodBank;
    data['patientAge'] = patientAge;
    data['patientIDPhoto'] = patientIDPhoto;
    data['patientId'] = patientId;
    data['patientName'] = patientName;
    data['requirementType'] = requirementType;
    data['status'] = status;
    data['yourLocation'] = yourLocation;
    return data;
  }
}
