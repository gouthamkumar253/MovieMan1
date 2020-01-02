import 'package:flutter/material.dart';
import 'package:flutter_structure/connector/auth_connector.dart';
import 'package:flutter_structure/connector/todo_connector.dart';
import 'package:flutter_structure/models/todo/todo_obj.dart';
import 'package:flutter_structure/views/accounts/app_drawer.dart';

// multiple connector example  uses auth_connector and todo_connector
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthConnector(
      builder: (BuildContext authContext, AuthViewModel authModel) {
        return TodoConnector(
          builder: (BuildContext c, TodoViewModel model) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    'Home Page for ${authModel.currentUser?.name ?? 'no user'}'),
                actions: <Widget>[
                  new IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: () {
                      model.getList();
                    },
                  ),
                ],
              ),
              drawer: AppDrawer(),
              body: Center(
                child: model.isLoading
                    ? const CircularProgressIndicator()
                    : model.toDoList.isEmpty
                        ? new Container(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
                                model.getList();
                              },
                              child: const Text('Get List'),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: model.toDoList?.length ?? 0,
                            itemBuilder: (BuildContext context, int i) {
                              return _buildRow(object: model.toDoList[i]);
                            },
                          ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRow({TodoObject object}) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(5.0), child: new Text(object.title)),
      elevation: 5.0,
    );
  }
}

//single connector example

//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return TodoConnector(
//      builder: (BuildContext c, TodoViewModel model) {
//        return Scaffold(
//          appBar: AppBar(
//            title: const Text('Home Page'),
//            actions: <Widget>[
//              new IconButton(
//                  icon: const Icon(Icons.file_download),
//                  onPressed: () {
//                    model.getList();
//                  }),
//            ],
//          ),
//          drawer: AppDrawer(),
//          body: ListView.builder(
//              padding: const EdgeInsets.all(16.0),
//              itemCount: model.toDoList?.length ?? 0,
//              itemBuilder: (BuildContext context, int i) {
//                return _buildRow(object: model.toDoList[i]);
//              }),
//        );
//      },
//    );
//  }
//
//  Widget _buildRow({TodoObject object}) {
//    return Card(
//      child: Container(padding: const EdgeInsets.all(5.0),child: new Text(object.title)),
//      elevation: 5.0,
//    );
//  }
//}
