import 'dart:convert';

import 'package:jobtora/src/meta/constants.dart';
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:jobtora/src/meta/user/repository/user_repository.dart';

abstract class DetailsRepository {
  Future<PostModel?> getPostDetails(int id);

  Future<bool?> applyForPost(int id);

  Future<String?> saveOrUnsavePost(int id, UserRepository repo);
}

class DetailsImpl extends DetailsRepository {
  @override
  Future<PostModel?> getPostDetails(int id) async {
    try {
      var token = await HiveImpl().getData("token", "auth");

      var response = await http
          .get(Uri.parse(ApiRoutes.baseUrl + "/api/post/$id"), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      print(response.body);

      PostModel model = PostModel.fromJson(jsonDecode(response.body)["post"]);

      print(model.jobTitle);

      return model;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<String?> saveOrUnsavePost(int id, UserRepository repo) async {
    String? response = await repo.savePost(id);

    return response;
  }

  @override
  Future<bool?> applyForPost(int id) async {
    var token = await HiveImpl().getData("token", "auth");

    var response = await http
        .post(Uri.parse(ApiRoutes.baseUrl + "/api/apply/$id"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    var jsonData = jsonDecode(response.body);

    // print(jsonData);

    return jsonData["applied"];
  }
}
