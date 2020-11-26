import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routelines/helper/getMapImageProvider.dart';
import 'package:routelines/helper/map_helper.dart';
import 'package:routelines/src/mainScreen/mapScreen.dart';

class Splash extends StatefulWidget {
  final GlobalKey<NavigatorState> navigator;

  const Splash({Key key, this.navigator}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  Future<Timer> _loadData() async {
    return Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (c) => MapPage())));
  }

  checkConnection() async {}

  @override
  void initState() {
    Provider.of<GetMapImage>(context, listen: false)
        .setSourceAndDestinationIcons();

    Provider.of<MapHelper>(context, listen: false).getLocation();
    _loadData();

    super.initState();
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Stack(
        children: <Widget>[
          // ImageBG(),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/driving_pin.png',
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Navigator",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
