import 'package:flutter_structure/actions/actions.dart';
import 'package:flutter_structure/data/app_repository.dart';
import 'package:flutter_structure/data/services/auth/auth_service.dart';
import 'package:flutter_structure/models/models.dart';
import 'package:redux/redux.dart';

class AuthMiddleware {
  AuthMiddleware({this.repository})
      : authService = repository.getService<AuthService>();

  final AppRepository repository;
  final AuthService authService;

  List<Middleware<AppState>> createAuthMiddleware() {
    return <Middleware<AppState>>[
      new TypedMiddleware<AppState, CheckForUserInPrefs>(checkForUserInPrefs),
      new TypedMiddleware<AppState, LoginWithPassword>(loginWithPassword),
      new TypedMiddleware<AppState,LogOutUser>(logOutUser)
    ];
  }

  void checkForUserInPrefs(Store<AppState> store, CheckForUserInPrefs action,
      NextDispatcher next) async {
    next(action);
    try {
      final AppUser user = await repository.getUserFromPrefs();
      if (user != null) {
        store.dispatch(new SaveUser(userDetails: user));
      } else {
        store.dispatch(new SaveUser(userDetails: null));
      }
    } catch (e) {
      return;
    }
  }

  void loginWithPassword(Store<AppState> store, LoginWithPassword action,
      NextDispatcher next) async {
    try {
      //make api call example with auth actions
//      await authService.loginWithPassword();
    //for now set user value and set login
      final AppUser dummyAppUser = new AppUser(
              (AppUserBuilder b) {
            b
              ..name = action.username
              ..password=action.password
              ..userId = 0;
          }
      );

      repository.setUserPrefs(appUser: dummyAppUser);
      store.dispatch(new SaveUser(userDetails: dummyAppUser));
    } on ApiError catch (e) {
      print(e.errorMessage);
      action.onError(e.errorMessage);
      return;
    } catch(e){
      action.onError('Something went wrong');
    }
    next(action);
  }

  void logOutUser(Store<AppState> store, LogOutUser action,
      NextDispatcher next) async {
    repository.setUserPrefs(appUser: null);
    store.dispatch(new SaveUser(userDetails: null));
    next(action);
  }
}
