import 'package:flutter/material.dart';
import 'package:flutter_projects/fire_base/shared/authentication.dart';
import 'package:flutter_projects/fire_base/widgets/events.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  bool _isLoginForm = true;
  String _errorMessage = "";
  String _password;
  String _email;
  String _userId = "";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: _showForm(),
      ),
    );
  }

  Widget _showForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            showEmailInput(),
            showPasswordInput(),
            showPrimaryButton(),
            showSecondaryButton(),
            showErrorMessage(),
          ],
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onChanged: (value) {
          setState(() {
            _email = value.trim();
          });
        },
        decoration: InputDecoration(
            hintText: 'Email',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onChanged: (value) {
          setState(() {
            _password = value.trim();
          });
        },
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget showPrimaryButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: ElevatedButton(
          onPressed: validateAndSubmit,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 5.0,
            primary: Colors.deepPurple,
          ),
          child: Text(
            _isLoginForm ? 'Login' : 'Create account',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget showSecondaryButton() {
    return TextButton(
      child: Text(
        _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
      ),
      onPressed: toggleFormMode,
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
          fontSize: 13.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300,
        ),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      isLoading = true;
    });

    try {
      if (_isLoginForm) {
        _userId = await auth.signIn(_email, _password);
        print('Signed in: $_userId');
      } else {
        _userId = await auth.signUp(_email, _password);
        auth.sendEmailVerification();
        print('Signed up user: $_userId');
      }
      if (_userId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsScreen(
              title: 'Events',
              uid: _userId,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
      if (_userId.length > 0 && _userId != null && _isLoginForm) {
        loginCallback();
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
        _errorMessage = e.message;
        _formKey.currentState.reset();
      });
    }
  }

  void toggleFormMode() {
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  void loginCallback() {
    auth.getCurrentUser().then(
      (user) {
        setState(() {
          _userId = user.uid.toString();
        });
      },
    );
  }

  void logoutCallback() {
    setState(() {
      _userId = "";
    });
  }
}
