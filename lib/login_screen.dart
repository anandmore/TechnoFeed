import 'package:flutter/material.dart';
import './primary_button.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);
  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  static final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;
  String _authHint = '';
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password);
        setState(() {
          _authHint = 'Signed In\n\nUser id: $userId';
        });
        widget.onSignIn();
      } catch (e) {
        setState(() {
          _authHint = 'Sign In Error\n\n${e.toString()}';
        });
        print(e);
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _authHint = '';
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _authHint = '';
    });
  }

  List<Widget> usernameAndPassword() {
    return [
      padded(
          child: new TextFormField(
        key: new Key('email'),
        decoration: new InputDecoration(labelText: 'Email'),
        style: new TextStyle(
          fontFamily: 'Ubuntu',
          color: Colors.black,
        ),
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Email can\'t be empty.' : null,
        onSaved: (val) => _email = val,
      )),
      padded(
          child: new TextFormField(
        key: new Key('password'),
        decoration: new InputDecoration(labelText: 'Password'),
        style: new TextStyle(
          fontFamily: 'Ubuntu',
          color: Colors.black,
        ),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
        onSaved: (val) => _password = val,
      )),
    ];
  }

  List<Widget> submitWidgets() {
    switch (_formType) {
      case FormType.login:
        return [
          Padding(
            padding: const EdgeInsets.fromLTRB(9.0, 25.0, 9.0, 0.0),
            child: new PrimaryButton(
                key: new Key('login'),
                text: 'Login',
                height: 43.0,
                onPressed: validateAndSubmit),
          ),
          new FlatButton(
              key: new Key('need-account'),
              child: new Text(
                "Need an account? Register",
                style: new TextStyle(
                  fontFamily: 'Ubuntu',
                  fontStyle: FontStyle.italic,
                ),
              ),
              onPressed: moveToRegister),
        ];
      case FormType.register:
        return [
          Padding(
            padding: const EdgeInsets.fromLTRB(9.0, 25.0, 9.0, 0.0),
            child: new PrimaryButton(
                key: new Key('register'),
                text: 'Create an account',
                height: 43.0,
                onPressed: validateAndSubmit),
          ),
          new FlatButton(
              key: new Key('need-login'),
              child: new Text(
                "Have an account? Login",
                style: new TextStyle(
                  fontFamily: 'Ubuntu',
                  fontStyle: FontStyle.italic,
                ),
              ),
              onPressed: moveToLogin),
        ];
    }
    return null;
  }

  Widget hintText() {
    return new Container(
        padding: const EdgeInsets.all(31.0),
        child: new Text(_authHint,
            key: new Key('hint'),
            style: new TextStyle(
                fontFamily: 'Ubuntu', fontSize: 19.0, color: Colors.grey),
            textAlign: TextAlign.center));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey[300],
        body: new SingleChildScrollView(
            child: new Container(
                padding: const EdgeInsets.fromLTRB(9.0, 251.0, 9.0, 0.0),
                child: new Column(children: [
                  new Card(
                      child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                        new Container(
                            padding: const EdgeInsets.all(15.0),
                            child: new Form(
                                key: formKey,
                                child: new Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children:
                                      usernameAndPassword() + submitWidgets(),
                                ))),
                      ])),
                  hintText()
                ]))));
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 9.0),
      child: child,
    );
  }
}
