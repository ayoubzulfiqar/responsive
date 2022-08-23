import 'package:flutter/material.dart';
import 'package:responsiveness/app_config.dart';
import 'package:responsiveness/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // -- this is  my app screens that i was working on
  // double deviceHeight = 875.428;
  // double deviceWidth = 411.428;

  // default size for every type of app
  double deviceHeight = 690;
  double deviceWidth = 360;

  // to set orientation
  getOrientation() {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    if (currentOrientation == Orientation.portrait) {
      setState(() {
        deviceHeight = MediaQuery.of(context).size.height;
      });
    } else {
      setState(() {
        deviceHeight = MediaQuery.of(context).size.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive rs = Responsive(
      context: context,
      deviceHeight: deviceHeight,
      deviceWidth: deviceWidth,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsiveness"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: rs.setWidth(width: 100),
              height: rs.setHeight(height: 200),
              alignment: Alignment.center,
              color: Colors.black,
              child: Text(
                "H",
                style: TextStyle(
                    fontSize: rs.setFontSize(fontSize: 20),
                    color: Colors.white),
              ),
            ),
            Container(
              width: rs.setWidth(width: 100),
              height: rs.setHeight(height: 200),
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text(
                "ScalerPixel",
                style: TextStyle(
                    fontSize: rs.setFontSize(fontSize: 20),
                    color: Colors.white),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              color: rs.getResponsiveValue(
                forLargeScreen: Colors.red,
                forTabletScreen: Colors.pink,
                forMediumScreen: Colors.green,
                forShortScreen: Colors.yellow,
                forMobLandScapeMode: Colors.blue,
                context: context,
              ),
              child: Text(
                rs.getResponsiveValue(
                    context: context,
                    forLargeScreen: 'LargeScreen',
                    forShortScreen: 'ShortScreen',
                    forMediumScreen: 'MediumScreen',
                    forTabletScreen: 'Tablet',
                    forMobLandScapeMode: 'LandScape'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
