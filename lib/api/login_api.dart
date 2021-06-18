import 'dart:convert';
import 'package:desafio_byebnk/urls/urls.dart';
import 'package:desafio_byebnk/model/user_page_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  Future login(String? username, String? password) async {
    var headers = {
      "Content-Type": "application/json",
    };
    Map params = {
      "username": username,
      "password": password,
    };
    var body = json.encode(params);
    var response = await http.post(kUrlLogin, headers: headers, body: body);
    var jsonDecode = await json.decode(response.body);
    final user = UserPageModel.fromJson(jsonDecode);

    if (response.statusCode == 200) {
      return user;
    } else {
      return Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'A página se encontra com erro ${response.statusCode}, verifique sua conexão ou reinicie seu aplicativo',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Caso o erro persista, entre em contato...',
              style: TextStyle(fontSize: 20),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ));
    }
  }
}
