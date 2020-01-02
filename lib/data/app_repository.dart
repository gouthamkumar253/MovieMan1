import 'dart:async';

import 'package:flutter_structure/data/services/auth/auth_service.dart';
import 'package:flutter_structure/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_structure/data/api/api_client.dart';
import 'package:flutter_structure/data/app_repository_provider.dart';
import 'package:flutter_structure/data/preference_client.dart';
import 'package:flutter_structure/data/services/api_service.dart';

class AppRepository {
  AppRepository({@required this.preferencesClient, @required this.config})
      : assert(preferencesClient != null && config != null) {
    apiClient = ApiClient(config: config);
    services = <ApiService>[
      AuthService(client: apiClient),
    ];
  }

  final PreferencesClient preferencesClient;
  final ApiConfig config;
  ApiClient apiClient;

  // All available services list
  List<ApiService> services;

  static AppRepository of(BuildContext context) {
    final AppRepositoryProvider provider =
        context.inheritFromWidgetOfExactType(AppRepositoryProvider);
    if (provider == null) {
      throw 'AppRepositoryProvider not found';
    }

    return provider.repository;
  }

  ApiService getService<T>() {
    return services.firstWhere((ApiService s) => s is T, orElse: () => null) ??
        (throw 'Service Not Found. Make sure to include in app repository services.');
  }

  // get Appuser data from shared preference called at initial state.
  Future<AppUser> getUserFromPrefs() async {
    return preferencesClient.getUser();
  }

  // save Appuser data to shared preference
  Future<void> setUserPrefs({AppUser appUser}) async {
    preferencesClient.saveUser(appUser: appUser);
  }

}
