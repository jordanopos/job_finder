import 'dart:convert';

import 'package:jobtora/src/meta/models/company_model.dart';

PostModel welcomeFromJson(String? str) => PostModel.fromJson(json.decode(str!));

class PostModel {
  PostModel({
    required this.id,
    required this.companyId,
    required this.genreId,
    required this.jobTitle,
    required this.payExpected,
    required this.jobDetails,
    required this.expiresAt,
    required this.visible,
    required this.banned,
    required this.approved,
    required this.jobType,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.viewsCount,
    required this.applications,
    required this.company,
    required this.saves,
  });

  final int? id;
  final int? companyId;
  final int? genreId;
  final String jobTitle;
  final String payExpected;
  final List<dynamic> jobDetails;
  final int? expiresAt;
  final bool visible;
  final bool banned;
  final bool approved;
  final String jobType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int? viewsCount;
  final List<Application> applications;
  final Company company;
  final List<dynamic>? saves;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      id: json["id"] == null ? null : json["id"],
      companyId: json["company_id"] ?? null,
      genreId: json["genre_id"] ?? null,
      jobTitle: json["job_title"] ?? null,
      payExpected: json["pay_expected"] ?? null,
      jobDetails: json["job_details"],
      expiresAt: json["expires_at"] ?? null,
      visible: json["visible"] ?? null,
      banned: json["banned"] ?? null,
      approved: json["approved"] ?? null,
      jobType: json["job_type"] ?? null,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"] ?? null,
      viewsCount: json["views_count"] ?? null,
      applications: List<Application>.from(
          json["applications"].map((x) => Application.fromJson(x))),
      company:
          Company.fromJson(json["company"]),
      saves: json["saves"]);
}

class Application {
  Application({
    required this.id,
    required this.userId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final int? postId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Application.fromJson(Map<String?, dynamic> json) => Application(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "post_id": postId == null ? null : postId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
