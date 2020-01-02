import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_structure/connector/auth_connector.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: 'sampleuser@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'samplepassword');
  final Hero logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('assets/logo.png'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AuthConnector(
      builder: (BuildContext c, AuthViewModel model) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                const SizedBox(height: 48.0),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        validator: (String value) {
                          if (EmailValidator.validate(value) == false) {
                            return 'Please enter valid email';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: _passwordController,
                        obscureText: true,
                        validator: (String value) {
                          if (value.length < 6) {
                            return 'Password should be a minimum of 6 characters';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                model.login(
                                  _emailController.text,
                                  _passwordController.text,
                                  (String s) {
                                    print('Error call back $s');
                                  },
                                );
                              }
                            },
                            padding: const EdgeInsets.all(12),
                            color: Colors.lightBlueAccent,
                            child: Text('Log In',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
