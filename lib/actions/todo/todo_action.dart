import 'package:built_collection/built_collection.dart';
import 'package:flutter_structure/models/todo/todo_obj.dart';

class GetTodoList {}

class SetTodoList {
  SetTodoList({this.toDoList});

  final BuiltList<TodoObject> toDoList;
}
class FireDispatch{

}