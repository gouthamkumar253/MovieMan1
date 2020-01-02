import 'package:flutter_structure/actions/actions.dart';
import 'package:flutter_structure/models/app_state.dart';
import 'package:redux/redux.dart';

Reducer<AppState> authReducer = combineReducers(<Reducer<AppState>>[
  new TypedReducer<AppState, SaveUser>(setUser),
  new TypedReducer<AppState, LogOutUser>(logOutUser),
]);

AppState setUser(AppState state, SaveUser action) {
  final AppStateBuilder b = state.toBuilder();
  b
    ..isInitializing = false
    ..currentUser = action.userDetails?.toBuilder();
  return b.build();
}

AppState logOutUser(AppState state, LogOutUser action) {
  final AppStateBuilder b = state.toBuilder();
  b
    ..isInitializing = false
    ..currentUser = null;
  return b.build();
}

