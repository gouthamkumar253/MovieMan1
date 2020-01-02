import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_structure/actions/auth/auth_action.dart';
import 'package:flutter_structure/data/api/api_routes.dart';
import 'package:flutter_structure/data/app_repository.dart';
import 'package:flutter_structure/data/preference_client.dart';
import 'package:flutter_structure/middleware/middleware.dart';
import 'package:flutter_structure/models/models.dart';
import 'package:flutter_structure/reducers/reducers.dart';
import 'package:flutter_structure/theme.dart';
import 'package:flutter_structure/views/init_page.dart';
import 'package:flutter_structure/views/movies/movies_list.dart';
import 'package:flutter_structure/views/movies/page_content.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final AppRepository repository = AppRepository(
      preferencesClient: PreferencesClient(prefs: prefs),
      config: ApiRoutes.debugConfig);

  runApp(
    MyApp(
      repository: repository,
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key, AppRepository repository})
      : store = Store<AppState>(
          reducer,
          middleware: middleware(repository),
          initialState: AppState.initState(),
        ),
        super(key: key);

  final Store<AppState> store;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      content: Text("Item has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    print('Show item Dialog menu is called');
  }

  String targetToken;
  FirebaseMessaging messaging = new FirebaseMessaging();

  Store<AppState> store;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    print('Init State is being called');
    final int id = DateTime.now().millisecondsSinceEpoch;
    messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        //store.state.navigator.currentState.push(
         // MaterialPageRoute<BuildContext>(
           // builder: (_) => const PageContent(
             //     value: 2,
               // ),
          //),
        //);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        store.state.navigator.currentState.push(
          MaterialPageRoute<BuildContext>(
            builder: (_) => MoviesList(),
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume:-  This is the message  $message');
        store.state.navigator.currentState.push(
          MaterialPageRoute<BuildContext>(
            builder: (_) => const PageContent(
              value: 1,
            ),
          ),
        );
      },
    );

    messaging.getToken().then(
      (final String token) {
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
    // Request Notification permission on iOS devices
    messaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, alert: true, badge: true),
    );

    messaging.onIosSettingsRegistered.listen(
      (IosNotificationSettings setting) {
        print('Settings Configured');
      },
    );

    super.initState();
    store = widget.store;

    _init();
  }

  void _init() {
    Future<void>.delayed(
      const Duration(seconds: 2),
      () {
        store.dispatch(new CheckForUserInPrefs());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        navigatorKey: store.state.navigator,
        title: 'MyApp',
        theme: themeData,
        home: InitPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
