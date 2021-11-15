// To parse this JSON data, do
//
//     final savedPostsModel = savedPostsModelFromJson(jsonString);

import 'package:jobtora/src/meta/models/post_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

SavedPostsModel savedPostsModelFromJson(String str) =>
    SavedPostsModel.fromJson(json.decode(str));

class SavedPostsModel {
  SavedPostsModel({
    required this.posts,
  });

  final List<PostElement> posts;

  factory SavedPostsModel.fromJson(Map<String, dynamic> json) =>
      SavedPostsModel(
        posts: List<PostElement>.from(
            json["posts"].map((x) => PostElement.fromJson(x))),
      );
}

class PostElement {
  PostElement({
    required this.id,
    required this.userId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
    required this.post,
  });

  final int id;
  final int userId;
  final int postId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PostModel post;

  factory PostElement.fromJson(Map<String, dynamic> json) => PostElement(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        post: PostModel.fromJson(json["post"]),
      );
}
