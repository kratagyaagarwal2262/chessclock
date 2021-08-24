import 'package:flutter/material.dart';
import 'package:chessclock/services/values.dart';
import 'package:chessclock/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class CustomClock extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<CustomClock> {
  int minuteValue;
  int minuteValue2;
  int secondValue;
  int secondValue2;
  BannerAd bannerAd;
  bool isLoading;
  InterstitialAd interstitialAd;
  bool isInterAdLoading;
  @override
  void initState() {
    super.initState();
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        listener: BannerAdListener(
            onAdLoaded: (_)
            {
              setState(() {
                isLoading = true;
              });
            },
            onAdFailedToLoad: (ad, err)
        {
          isLoading = false;
          ad.dispose();
        }
        )
    );
    bannerAd.load();
    // This method calls the creation of an Interstitial Ad when initState is called
    _createInterstitialAd();
  }
  @override
  void dispose()
  {
    bannerAd.dispose();
    super.dispose();
  }
  @override

  // There's a need to call the below method's two times in order to have two
  // Different values for  Two Different players.
  // This  is necessary which results  in this file to become huge.
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text(
          "CUSTOM CLOCK",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Column(
        children: <Widget>[
          Image.asset("assets/images/chessclock.png",width: double.infinity,height: 150.0,),
          SizedBox(height: 30.0),
          Text(
            "WHITE",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.green.shade700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              minuteBox(context),
              secondsBox(context),
            ],
          ),
          SizedBox(height: 10.0),
          SizedBox(height: 40.0),
          Text(
            "BLACK",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.green.shade700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              minuteBoxP2(context),
              secondsBoxP2(context),
            ],
          ),
          SizedBox(height: 10.0),
          playButton(context),
          SizedBox(height: 50.0,),
          addLoader(),
        ],
      ),
    );
  }

  // This Widget will Determine how much minute would be on the clock
  Widget minuteBox(BuildContext context)
  {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 15.0,right: 5.0),
        height: 50.0,
        child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Theme.of(context).primaryColor,
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: minuteValue,
                      elevation: 5,
                      hint: Text(
                        "Minute",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text("0 Minute",style: Theme.of(context).textTheme.headline3,),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text("1 Minute",style: Theme.of(context).textTheme.headline3,),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("3 Minute",style: Theme.of(context).textTheme.headline3),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text("5 Minute",style: Theme.of(context).textTheme.headline3),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text("10 Minute",style: Theme.of(context).textTheme.headline3),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Text("30 Minute",style: Theme.of(context).textTheme.headline3),
                          value: 30,
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          minuteValue = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  // This widget would determine how many seconds would be there on the clock

  Widget secondsBox(BuildContext context)
  {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(right: 15.0,left: 5.0),
        height: 50.0,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                style: BorderStyle.solid,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Material(
            elevation: 5.0,
            shadowColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20.0),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: secondValue,
                  elevation: 5,
                  hint: Text(
                    "Seconds",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text("0 Seconds",style: Theme.of(context).textTheme.headline3),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("10 Second",style: Theme.of(context).textTheme.headline3),
                      value: 10,
                    ),
                    DropdownMenuItem(
                      child: Text("15 Second",style: Theme.of(context).textTheme.headline3),
                      value: 15,
                    ),
                    DropdownMenuItem(
                      child: Text("30 Second",style: Theme.of(context).textTheme.headline3),
                      value: 30,
                    )
                  ],
                  onChanged: (value)
                  {
                    setState(() {
                      secondValue= value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Minute Widget for the second player
  Widget minuteBoxP2(BuildContext context)
  {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 15.0,right: 5.0),
        height: 50.0,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                style: BorderStyle.solid,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Theme.of(context).primaryColor,
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: minuteValue2,
                  elevation: 5,
                  hint: Text(
                    "Minute",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text("0 Minute",style: Theme.of(context).textTheme.headline3,),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("1 Minute",style: Theme.of(context).textTheme.headline3,),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("3 Minute",style: Theme.of(context).textTheme.headline3),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("5 Minute",style: Theme.of(context).textTheme.headline3),
                      value: 5,
                    ),
                    DropdownMenuItem(
                      child: Text("10 Minute",style: Theme.of(context).textTheme.headline3),
                      value: 10,
                    ),
                    DropdownMenuItem(
                      child: Text("30 Minute",style: Theme.of(context).textTheme.headline3),
                      value: 30,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      minuteValue2 = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Second box for the value of second player
  Widget secondsBoxP2(BuildContext context)
  {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(right: 15.0,left: 5.0),
        height: 50.0,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                style: BorderStyle.solid,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Material(
            elevation: 5.0,
            shadowColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20.0),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: secondValue2,
                  elevation: 5,
                  hint: Text(
                    "Seconds",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text("0 Seconds",style: Theme.of(context).textTheme.headline3),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("10 Second",style: Theme.of(context).textTheme.headline3),
                      value: 10,
                    ),
                    DropdownMenuItem(
                      child: Text("15 Second",style: Theme.of(context).textTheme.headline3),
                      value: 15,
                    ),
                    DropdownMenuItem(
                      child: Text("30 Second",style: Theme.of(context).textTheme.headline3),
                      value: 30,
                    )
                  ],
                  onChanged: (value)
                  {
                    setState(() {
                      secondValue2= value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Increment value for the second player


// play button
  Widget playButton(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      height: 40.0,
      width: 180.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColor ,
        elevation: 5.0,
        shadowColor: Theme.of(context).primaryColor,
        child: GestureDetector(
          onTap: ()
          {
            // This method shows the loaded Interstitial ad
            _showInterstitialAd();
          },
          child: Center(
            child: Text(
              "Play",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
      ),
    );
  }
  Widget addLoader()
  {
    if(isLoading== true) {
      return Container(
        child: AdWidget(
          ad: bannerAd,
        ),
        width: bannerAd.size.width.toDouble(),
        height: bannerAd.size.height.toDouble(),
        alignment: Alignment.center,
      );
    }
    else
      return CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      );
  }
  _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd interstitialAd) {
          setState(() {
            this.interstitialAd = interstitialAd;
            isInterAdLoading = true;
          });
        },
        onAdFailedToLoad: (LoadAdError err) {
          print('Failed to load an interstitial ad: ${err.message}');
          isInterAdLoading = false;
        },
      ),
    );
  }
  // Displaying Interstitial Ads.
  _showInterstitialAd() {
    // create callbacks for a
      // when dismissed
     if (isInterAdLoading == true ) {

        // Calling the Clock page with all the required arguments when this method is  called

        Navigator.pushNamed(context, 'clock',arguments: Clocks(minuteValue, minuteValue2, secondValue, secondValue2,)); // dispose of ad
      }
      else {

        // Calling the Clock page with all the required arguments when this method is  called

        Navigator.pushNamed(context, 'clock',arguments: Clocks(minuteValue, minuteValue2, secondValue, secondValue2,));; // print error
      }
    interstitialAd.show();
  }
}

