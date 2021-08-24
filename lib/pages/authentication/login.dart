

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:chessclock/services/auth.dart';


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  bool _obscureText = true;
  var _email;
  var _password;
  var uid;
  var userEmail;
  var _passwordErrorCode;
  final _formKey = GlobalKey<FormState>();
  Authentication instance = Authentication();

  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            stack(context),
            SizedBox(height: 20.0),
            emailField(context),
            SizedBox(height: 20.0),
            passwordField(context),
            SizedBox(height: 16.0),
            forgotPassword(context),
            SizedBox(height: 20.0),
            loginButton(context),
            SizedBox(height: 20.0),
           logInWithGoogle(context),
            SizedBox(height: 40.0,),
            register(context)
          ],
        ),
      ),
    );
  }
  // Widget for Displaying Hello There on the Home Screen
  Widget stack(BuildContext context)
  {
    return Stack(
      children: <Widget>[
        // This is for the text of hello there
        Container(
            padding: EdgeInsets.fromLTRB(15.0, 75.0, 0.0, 0.0),
            child: Text("Hello",
                style: Theme.of(context).textTheme.bodyText1)),
        Container(
            padding: EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
            child: Text("There",
                style: Theme.of(context).textTheme.bodyText1)),
        Container(
            padding: EdgeInsets.fromLTRB(250.0, 152.0, 0.0, 0.0),
            child: Text(".",
                style: Theme.of(context).textTheme.bodyText1)),
      ],
    ) ;
  }
  Widget emailField(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          cursorColor: Theme.of(context).primaryColor,
          scrollPadding: EdgeInsets.all(5.0),
          decoration: InputDecoration(
            labelText: "EMAIL",
            labelStyle: Theme.of(context).textTheme.headline1,
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).primaryColor),
            ),
            icon: Icon(Icons.mail,color: Theme.of(context).primaryColor),
          ),
          onChanged: (value) {
            _email = value;
          },
          validator: (value) => EmailValidator.validate(value)
              ? instance.emailCode
              : instance.emailCode,
          onSaved: (value) => _email = value,
        ));
  }
  Widget passwordField(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          obscureText: _obscureText,
          scrollPadding: EdgeInsets.all(5.0),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(_obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,color: Theme.of(context).primaryColor,),
            ),
            labelText: "PASSWORD",
            labelStyle: Theme.of(context).textTheme.headline1,
            icon: Icon(Icons.lock,color: Theme.of(context).primaryColor,),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          onChanged: (value) {
            _password = value;
          },
          validator: (value) {
            String pattern =
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(value))
              return _passwordErrorCode;
            else
              return null;
          },
          onSaved: (value) => _password = value,
        ));
  }
  Widget forgotPassword(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.only(top: 5.0, right: 15.0),
      alignment: Alignment(1.0, 0.0),
      child: InkWell(
        child: Text("Forgot Password",
            style: Theme.of(context).textTheme.bodyText2),
        onTap: () {
          Navigator.pushNamed(context, 'password');
        },
      ),
    ) ;
  }
  Widget loginButton(BuildContext context)
  {
    return Container(
      height: 55.0,
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        elevation: 7.0,
        child: GestureDetector(
          onTap: () async{
            if (_formKey.currentState.validate()) {
              await instance.signIn(_email, _password);
            }
          },
          child: Center(
            child: Text(
              "LOG IN ",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
      ),
    );
  }
  Widget logInWithGoogle(BuildContext context)
  {
    return Container(
      height: 100.0,
      color: Colors.transparent,
      padding: EdgeInsets.only(right: 15.0,left: 15.0,bottom: 50.0),
      child: Container(
        height: 55.0,
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              style: BorderStyle.solid,
              width: 2.0,
            ),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)),
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Theme.of(context).primaryColor,
          elevation: 7.0,
          child: GestureDetector(
            onTap: () async {
              await instance.signInWithGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Sign up with",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(width: 0.0),
                Center(
                    child: ImageIcon(
                        AssetImage('assets/images/Google.png'))),
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
  Widget register(BuildContext context)
  {
    return Center(
      child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "NEW HERE?",
                style: Theme.of(context).textTheme.headline1,
              ),
              InkWell(
                child: Text("Register",
                    style: Theme.of(context).textTheme.bodyText2),
                onTap: () {
                  Navigator.pushNamed(context, 'register');
                },
              )
            ],
          )),
    ) ;
  }
}
