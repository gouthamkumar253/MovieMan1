import 'dart:convert';

import 'package:flutter_structure/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesClient {
  PreferencesClient({this.prefs});

  final SharedPreferences prefs;

  AppUser getUser() {
    final String userString = prefs.getString('appUser');
    if (userString == null) {
      return null;
    }
    final dynamic user = json.decode(userString);
    return serializers.deserializeWith(AppUser.serializer, user);
  }

  void saveUser({AppUser appUser}) {
    if (appUser == null) {
      prefs.setString('appUser', null);
      return null;
    }
    final dynamic user = serializers.serializeWith(AppUser.serializer, appUser);
    final String userString = json.encode(user);
    prefs.setString('appUser', userString);
  }
}
