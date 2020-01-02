import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'todo_obj.g.dart';
abstract class TodoObject implements Built<TodoObject, TodoObjectBuilder>{
  factory TodoObject([TodoObjectBuilder updates(TodoObjectBuilder builder)]) = _$TodoObject;

  TodoObject._();

  int get userId;

  int get id;

  String get title;

  bool get completed;

  static Serializer<TodoObject> get serializer => _$todoObjectSerializer;

}