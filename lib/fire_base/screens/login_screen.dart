import 'package:flutter/material.dart';
import 'package:flutter_projects/fire_base/screens/event_screen.dart';
import 'package:flutter_projects/fire_base/shared/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  String _userId;

  //String _password;
  //String _email;
  String _message = '';
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  Authentication auth;

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: <Widget>[
                emailInput(),
                passwordInput(),
                mainButton(),
                secondaryButton(),
                validationMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: txtEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: 'email', icon: Icon(Icons.mail)),
        validator: (text) => text.isEmpty ? 'Email is required' : '',
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: txtPassword,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'password', icon: Icon(Icons.enhanced_encryption)),
        validator: (text) => text.isEmpty ? 'Password is required' : '',
      ),
    );
  }

  Widget mainButton() {
    String buttonText = _isLogin ? 'Login' : 'Sign in';
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: submit,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 3.0,
            primary: Theme.of(context).accentColor,
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }

  Future submit() async {
    setState(() {
      _message = "";
    });
    try {
      if (_isLogin) {
        _userId = await auth.signIn(txtEmail.text, txtPassword.text);
        print('Login for user $_userId');
      } else {
        _userId = await auth.signUp(txtEmail.text, txtPassword.text);
        print('Sign up for user $_userId');
      }
      if (_userId != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventScreen(_userId)));
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _message = e.message;
      });
    }
  }

  Widget secondaryButton() {
    String buttonText = !_isLogin ? 'Login' : 'Sign in';
    return TextButton(
      child: Text(buttonText),
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
    );
  }

  Widget validationMessage() {
    return Text(
      _message,
      style: TextStyle(
          fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }
}
