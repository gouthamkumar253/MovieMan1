import 'package:flutter_structure/data/api/api_client.dart';

class ApiRoutes {
//  https://jsonplaceholder.typicode.com/todos/
  static const ApiConfig debugConfig = ApiConfig(
    scheme: 'https',
    host: 'jsonplaceholder.typicode.com',
//    port: 443,
    scope: debugScope,
  );

  static const ApiConfig prodConfig = ApiConfig(
    scheme: 'https',
    host: 'example.com',
    port: 443,
    scope: scope,
  );

  //Scope
  static const String debugScope = '';
  static const String scope = '/api/v1';
}
