import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_structure/views/movies/movies_list.dart';
import 'package:path/path.dart';

class FireBaseNotifications extends StatelessWidget {
  FireBaseNotifications({Key key, this.context}) : super(key: key);

  final BuildContext context;
  FirebaseMessaging _fireBaseMessaging;

  void setUpFireBase(BuildContext context) {
    _fireBaseMessaging = FirebaseMessaging();
    fireBaseCloudMessaging_Listeners();
  }

  void fireBaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();
    final int id = DateTime.now().millisecondsSinceEpoch;

    _fireBaseMessaging.getToken().then(
      (final String token) {
        print(id.toString() + '-' + token);
        final DocumentReference document =
            Firestore.instance.document('users/$id');
        final DocumentReference doc =
            Firestore.instance.document('token/$token');
// Store target token list
        final Map<String, String> tokenData = <String, String>{'token': token};
        doc.setData(tokenData).whenComplete(
          () {
            print('Document Added to tokens');
          },
        ).catchError((dynamic e) => print(e.toString()));
//Entry into users collection
        final Map<String, String> data = <String, String>{'token': token};
        document.setData(data).whenComplete(
          () {
            print('Document Added to users');
          },
        ).catchError((dynamic e) => print(e.toString()));
      },
    );

    _fireBaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume: $message');
        await Navigator.of(context).push(
          MaterialPageRoute<BuildContext>(
              builder: (BuildContext context) => MoviesList()),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        await Navigator.of(context).push(
          MaterialPageRoute<BuildContext>(
              builder: (BuildContext context) => MoviesList()),
        );
      },
    );
  }

  void iOS_Permission() {
    _fireBaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _fireBaseMessaging.onIosSettingsRegistered.listen(
      (IosNotificationSettings settings) {
        print('Settings registered: $settings');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('Hello World');
  }
}
