import 'dart:convert';
import 'package:desafio_byebnk/model/user_page_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ApplicationAndRedeemApi {
  Future applicationAndRedeemApi(
      String? token, String? date, double? value, var url) async {
    var headers = {
      "Content-Type": "application/json",
      "Authorization": '$token'
    };
    Map params = {
      "data": date,
      "valor": value,
    };
    var body = json.encode(params);
    var response = await http.put(url, headers: headers, body: body);
    var jsonDecode = json.decode(response.body);
    var application = UserPageModel.fromJson(jsonDecode);
    if (response.statusCode == 201) {
      return application;
    } else {
      return Container(
          child: Center(
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
