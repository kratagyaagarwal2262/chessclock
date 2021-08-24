


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Alternateloading extends StatefulWidget {
  @override
  _AlternateloadingState createState() => _AlternateloadingState();
}

class _AlternateloadingState extends State<Alternateloading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
