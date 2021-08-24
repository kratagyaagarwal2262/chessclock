

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:chessclock/services/auth.dart';


class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  var _email;
  Authentication instance = Authentication();
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              "Verify Email Address",
              style: TextStyle(fontSize:25.0, fontWeight: FontWeight.w700,color: Colors.white70),
            ),
          ),
          body:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.0,),
                Card(
                  elevation: 0.0,
                  child: Image.asset('assets/images/forgot-password.png', height: 150.0,width:160.0)
                ),
                SizedBox(height: 20.0,),
                Text(
                  "Rest Your Password",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.green.shade700),
                ),
                SizedBox(height: 25.0,),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                  child: TextFormField(
                    scrollPadding: EdgeInsets.all(5.0),
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val)
                    {
                    _email = val;
                    },
                      validator: (val) => !EmailValidator.validate(val)?"Invalid Email": null,
                      onSaved: (val) => _email = val,
                      decoration: InputDecoration(
                      hintText: "EMAIL",
                      labelStyle:TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold ,),
                      focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                        icon: Icon(Icons.mail,color: Theme.of(context).primaryColor),
                    )
                  )
                ),
                SizedBox(height: 30.0,),
                Container(
                  height: 55.0,
                  padding: EdgeInsets.only(right: 65.0, left: 65.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).primaryColor,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () async {
                          await instance.forgotPassword(_email);
                          Navigator.pop(context);
                          showDialog(context: context,
                              builder:(BuildContext context) => passwordReset(context) );
                      },
                      child: Center(
                        child: Text(
                          "SEND PASSWORD RESET",
                          style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w700,color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        );
  }


  Widget passwordReset(BuildContext context)
  {
    return AlertDialog(
      title: Text(
          "ALERT!",
          style: Theme.of(context).textTheme.bodyText2
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:[
          Text(
            "A rest password link Has been sent to your email Address",
            style: Theme.of(context).textTheme.headline4,
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
}
