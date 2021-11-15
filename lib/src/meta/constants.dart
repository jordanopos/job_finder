import 'package:flutter/foundation.dart';

class ApiRoutes {
  ApiRoutes._();
  static String baseUrl = kIsWeb?  "http://127.0.0.1:8000" :  'http://10.0.2.2:8000';
  static String login = "/api/login";
  static String register = "/api/register";
  static String updateUserImage = "/user/update/";
}
