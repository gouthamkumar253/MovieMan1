import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_structure/connector/auth_connector.dart';

class LoginPageSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageSample();
  }
}

class _LoginPageSample extends State<LoginPageSample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController =
      TextEditingController(text: 'sampleuser');
  final TextEditingController _emailController =
      TextEditingController(text: 'sampleuser@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'samplepassword');
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: 'samplepassword');
  bool _obscureText = true;

  void _toggle() {
    setState(
      () {
        _obscureText = !_obscureText;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AuthConnector(
      builder: (BuildContext c, AuthViewModel model) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/sign_up_image.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Opacity(
                        opacity: 0.75,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(20.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                elevation: 2.0,
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextFormField(
                                            controller: _usernameController,
                                            keyboardType: TextInputType.text,
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText: 'Username',
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              border: UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            controller: _emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autofocus: false,
                                            validator: (String value) {
                                              if (EmailValidator.validate(
                                                      value) ==
                                                  false) {
                                                return 'Please enter valid email';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Email',
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              border: UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            autofocus: false,
                                            controller: _passwordController,
                                            obscureText: _obscureText,
                                            validator: (String value) {
                                              if (value.length < 6) {
                                                return 'Password should be a minimum of 6 characters';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Password',
                                              suffixIcon: InkWell(
                                                onTap: _toggle,
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20.0, bottom: 0),
                                                  child: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              border: UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            autofocus: false,
                                            controller:
                                                _confirmPasswordController,
                                            obscureText: _obscureText,
                                            validator: (String value) {
                                              if (value.length < 6) {
                                                return 'Password should be a minimum of 6 characters';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Password',
                                              suffixIcon: InkWell(
                                                onTap: _toggle,
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20.0, bottom: 0),
                                                  child: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                              border: UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: FloatingActionButton(
                                  onPressed: null,
                                  child: const Icon(Icons.arrow_forward),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
