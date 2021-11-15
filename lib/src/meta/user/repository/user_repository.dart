import 'dart:convert';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobtora/src/meta/constants.dart';
import 'package:jobtora/src/meta/credentials/cloudinary_credentials.dart';
import 'package:http/http.dart' as http;
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/models/saved_posts_model.dart';

abstract class UserRepository {
  Future<String?>? uploadUserImage();
  Future<String?> savePost(int postId);
  Future<SavedPostsModel?> getSavedPosts();
}

class UserImpl extends UserRepository {
  @override
  Future<String?>? uploadUserImage() async {
    String userToken = await HiveImpl().getData("token", "auth");

    var updateImageUrl =
        ApiRoutes.baseUrl + ApiRoutes.updateUserImage + userToken;

    print(updateImageUrl);

    final _cloudinary = new Cloudinary(CloudinaryCredentials.ApiKey,
        CloudinaryCredentials.ApiSecret, CloudinaryCredentials.CloudName);
    try {
      String? imageLink;

      var filePath = await this.pickImage();

      print(filePath?.path);

      await _cloudinary
          .uploadFile(
              folder: "profile images",
              filePath: filePath?.path,
              //  fileName: filePath?.name,
              resourceType: CloudinaryResourceType.image)
          .then((value) {
        imageLink = value.secureUrl;
      });

      await http.post(Uri.parse(updateImageUrl),
          headers: {"Accept": "application/json"},
          body: {"userimage": imageLink});

      return imageLink;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<XFile?>? pickImage() async {
    final _file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (_file == null) {
      return null;
    } else {
      return _file;
    }
  }

  @override
  Future<String?> savePost(int postId) async {
    var token = await HiveImpl().getData("token", "auth");

    var response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + "/api/save_or_unsave/$postId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    var jsonData = jsonDecode(response.body);

    return jsonData["message"];
  }

  @override
  Future<SavedPostsModel?> getSavedPosts() async {
    var token = await HiveImpl().getData("token", "auth");

    try {
      var response = await http
          .get(Uri.parse(ApiRoutes.baseUrl + "/api/get_saved"), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      print(jsonDecode(response.body));

      SavedPostsModel model = savedPostsModelFromJson(response.body);

      return model;
    } catch (e) {
      print(e);

      return null;
    }
  }
}
