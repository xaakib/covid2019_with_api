import 'dart:convert';

import 'package:covid2019_with_api/app/services/api.dart';
import 'package:flutter/cupertino.dart';
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
    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<int> getEnopointData({
    @required String accessToken,
    @required Endpoint endpoint,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
     if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String>, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKey[endpoint];
        final int result = endpointData[responseJsonKey];
        if (result !=null) {
          return result;
          
        }
        
      }
    }
    throw response;
  }

  static Map<Endpoint, String>_responseJsonKey ={
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.caseConfirmed : 'data',
    Endpoint.deaths:'data',
    Endpoint.recovered: 'data',

  };






}
