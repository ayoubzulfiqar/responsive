import 'dart:math';
import 'package:flutter/material.dart';

@immutable
class Responsive {
 // Device Height = your_device_height
 // Device Width = your_device_width
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
