import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_structure/actions/todo/todo_action.dart';
import 'package:flutter_structure/models/app_state.dart';
import 'package:flutter_structure/models/todo/todo_obj.dart';
import 'package:redux/redux.dart';

part 'todo_connector.g.dart';

typedef getToDoListAction = void Function();

abstract class TodoViewModel
    implements Built<TodoViewModel, TodoViewModelBuilder> {
  factory TodoViewModel(
          [TodoViewModelBuilder updates(TodoViewModelBuilder builder)]) =
      _$TodoViewModel;

  TodoViewModel._();

  factory TodoViewModel.fromStore(Store<AppState> store) {
    return TodoViewModel((TodoViewModelBuilder b) {
      b
      ..isLoading = store.state.isLoading
        ..getList = () {
          store.dispatch(GetTodoList());
        }
        ..toDoList = store.state.todoList?.toList() ?? <TodoObject>[];
    });
  }

  getToDoListAction get getList;

  List<TodoObject> get toDoList;

  bool get isLoading;
}

class TodoConnector extends StatelessWidget {
  const TodoConnector({@required this.builder});

  final ViewModelBuilder<TodoViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodoViewModel>(
      builder: builder,
      converter: (Store<AppState> store) => TodoViewModel.fromStore(store),
    );
  }
}
