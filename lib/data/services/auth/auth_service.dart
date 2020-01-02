import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_structure/data/api/api_client.dart';
import 'package:flutter_structure/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_structure/models/serializers.dart';
import 'package:flutter_structure/models/todo/todo_obj.dart';

class AuthService extends ApiService {
  AuthService({@required ApiClient client}) : super(client: client);

  Future<bool> loginWithPassword() async {
    final ApiResponse<bool> res = await client.callJsonApi<bool>(
        method: Method.POST, path: '/user/login', body: null);
    if (res.isSuccess) {
      return res.data;
    } else {
      throw res.error;
    }
  }

  Future<BuiltList<TodoObject>> getToDoList() async {
    final ApiResponse<BuiltList<TodoObject>> res =
        await client.callJsonApi<BuiltList<TodoObject>>(
            method: Method.GET, path: '/todos', fullType: todoFactory.fullType);
    if (res.isSuccess) {
      return res.data;
    } else {
      throw res.error;
    }
  }
}
