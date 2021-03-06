class UserData {
  String userId;
  String email;
  int group;

  UserData({this.userId, this.email, this.group});

  Map<String, dynamic> toMap() {
    return {"userId": this.userId, "email": this.email, "group": this.group};
  }

  UserData.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    userId = json["userId"];
    group = json["group"];
  }
}
