import 'package:flutter/material.dart';
import 'package:chessclock/services/values.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'dart:ui' as ui;


class Clock extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => Clock(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<Clock> {

  bool _isHours = false;
  final _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );
  final _stopWatchTimer2 = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
    await _stopWatchTimer2.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Clocks;
    int increment = args.secondValue2;
    _stopWatchTimer.setPresetSecondTime(args.secondValue);
    _stopWatchTimer.setPresetMinuteTime(args.minuteValue);
    _stopWatchTimer2.setPresetSecondTime(args.secondValue2);
    _stopWatchTimer2.setPresetMinuteTime(args.minuteValue2);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       black(increment),
        SizedBox(height: 5.0,),
        white(),
      ],
    );
  }
  Widget black(int increment)
  {
   /* int blackValue;*/
     return Expanded(
          child: Container(
          width: double.infinity,
          child: Material(
            child: GestureDetector(
              onLongPress: () async{
                _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                _stopWatchTimer2.onExecute.add(StopWatchExecute.stop);
                showDialog(context: context, builder:(BuildContext context) => overlay());
                },
              onTap: () async {
                _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                _stopWatchTimer2.onExecute.add(StopWatchExecute.stop);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder<int>(
                      stream: _stopWatchTimer2.rawTime,
                      initialData: _stopWatchTimer2.rawTime.value,
                      builder: (context, snap) {
                        final value = snap.data;
                        final displayTime =
                        StopWatchTimer.getDisplayTime(value, hours: _isHours);
                       /* blackValue = int.parse(displayTime.replaceAll(RegExp('[^0-9]'), ''));
                        print(" Black Value = $blackValue");
                        print (" Divided value = ${blackValue/10000}");*/
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                displayTime,
                                style: const TextStyle(
                                  color: Colors.black,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          ),
      );
  }
  Widget white()
  {
    /*int whiteValue;*/
    if(_stopWatchTimer.isRunning)
      _stopWatchTimer2.onExecute.add(StopWatchExecute.stop);
    return Expanded(
      child: Container(
          child: Material(
            child: GestureDetector(
              onLongPress: () async {
                _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                _stopWatchTimer2.onExecute.add(StopWatchExecute.stop);
                //
                showDialog(context: context, builder:(BuildContext context) => overlay());
              },
              onTap: () async {
                _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                _stopWatchTimer2.onExecute.add(StopWatchExecute.start);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snap) {
                        final value = snap.data;
                        final displayTime =
                        StopWatchTimer.getDisplayTime(value, hours: _isHours);
                       /* whiteValue = int.parse(displayTime.replaceAll(RegExp('[^0-9]'), ''));
                        print("White value = $whiteValue");*/
                       return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                displayTime,
                                style: const TextStyle(
                                  color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          width: double.infinity,
      ),
    );
  }
  // Method to Dynamically adjust the color of the widget based on the time
  // On the Clock
  // So lesser the time, the darker the color of the Container would be
  // Unable to change the function. Would do it once I find a way.
/*Color changeColor(var value)
{
  if (value != null) {
    if (value/10000 < 1.0)
      return Colors.red;
    else if (value/10000 < 4.0 && value/10000 > 1.0)
      return Colors.deepOrange;
    else
      return Theme.of(context).primaryColor;
  }
  else
    return Theme.of(context).primaryColor;
}*/

// This Widget is meant to house a collapsable floating action button
// Which is responsible to have buttons to increment and decrement player's Time
// Also the clock can be reset if clicked on a button

  Widget overlay()
  {
    return  BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 1,
        sigmaY: 1,
      ),
      child: Material(
        type: MaterialType.transparency,
        shadowColor: Theme.of(context).accentColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              // Buttons to increment time for White and black
              // But there is some error so  would resolve it in the next update


              /*MaterialButton(
                onPressed: () {
                  _stopWatchTimer.setPresetSecondTime(1);
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Increment for White",
                  style:TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
                ),
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),*/


              MaterialButton(
                onPressed: () {
                  _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                  _stopWatchTimer2.onExecute.add(StopWatchExecute.reset);
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Reset",
                  style: Theme.of(context).textTheme.headline2,
                ),
                padding: EdgeInsets.all(40),
                shape: CircleBorder(),
              ),
              // Buttons to increment time for White and black
              // But there is some error so  would resolve it in the next update


              /*MaterialButton(
                onPressed: () {
                  _stopWatchTimer2.setPresetSecondTime(1);
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Increment for Black",
                  style:TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ),
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),*/


            ],
          ),
      ),
    );
  }
  }
