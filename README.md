# Responsiveness

A Responsive Mobile app Using MediaQuery

## Introduction

Making app responsive is very important for every developer. Using MediaQuery you can make app responsive to every screen sizes.

### Step - 1

First you have to find out how you can find out yu device size -width as well as -height.
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
    return size.width / (deviceWidth / width);
  }

  // responsive height
  double setHeight({required double height}) {
    return size.height / (deviceHeight / height);
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

  // responsive Let Padding
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

### Final Step - Implementation & Example

Initialize this under the BuildContext above the
Scaffold
Note:- the device height and device width is mentioned above you can pass it as variable

```dart
    Responsive rs = Responsive(
      context: context,
      deviceHeight: deviceHeight,
      deviceWidth: deviceWidth,
    );
```

### Example

```dart
Column(
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
              // color will also change
              color: rs.getResponsiveValue(
                forLargeScreen: Colors.red,
                forTabletScreen: Colors.pink,
                forMediumScreen: Colors.green,
                forShortScreen: Colors.yellow,
                forMobLandScapeMode: Colors.blue,
                context: context,
              ),
              // text will change according to screen Sizes but it is only necessary in case of web
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
```

### Orientation

```dart
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
```

This is not  perfect solution because a lot of factors we have to consider like LayoutBuilder and AspectRation and OrientationBuilder and Constraints and also few things we need to take care of based on Platform.
But this is a most basic and fast way to make thing work. I hope it helps.
