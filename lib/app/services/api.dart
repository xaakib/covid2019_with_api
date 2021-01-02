import 'package:covid2019_with_api/app/services/api_keys.dart';
import 'package:flutter/cupertino.dart';

class API {
  final String apiKey;

  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.ncovSanboxKey);
  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );
}
