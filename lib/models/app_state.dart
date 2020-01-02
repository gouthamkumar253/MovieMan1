import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:flutter_structure/models/models.dart';
import 'package:flutter_structure/models/todo/todo_obj.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([AppStateBuilder updates(AppStateBuilder builder)]) =
      _$AppState;

  AppState._();

  static AppState initState() {
    return new AppState((AppStateBuilder b) {
      b..navigator = GlobalKey<NavigatorState>()
      ..isInitializing = true
      ..isLoading = false;
    });
  }
  
  GlobalKey<NavigatorState> get navigator;

  //  get userDetails;
  @nullable
  AppUser get currentUser;

  bool get isInitializing;

  bool get isLoading;

  @nullable
  BuiltList<TodoObject> get todoList;
}
