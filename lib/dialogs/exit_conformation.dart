import 'package:flutter/material.dart';
class ExitConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 7.0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );

  }
}

_buildChild(BuildContext context) {
  return Container(
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Are You sure you Want to Exit?",
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 95.0,
                height: 35.0,
                padding: EdgeInsets.only(right: 15.0 ,left:15.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  shadowColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(context);
                    },
                    child: Center(
                      child: Text(
                        "NO",
                        style:TextStyle(fontSize:18.0, fontWeight: FontWeight.w700,color: Colors.white70),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 35.0),
              Container(
                width: 95.0,
                height: 35.0,
                padding: EdgeInsets.only(right: 15.0 ,left:15.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  shadowColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Center(
                      child: Text(
                        "YES",
                        style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w700,color: Colors.white70),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
}
