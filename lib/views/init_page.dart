import 'package:flutter_structure/connector/auth_connector.dart';
import 'package:flutter_structure/views/firebase_setup.dart';
import 'package:flutter_structure/views/home/home_page.dart';
import 'package:flutter_structure/views/loader/app_loader.dart';
import 'package:flutter_structure/views/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_structure/views/movies/movies_list.dart';
class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    FireBaseNotifications().setUpFireBase(context);

    return AuthConnector(
      builder: (BuildContext c, AuthViewModel model) {
        if (model.isInitializing) {
          return AppLoader();
        }
        return model.currentUser == null ? LoginPage() : MoviesList();
      },
    );
  }
}
