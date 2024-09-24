import 'dart:convert';

class TaskModel {
  String title;
  String? subTitle;
  bool isCompleted;
  String createdAt;

  TaskModel({
    required this.title,
    this.subTitle,
    this.isCompleted = false,
    required this.createdAt,
  });




  factory TaskModel.fromRawJson(String str) =>
      TaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        subTitle: json["sub_title"],
        isCompleted: json["is_completed"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sub_title": subTitle,
        "is_completed": isCompleted,
        "created_at": createdAt,
      };
}
