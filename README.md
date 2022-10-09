# Responsiveness

A Responsive Mobile app Using MediaQuery

## Introduction

Making app responsive is very important for every developer. Using MediaQuery you can make app responsive to every screen sizes.

### Step - 1

First you have to find out how you can find out your device size `width` as well as `height`.
Using this print statement you can get your device size in you terminal.

```dart
    print("Height: ${MediaQuery.of(context).size.height}, Width: ${MediaQuery.of(context).size.width}");
```

#### Note:- if you don't wanna use this method to find height and width you  can use default values

```dart
  double deviceHeight = 690;
  double deviceWidth = 360;
```

### Step - 2

Create a file responsive.dart in lib folder
put this code inside your file.

```dart

import 'dart:math';

import 'package:flutter/material.dart';

@immutable
class Responsive {
// Device Height = 875.428
// Device Width = 411.428
  final BuildContext context;
  final double deviceHeight;
  final double deviceWidth;

  const Responsive({
    required this.context,
    required this.deviceHeight,
    required this.deviceWidth,
  });
  // general size
  Size get size => MediaQuery.of(context).size;

  // responsive width
  double setWidth({required double width}) {
    return MediaQuery.of(context).size.width / (deviceWidth / width);
  }

  // responsive height
  double setHeight({required double height}) {
    return MediaQuery.of(context).size.height / (deviceHeight / height);
  }

  // responsive font based on Width - it works but not a good solution
  // double setFontSize({required double fontSize}) {
  //   return size.width / (deviceWidth / fontSize);
  // }

  // don't use it
  double setTextScaleFactor({required double textScaleFactor}) {
    return MediaQuery.of(context).textScaleFactor / textScaleFactor;
  }

  // remove padding all
  MediaQueryData removeAllPadding() => MediaQuery.of(context).removePadding(
      removeLeft: true, removeRight: true, removeBottom: true, removeTop: true);

  // set devicePixel ration
  double setDevicePixelRatio() => MediaQuery.of(context).devicePixelRatio;

  // responsive bottom padding
  double setBottomPadding({required double padding}) {
    return MediaQuery.of(context).padding.bottom + padding;
  }

  // responsive Left Padding
  double setLeftPadding({required double padding}) {
    return MediaQuery.of(context).padding.left + padding;
  }

  // responsive right padding
  double setRightPadding({required double padding}) {
    return MediaQuery.of(context).padding.right + padding;
  }

  // responsive top padding
  double setTopPadding({required double padding}) {
    return MediaQuery.of(context).padding.top + padding - 20;
  }

  //  set padding from all sides
  double setPadding({required double padding}) {
    double bottom = MediaQuery.of(context).padding.bottom;
    double top = MediaQuery.of(context).padding.top;
    double left = MediaQuery.of(context).padding.left;
    double right = MediaQuery.of(context).padding.right;
    return (bottom + top + left + right) + padding;
  }

  // responsive Bottom Margin
  double setBottomMargin({required double margin}) {
    return MediaQuery.of(context).padding.bottom + margin;
  }

  // responsive Left Margin
  double setLeftMargin({required double margin}) {
    return MediaQuery.of(context).padding.left + margin;
  }

  // responsive right Margin
  double setRightMargin({required double margin}) {
    return MediaQuery.of(context).padding.right + margin;
  }

  // responsive top Margin
  double setTopMargin({required double margin}) {
    return MediaQuery.of(context).padding.top + margin;
  }

  // set margin from all sides
  double setMargin({required double margin}) {
    double bottom = MediaQuery.of(context).padding.bottom;
    double top = MediaQuery.of(context).padding.top;
    double left = MediaQuery.of(context).padding.left;
    double right = MediaQuery.of(context).padding.right;
    return (bottom + top + left + right) + margin;
  }

  // responsive Width space - forExample in SizedBox
  double setWidthSpace({required double width}) {
    return MediaQuery.of(context).size.width / (deviceWidth / width);
  }

  // responsive height space - forExample in SizedBox
  double setHeightSpace({required double height}) {
    return MediaQuery.of(context).size.height / (deviceHeight / height);
  }

  // scaling the font size based on scale factor - use for scaling fontSize
  double setFontSize({required double fontSize}) {
    final double sWidth = MediaQuery.of(context).size.width;
    final double sHeight = MediaQuery.of(context).size.height;
    // if i divide the deviceHeight / sHeight.. than the font will adjust it's self inside box
    // but in blow case it is working only the font size.
    final scaleH = sHeight / deviceHeight;
    final scaleW = sWidth / deviceWidth;
    final double scale = max(scaleW, scaleH);
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return fontSize * scale * textScaleFactor;
  }

  double setHeightWithoutSafeArea({required double heightWithoutSafeArea}) {
    EdgeInsets padding = MediaQuery.of(context).viewPadding;
    double height = size.height;
    return height -
        (deviceHeight / heightWithoutSafeArea) -
        padding.top -
        padding.bottom;
  }

  double setWidthWithoutSafeArea({required double heightWithoutSafeArea}) {
    EdgeInsets padding = MediaQuery.of(context).viewPadding;
    double width = size.width;
    return width -
        (deviceHeight / heightWithoutSafeArea) -
        padding.top -
        padding.bottom;
  }

  double setHeightWithoutStatusBar({required double heightWithoutSafeArea}) {
    EdgeInsets padding = MediaQuery.of(context).viewPadding;
    double height = size.height;
    return height - (deviceHeight / heightWithoutSafeArea) - padding.top;
  }

  double setHeightWithoutStatusBarToolbar(
      {required double heightWithoutSafeArea}) {
    EdgeInsets padding = MediaQuery.of(context).viewPadding;
    double height = size.height;
    return height -
        (deviceHeight / heightWithoutSafeArea) -
        padding.top -
        kToolbarHeight;
  }
  
  // Use can use this to set Radius from all sides
  // as well as from only one side
  double setRadius({required double radius}) {
    final double sWidth = MediaQuery.of(context).size.width;
    final double sHeight = MediaQuery.of(context).size.height;
    final scaleH = sHeight / deviceHeight;
    final scaleW = sWidth / deviceWidth;
    return radius * min(scaleW, scaleH);
  }

  // for different values such as the using this you can pass even a widget
  getResponsiveValue({
    dynamic forShortScreen,
    dynamic forMediumScreen,
    dynamic forLargeScreen,
    dynamic forMobLandScapeMode,
    dynamic forTabletScreen,
    required BuildContext context,
  }) {
    if (isLargeScreen(context)) {
      return forLargeScreen ?? forShortScreen;
    } else if (isMediumScreen(context)) {
      return forMediumScreen ?? forShortScreen;
    } else if (isTabletScreen(context)) {
      return forTabletScreen ?? forMediumScreen ?? forShortScreen;
    } else if (isSmallScreen(context) && isLandScapeMode(context)) {
      return forMobLandScapeMode ?? forShortScreen;
    } else {
      return forShortScreen;
    }
  }

  isLandScapeMode(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return true;
    } else {
      return false;
    }
  }

  static bool isLargeScreen(BuildContext context) {
    return getWidth(context) > 1200;
  }

  static bool isSmallScreen(BuildContext context) {
    return getWidth(context) < 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return getWidth(context) > 800 && getWidth(context) < 1200;
  }

  static bool isTabletScreen(BuildContext context) {
    return getWidth(context) > 450 && getWidth(context) < 800;
  }

  // getting full width
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
```

### Example

```dart
import 'package:flutter/material.dart';
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

  // to set and orientation

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    if (currentOrientation == Orientation.portrait) {
      setState(() {
        deviceWidth = MediaQuery.of(context).size.height;
      });
    } else {
      setState(() {
        deviceHeight = MediaQuery.of(context).size.width;
      });
    }

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
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                      Radius.circular(rs.setRadius(radius: 20)))),
              child: Text(
                "H",
                style: TextStyle(
                    fontSize: rs.setFontSize(fontSize: 20),
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: rs.setHeightSpace(height: 20),
            ),
            Container(
              width: 100,
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
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
```

### Orientation

```dart
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    if (currentOrientation == Orientation.portrait) {
      setState(() {
        deviceWidth = MediaQuery.of(context).size.height;
      });
    } else {
      setState(() {
        deviceHeight = MediaQuery.of(context).size.width;
      });
    }
```

This is not  perfect solution because a lot of factors we have to consider like LayoutBuilder and AspectRation and OrientationBuilder and Constraints and also few things we need to take care of based on Platform.
But this is a most basic and fast way to make thing work. I hope it helps.
