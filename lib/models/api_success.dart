/**
 * Created By: Hemanth Raj V
 */

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_success.g.dart';

abstract class ApiSuccess implements Built<ApiSuccess, ApiSuccessBuilder> {
  factory ApiSuccess([ApiSuccessBuilder updates(ApiSuccessBuilder builder)]) =
      _$ApiSuccess;

  ApiSuccess._();

  int get status;

  String get message;

  static Serializer<ApiSuccess> get serializer => _$apiSuccessSerializer;
}
