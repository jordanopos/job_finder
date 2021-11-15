import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobtora/src/meta/constants.dart';
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/models/auth_user_model.dart';

abstract class AuthenticationRepository {
  Future<ResponseWrapper?>? signUp(UserAuthModel model);
  Future<ResponseWrapper?>? login(UserAuthModel model);
}

class AuthImpl extends AuthenticationRepository {
  @override
  Future<ResponseWrapper?>? signUp(UserAuthModel userAuthModel) async {
    try {
      final response = await http.post(
          Uri.parse(ApiRoutes.baseUrl + ApiRoutes.register),
          headers: {"Accept": "application/json"},
          body: userAuthModel.toJson());

      var jsonData = jsonDecode(response.body);
      var wrapper = ResponseWrapper(jsonData['token'], jsonData["message"], jsonData["errors"]);

   //   print(jsonData);

      if (response.statusCode != 200) {
        return wrapper;
      } else {
        return wrapper;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ResponseWrapper?>? login(UserAuthModel userAuthModel) async {
    try {
   //   print(userAuthModel.email);
    //  print(userAuthModel.password);

      final response =
          await http.post(Uri.parse(ApiRoutes.baseUrl + ApiRoutes.login),
              headers: {
                'Accept': 'application/json',
              },
              body: userAuthModel.loginToJson());

      var jsonData = jsonDecode(response.body);

      var wrapper = ResponseWrapper(jsonData["token"], jsonData["message"], jsonData["errors"]);

      if (response.statusCode != 200) {
        return wrapper;
      } else {
        return wrapper;
      }
    } catch (e) {
      print("$e");
      return null;
    }
  }
}

class ResponseWrapper {
  final Map<String, dynamic>? error;
  final String? token;
  final String? message;

  ResponseWrapper(this.token, this.message, this.error);
}
