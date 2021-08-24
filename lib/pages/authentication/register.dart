


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:chessclock/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _usernameController = TextEditingController();
  var _password;
  var _confirmpassword;
  var _email;
   User user;
  var uid;
  var userEmail;
  bool _obscureText = true;
  final _formkey = GlobalKey<FormState>();
  Authentication instance = Authentication();

  // Constructor for auth

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formkey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80.0,),
                        emailImage(context),
                  // Container for Email Verification Text Field
                        emailTextField(context),
                  SizedBox(height: 20.0),
                  // Container for Password Verification text field
                        passwordTextField(context),
                  SizedBox(height: 20.0),
                  // Container of Confirm Password
                         confirmPasswordTextField(context),
                  SizedBox(height: 45.0),
                  //Container for Register Button
                         registerButton(context),
                  SizedBox(height: 20.0),
                      //Register With Google Button
                        registerWithGoogle(context),
              ],
            ),
        )
    );
  }


// Widget for Informational Dialog Helper
  Widget _dialogHelper(BuildContext context)
  {
    return new AlertDialog(
      title: Text(
        "ALERT!",
        style: Theme.of(context).textTheme.bodyText2
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:[
          Text(
            "Password must contain at least one capital letter."
                "Password must contain at least one special character."
                "Password must contain at least one Digit."
                "Password must be at least 8 characters long.",
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
        ),
      actions: [
        TextButton(
            onPressed: (Navigator.of(context).pop),
            child: Text("OK Got It!",
            style: Theme.of(context).textTheme.bodyText2,
              )
        )
      ],
    );
  }

  // Widget for a Dialog when the users Email is not Verified
  Widget registerDialog(BuildContext context)
  {
    return new AlertDialog(
      title: Text(
        "ALERT!",
        style: Theme.of(context).textTheme.bodyText2,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Verify the Email Address before Logging in Again."
                "A Verification Email is sent on your given Email Address",
            style: Theme.of(context).textTheme.headline3,
          )
        ],
      ),
      actions: [
        new  TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(
            "OK GOT IT!!",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        )
      ],
    );

  }
  Widget emailImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 95.0, right: 95.0),
      child: Card(
          elevation: 0.0,
          child: Image.asset(
            'assets/images/email-login.png', height: 150.0, width: 190.0,)
      ),
    );
  }

  // Email Verification Text Field Widget
  Widget emailTextField(BuildContext context)
  {
     return  Container(
         padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
         child: TextFormField(
           controller: _usernameController,
           keyboardType: TextInputType.emailAddress,
           cursorColor: Theme.of(context).primaryColor,
           onChanged: (value) {
             _email = value;
           },
           validator: (value) => !EmailValidator.validate(value)
               ? instance.emailCode
               : null,
           onSaved: (value) => _email = value,
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
         )
     ) ;
  }

  Widget passwordTextField(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            setState(() {
              this._password = value;
            });
          },
          obscureText: _obscureText,
          scrollPadding: EdgeInsets.all(5.0),
          decoration: InputDecoration(
            prefixIcon: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => _dialogHelper(context)
                  );
                },
                icon: Icon(Icons.info_sharp,color: Theme.of(context).primaryColor,)),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(_obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,color: Theme.of(context).primaryColor,),
            ),
            labelText: "PASSWORD",
            labelStyle: Theme.of(context).textTheme.headline1,
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).primaryColor),
            ),
            icon: Icon(Icons.lock,color:Theme.of(context).primaryColor ,),
          ),
          validator: (value) {
            String pattern =
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(value))
              return 'Invalid password';
            else
              return null;
          },
          onSaved: (value) => _password = value,
        ));
  }
  Widget confirmPasswordTextField(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            setState(() {
              this._confirmpassword = value;
            });
          },
          obscureText: _obscureText,
          scrollPadding: EdgeInsets.all(5.0),
          decoration: InputDecoration(
              labelText: "CONFIRM PASSWORD",
              labelStyle: Theme.of(context).textTheme.headline1,
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Theme.of(context).primaryColor),
              ),
              icon: Icon(Icons.lock,color: Theme.of(context).primaryColor,)),
          validator: (value) {
            if (_password != _confirmpassword)
              return 'Invalid password';
            else
              return null;
          },
          onSaved: (value) => _confirmpassword = value,
        ));
  }
  Widget registerButton(BuildContext context)
  {
    return  Container(
      height: 50.0,
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        elevation: 7.0,
        child: GestureDetector(
          onTap: () async {
            if (_formkey.currentState.validate()) {
              await instance.createUserWithEmailAndPassword(
                  _email, _confirmpassword);
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      registerDialog(context)
              );
            }
          },
          child: Center(
            child: Text(
              "REGISTER",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
      ),
    );
  }
  Widget registerWithGoogle(BuildContext context)
  {
    return  Expanded(
      child: Container(
        height: 25.0,
        padding: EdgeInsets.only(right: 15.0, left: 15.0,bottom: 210.0,),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                style: BorderStyle.solid,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            elevation: 7.0,
            shadowColor: Theme.of(context).primaryColor,
            child: GestureDetector(
              onTap: () async {
                await instance.signInWithGoogle();
                Navigator.pop(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Register with",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(width: 0.0),
                  Center(
                    child: ImageIcon(
                        AssetImage('assets/images/Google.png')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ) ;
  }
}
