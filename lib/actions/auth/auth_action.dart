import 'package:flutter_structure/models/app_user.dart';
import 'package:flutter/material.dart';

class CheckForUserInPrefs {}

class LoginWithPassword {
  LoginWithPassword({this.username, this.password, this.onError});

  final ValueChanged<String> onError;
  final String username;
  final String password;
}

class SaveUser {
  SaveUser({this.userDetails});

  final AppUser userDetails;
}

class LogOutUser{

}
