import 'package:flutter_structure/actions/actions.dart';
import 'package:flutter_structure/models/app_state.dart';
import 'package:redux/redux.dart';

Reducer<AppState> todoReducer = combineReducers(<Reducer<AppState>>[
  new TypedReducer<AppState, SetTodoList>(setTodoList),
  new TypedReducer<AppState, GetTodoList>(getTodoList),
]);

AppState setTodoList(AppState state, SetTodoList action) {
  final AppStateBuilder b = state.toBuilder();
  b
    ..todoList = action.toDoList?.toBuilder()
    ..isLoading = false;
  return b.build();
}

AppState getTodoList(AppState state, GetTodoList action) {
  final AppStateBuilder b = state.toBuilder();
  b..isLoading = true;
  return b.build();
}
