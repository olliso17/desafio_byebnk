import 'dart:convert';
import 'package:desafio_byebnk/urls/urls.dart';
import 'package:desafio_byebnk/model/user_page_model.dart';
import 'package:http/http.dart' as http;

abstract class MovementApi {
  Future<List<UserPageModel>> movementApi(String? token) async {
    var headers = {
      "Authorization": '$token',
    };

    var response = await http.get(kUrlMovement, headers: headers);
    var jsonDecode = await json.decode(response.body);
    List<UserPageModel> movements = [];
    jsonDecode['movimentacoes'].forEach((v) {
      movements.add(UserPageModel.fromJson(v));
    });

    if (response.statusCode == 200) {
      return movements;
    }
    return <UserPageModel>[];
  }
}
