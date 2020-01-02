import 'package:flutter_structure/actions/actions.dart';
import 'package:flutter_structure/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

part 'auth_connector.g.dart';

typedef LoginAction = void Function(
    String email, String username, ValueChanged<String> onError);
typedef LogOutAction = void Function();

abstract class AuthViewModel
    implements Built<AuthViewModel, AuthViewModelBuilder> {
  factory AuthViewModel(
          [AuthViewModelBuilder updates(AuthViewModelBuilder builder)]) =
      _$AuthViewModel;

  AuthViewModel._();

  factory AuthViewModel.fromStore(Store<AppState> store) {
    return AuthViewModel((AuthViewModelBuilder b) {
      b
        ..isInitializing = store.state.isInitializing
        ..currentUser = store.state.currentUser?.toBuilder()
        ..login =
            (String username, String password, ValueChanged<String> onError) {
          store.dispatch(LoginWithPassword(
              username: username, password: password, onError: onError));
        }
        ..logOut = () {
          store.dispatch(LogOutUser());
        };
    });
  }

  LoginAction get login;

  LogOutAction get logOut;

  //  get userDetails;
  @nullable
  AppUser get currentUser;

  bool get isInitializing;
}

class ResetAction {}

//class LoginWithEmail {}

class AuthConnector extends StatelessWidget {
  const AuthConnector({@required this.builder});

  final ViewModelBuilder<AuthViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      builder: builder,
      converter: (Store<AppState> store) => AuthViewModel.fromStore(store),
    );
  }
}
