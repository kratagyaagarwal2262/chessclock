import 'package:chessclock/services/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chessclock/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ChessHome extends StatefulWidget {

  @override
  _State createState() => _State();

}

class _State extends State<ChessHome> {
  int _minuteValue;
  int _secondValue;
  BannerAd bannerAd;
  bool isLoading;
  bool isInterAdLoading;
  InterstitialAd interstitialAd;

  @override
  void initState() {
    super.initState();
    //  This methods generates a banner  ad to be shown in the main screen
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
            onAdFailedToLoad: (ad , err)
        {
          isLoading = false;
          ad.dispose();
        }
      )
    );
    bannerAd.load();
    // This method call, calls the method which in turn generate an Interstitial
    // Ad before the method is called
    _createInterstitialAd();
  }
  @override
  void dispose()
  {
    bannerAd.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "CHESS CLOCK",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Logout",
              style: Theme.of(context).textTheme.bodyText2,),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, 'login');
              },
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Image.asset("assets/images/chessclock.png",width: double.infinity,height: 200.0,),
          SizedBox(height: 30.0),
          minuteBox(context),
          SizedBox(height: 30.0),
          secondsBox(context),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              playButton(context),
              customButton(context)
            ],
          ),
          SizedBox(height: 50.0,),
          addLoader(),
        ],
      ),
    );
  }

  // This Widget will Determine how much minute would be on the clock
  Widget minuteBox(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      height: 50.0,
      width: double.infinity,
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
                value: _minuteValue,
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
                    child: Text("15 Minute",style: Theme.of(context).textTheme.headline3,),
                    value: 15,
                  ),
                  DropdownMenuItem(
                    child: Text("30 Minute",style: Theme.of(context).textTheme.headline3,),
                    value: 30,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _minuteValue = value;
                  });
                },
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
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      height: 50.0,
      width: double.infinity,
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
                value: _secondValue,
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
                    _secondValue= value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

// This widget would determine Increment time on the clock

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
          onTap: (){
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
  // Button which  sends the user  to the custom page where they can
  // Select custom time  for each player.
  Widget customButton(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.only(right: 15.0),
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
            Navigator.pushNamed(context, 'customClock');
          },
          child: Center(
            child: Text(
              "Custom",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
      ),
    );
  }
  // Loads Banner Ads.
  // More like bannerAdShow
  Widget addLoader() {
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

  // This Methods Loads an Interstitial Ad when clicked on the button
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
      Navigator.pushNamed(context, 'clock', arguments: Clocks(_minuteValue, _minuteValue, _secondValue, _secondValue,));
    }
    else {

      // Calling the Clock page with all the required arguments when this method is  called

      Navigator.pushNamed(context, 'clock', arguments: Clocks(_minuteValue, _minuteValue, _secondValue, _secondValue,));
    }
    interstitialAd.show();
  }
  }

