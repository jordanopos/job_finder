import 'dart:convert';

import 'package:jobtora/src/meta/models/post_model.dart';

ResultModel resultModelFromJson(String str) =>
    ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  ResultModel({
    required this.resultCount,
    required this.results,
  });

  int resultCount;
  Results results;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        resultCount: json["result_count"],
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "result_count": resultCount,
      };
}

class Results {
  Results({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int? currentPage;
  List<PostModel> data;
  String firstPageUrl;
  int? from;
  int? lastPage;
  String lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        currentPage: json["current_page"] ?? null,
        data: List<PostModel>.from(
            json["data"].map((x) => PostModel.fromJson(x))),
        firstPageUrl: json["first_page_url"] ?? null,
        from: json["from"] ?? null,
        lastPage: json["last_page"] ?? null,
        lastPageUrl: json["last_page_url"] ?? null,
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? "empty" : json["next_page_url"],
        path: json["path"] ?? null,
        perPage: json["per_page"] ?? null,
        prevPageUrl: json["prev_page_url"] ?? null,
        to: json["to"] ?? null,
        total: json["total"] ?? null,
      );

}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
