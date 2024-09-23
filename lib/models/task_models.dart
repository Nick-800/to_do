import 'dart:convert';

class TaskModel {
    String title;
    String? subTitle;
    bool status;
    DateTime createdAt;
    TaskModel({
        required this.title,
        this.subTitle,
        this.status = false,
        required this.createdAt,
    });

    factory TaskModel.fromRawJson(String str) => TaskModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        subTitle: json["sub_title"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"])
        );

    Map<String, dynamic> toJson() => {
        "title": title,
        "sub_title": subTitle,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}