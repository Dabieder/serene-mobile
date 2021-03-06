import 'package:serene/shared/enums.dart';

class Goal {
  String id;
  String goalText;
  DateTime deadline;
  int progress;
  String progressIndicator;
  String difficulty;
  String userId;
  String parentId;
  String path;
  DateTime creationDate;
  DateTime completionDate;

  Goal(
      {this.id,
      this.goalText = "",
      this.deadline,
      this.progress = 0,
      this.userId = "",
      this.parentId = "",
      this.path = "",
      this.difficulty = GoalDifficulty.medium,
      this.creationDate,
      this.completionDate,
      this.progressIndicator = GoalProgressIndicator.checkbox}) {
    this.creationDate = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "goalText": this.goalText,
      "deadline": this.deadline?.toIso8601String() ?? "",
      "creationDate": this.creationDate?.toIso8601String() ?? "",
      "completionDate": this.completionDate?.toIso8601String() ?? "",
      "progress": this.progress,
      "progressIndicator": this.progressIndicator,
      "difficulty": this.difficulty,
      "userId": this.userId,
      "parentId": this.parentId,
      "path": this.path
    };
  }

  Goal.fromDocument(dynamic map) {
    DateTime deadline;
    if (map["deadline"] != "") {
      deadline = DateTime.parse(map["deadline"]);
    }
    DateTime creationDate;
    if (map["creationDate"] != "") {
      creationDate = DateTime.parse(map["creationDate"]);
    }
    this.deadline = deadline;
    this.creationDate = creationDate;
    this.goalText = map["goalText"];
    this.progress = map["progress"];
    this.userId = map["userId"];
    this.progressIndicator = map["progressIndicator"];
    this.difficulty = map["difficulty"];
    this.parentId = map["parentId"];
    this.path = map["path"];
    this.id = map.documentID;
  }

  Goal.fromMap(Map<String, dynamic> map) {
    DateTime deadline;
    if (map["deadline"] != "") {
      deadline = DateTime.parse(map["deadline"]);
    }
    DateTime creationDate;
    if (map["creationDate"] != "") {
      creationDate = DateTime.parse(map["creationDate"]);
    }
    this.deadline = deadline;
    this.creationDate = creationDate;
    this.goalText = map["goalText"];
    this.progress = map["progress"];
    this.userId = map["userId"];
    this.progressIndicator = map["progressIndicator"];
    this.difficulty = map["difficulty"];
    this.parentId = map["parentId"];
    this.path = map["path"];
    this.id = map["id"].toString();
  }
}
