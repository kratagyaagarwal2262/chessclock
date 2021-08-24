

// @dart=2.8
import 'dart:ui';
import 'package:chessclock/pages/clock.dart';
import 'package:chessclock/pages/customclock.dart';
import 'package:chessclock/services/alternateloading.dart';
import 'package:chessclock/services/dialog_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:chessclock/pages/chesshome.dart';
import 'package:chessclock/pages/authentication/forgotpassword.dart';
import 'package:chessclock/pages/authentication/login.dart';
import 'package:chessclock/pages/authentication/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chessclock/error/error.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MaterialApp(
      title: "Chess Clock",
      initialRoute: 'login',
      routes: {
        'chessHome': (context) => ChessHome(),
        'customClock': (context) => CustomClock(),
        'login': (context) => LoginPage(),
        'register': (context) => Register(),
        'password': (context) => Password(),
        'clock': (context) => Clock(),
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green.shade700,
        accentColor: Colors.white70,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
            headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, color: Colors.white70),
            headline3: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700)
        ),
      )));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   User user ;
    final Future<FirebaseApp> initialisation = Firebase.initializeApp();
    return WillPopScope(
      child: FutureBuilder(
        future: initialisation,
        builder: (context, snapshot)
        {
          if(snapshot.hasError)
            Navigator.of(context).pushNamed('error');
          if(snapshot.connectionState==ConnectionState.done)
            {
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot)
                {
                  if(snapshot.connectionState== ConnectionState.active)
                    {
                      user =  snapshot.data as  User;
                      if (user == null ) {
                        return LogIn();
                      } else {
                        return ChessHome();
                      }
                    }
                  return Alternateloading();
                },
              );
            }
          return Error();
        }
      ),
      onWillPop: () async
      {
        return await DialogHelper.exit(context);
      },
    );
  }
}
