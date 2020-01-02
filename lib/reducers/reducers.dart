import 'package:flutter_structure/models/models.dart';
import 'package:flutter_structure/reducers/auth/auth_reducer.dart';
import 'package:flutter_structure/reducers/todo/todo_reducer.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  authReducer,
  todoReducer,
]);
