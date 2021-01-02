import 'dart:convert';

import 'package:covid2019_with_api/app/services/api.dart';
import 'package:http/http.dart' as http;

class APIServices {
  final API api;

  APIServices(this.api);

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    throw response;
  }
}
