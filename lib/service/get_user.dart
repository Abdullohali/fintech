import 'package:http/http.dart' as http;
import 'package:lesson_for_fintech/model/hive_user.dart';

class GetUsers {
  //SERVICE FOR FETCH API FROM INTERNET
  Future<List<HiveUser>> getAllUsers() async {
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var data = hiverUsersFromJson(response.body);
        return data;
      }
    } catch (e) {
      print("error $e");
      return [];
    }
    return [];
  }
}
