import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:meta/meta.dart';
import 'package:flutter_structure/data/api/api_client.dart';
import 'package:flutter_structure/models/serializers.dart';

// Any api service should extend this class
abstract class ApiService {
  const ApiService({@required this.client}) : assert(client != null);

  final ApiClient client;

  Map<String, String> get defaultHeaders => client.defaultHeaders;

  Map<String, String> get authHeaders => client.authHeaders;

  Map<String, String> getAllHeaders({Map<String, String> headers}) {
    return <String, String>{}
      ..addAll(client.defaultHeaders)
      ..addAll(client.authHeaders ?? <String, String>{})
      ..addAll(headers ?? <String, String>{});
  }

  String buildUrl({String path, Map<String, dynamic> queryParams}) =>
      client.buildUrl(path: path, queryParams: queryParams);

  Map<String, dynamic> buildBodyFrom<T>(
    T data, {
    List<String> keysToRemove,
    Map<String, dynamic> dataToAdd,
    String withRootKey,
  }) {
    final Map<String, dynamic> body = serialize<T>(data);
    keysToRemove?.forEach(body.remove);
    body.addAll(dataToAdd ?? <String, dynamic>{});
    if (withRootKey != null) {
      final Map<String, dynamic> withRoot = <String, dynamic>{};
      withRoot[withRootKey] = body;
      return withRoot;
    }
    return body;
  }

  String encode(dynamic data) {
    return json.encode(data);
  }

  dynamic decode(String data) {
    return json.decode(data);
  }

  Object serializeQuery<T>(T query, {FullType fullType}) {
    if (query == null) {
      return null;
    }

    return serialize<T>(query, fullType: fullType);
  }

  Object serialize<T>(T data, {FullType fullType}) {
    return serializers.serialize(
      data,
      specifiedType: fullType ?? FullType(T),
    );
  }

  T deserialize<T>(Object data, {FullType fullType}) {
    return serializers.deserialize(
      data,
      specifiedType: fullType ?? FullType(T),
    );
  }
}
