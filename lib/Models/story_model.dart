class StoryModel {
  String? description;
  String? photoURL;
  String? postCreationDate;
  String? title;

  StoryModel(
      {this.description, this.photoURL, this.postCreationDate, this.title});

  StoryModel.fromJson(Map<dynamic, dynamic> json) {
    description = json['description'];
    photoURL = json['photoURL'];
    postCreationDate = json['postCreationDate'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['photoURL'] = this.photoURL;
    data['postCreationDate'] = this.postCreationDate;
    data['title'] = this.title;
    return data;
  }
}
