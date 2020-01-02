import 'package:built_collection/built_collection.dart';
import 'package:flutter_structure/actions/actions.dart';
import 'package:flutter_structure/data/app_repository.dart';
import 'package:flutter_structure/data/services/auth/auth_service.dart';
import 'package:flutter_structure/models/models.dart';
import 'package:flutter_structure/models/todo/todo_obj.dart';
import 'package:redux/redux.dart';

class TodoMiddleware {
  TodoMiddleware({this.repository})
      : authService = repository.getService<AuthService>();

  final AppRepository repository;
  final AuthService authService;

  List<Middleware<AppState>> createAuthMiddleware() {
    return <Middleware<AppState>>[
      new TypedMiddleware<AppState, GetTodoList>(getTodoList),
    ];
  }
  void getTodoList(Store<AppState> store, GetTodoList action,
      NextDispatcher next) async {
    next(action);
    try {
      //make api call example with auth actions
      final BuiltList<TodoObject> list = await authService.getToDoList();
      store.dispatch(SetTodoList(toDoList: list));
    } on ApiError catch (e) {
      print(e.errorMessage);
      return;
    } catch(e){
      print('error catch block - get todo list ${e.toString()}');
    }
  }
}
