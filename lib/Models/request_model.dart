class Request {
  String? requestId;
  String? requestUid;
  String? requestedBy;

  Request({this.requestId, this.requestUid, this.requestedBy});

  Request.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    requestUid = json['requestUid'];
    requestedBy = json['requestedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['requestUid'] = this.requestUid;
    data['requestedBy'] = this.requestedBy;
    return data;
  }
}
