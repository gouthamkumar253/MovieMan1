import 'package:flutter/material.dart';
import 'package:flutter_structure/connector/auth_connector.dart';
import 'package:flutter_structure/views/movies/movies_list.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthConnector(
      builder: (BuildContext c, AuthViewModel model) {
        return Drawer(
          child: Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName:
                    Text(model.currentUser.name.split('@').first.toString()),
                accountEmail: Text(model.currentUser.password),
                currentAccountPicture: CircleAvatar(
                  child: Image.asset('assets/man.png'),
                ),
                otherAccountsPictures: const <Widget>[
                  const CircleAvatar(
                    child: const Text('BB'),
                  ),
                ],
              ),
              ListTile(
                title: const Text('Movies'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<BuildContext>(
                        builder: (BuildContext context) => MoviesList()),
                  );
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    const Text('other menu goes here'),
                  ],
                ),
              ),
              SafeArea(
                child: ListTile(
                  leading: const Icon(Icons.delete_sweep),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.of(context).pop();
                    model.logOut();
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
