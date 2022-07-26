import 'package:flutter/material.dart';

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Responsive().getResponsiveValue(
              forLargeScreen: Colors.red,
              forTabletScreen: Colors.pink,
              forMediumScreen: Colors.green,
              forShortScreen: Colors.yellow,
              forMobLandScapeMode: Colors.blue,
              context: context),
          // You don't need to provide the values for every
          //parameter(except shortScreen & context)
          // but default its provide the value as ShortScreen for Larger and
          //mediumScreen
        ),
      ),
    );
  }
}
