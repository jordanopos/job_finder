import 'package:jobtora/src/meta/constants.dart';
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/models/result_model.dart';
import 'package:http/http.dart' as http;

abstract class SearchRepository {
  Future<ResultModel?> getResults(String term);
    Future<ResultModel?> getMoreResults(String url);

}

class SearchImpl extends SearchRepository {
  @override
  Future<ResultModel?> getResults(String term) async {
    try {
      var token = await HiveImpl().getData("token", "auth");

   //   print(token);
      final response = await http.get(
          Uri.parse(ApiRoutes.baseUrl + "/api/search&term=$term"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

    //  print(response.body);

      ResultModel model = resultModelFromJson(response.body);

      return model;
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  @override
  Future<ResultModel?> getMoreResults(String url) async{
      try {
      var token = await HiveImpl().getData("token", "auth");

    //  print(token);
      final response = await http.get(
          Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

     // print(response.body);

      ResultModel model = resultModelFromJson(response.body);

      return model;
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}
