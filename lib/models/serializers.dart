import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:flutter_structure/models/models.dart';
import 'package:flutter_structure/models/todo/todo_obj.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[
  //models
  Pagination,
  ApiError,
  ApiSuccess,
  AppUser,
  TodoObject,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(new StandardJsonPlugin())
      ..addBuilderFactory(
        todoFactory.fullType,
        todoFactory.function,
      ))
    .build();

ListFactory<TodoObject> todoFactory = ListFactory<TodoObject>();

class ListFactory<T> {
  final FullType fullType = FullType(BuiltList, <FullType>[FullType(T)]);
  final Function function = () => ListBuilder<T>();
}
