import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routelines/helper/getMapImageProvider.dart';
import 'package:routelines/helper/map_helper.dart';
import 'intro/splash.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapHelper()),
        ChangeNotifierProvider(create: (_) => GetMapImage()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Color.fromRGBO(249, 22, 43, 1.0),
          primaryColor: Color.fromRGBO(246, 144, 47, 1.0),
        ),
        home: Splash(),
      ),
    );
  }
}
