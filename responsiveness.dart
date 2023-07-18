import 'package:flutter/material.dart';

@immutable
class Responsive {
  final BuildContext context;
  final double deviceHeight;
  final double deviceWidth;

  static Responsive? _instance;

  Responsive._({required this.context})
      : deviceHeight = MediaQuery.sizeOf(context).height,
        deviceWidth = MediaQuery.sizeOf(context).width;

  factory Responsive.getInstance({
    required BuildContext context,
  }) {
    _instance ??= Responsive._(
      context: context,
    );
    return _instance!;
  }

// general size
  Size get screenSize => MediaQuery.sizeOf(context);
  EdgeInsets get screenPadding => MediaQuery.paddingOf(context);

  // responsive width
  double setWidth({required double width}) {
    if (deviceWidth == 0 || screenSize.height == 0) return 0.0;
    return screenSize.width / (deviceWidth / width);
  }

  // responsive height
  double setHeight({required double height}) {
    if (deviceHeight == 0 || screenSize.height == 0) return 0.0;
    return screenSize.height / (deviceHeight / height);
  }

  // responsive font based on Width - it works but not a good solution
  // double setFontSize({required double fontSize}) {
  //   return size.width / (deviceWidth / fontSize);
  // }

  // don't use it
  double setTextScaleFactor({required double textScaleFactor}) {
    final screenTextScaleFactor = MediaQuery.textScaleFactorOf(context);
    if (screenTextScaleFactor == 0 || textScaleFactor == 0) return 0.0;
    return screenTextScaleFactor / textScaleFactor;
  }

  // remove padding all
  MediaQueryData removeAllPadding() {
    // On Working
    // MediaQuery.removePadding(context: context, child: child)
    return MediaQuery.of(context).removePadding(
      removeLeft: true,
      removeRight: true,
      removeBottom: true,
      removeTop: true,
    );
  }

// remove All Padding of  the certain Widget
  MediaQuery removeAllPaddingWithWidget({required Widget child}) {
    return MediaQuery.removePadding(
      removeLeft: true,
      removeRight: true,
      removeBottom: true,
      removeTop: true,
      context: context,
      child: child,
    );
  }

  // set devicePixel ration
  double get setDevicePixelRatio =>
      MediaQuery.devicePixelRatioOf(context).abs();

  // responsive bottom padding
  double setBottomPadding({required double padding}) {
    if (screenPadding.bottom == 0 || padding == 0) return 0.0;
    return screenPadding.bottom + padding;
  }

  // responsive Left Padding
  double setLeftPadding({required double padding}) {
    if (screenPadding.left == 0 || padding == 0) return 0.0;
    return screenPadding.left + padding;
  }

  // responsive right padding
  double setRightPadding({required double padding}) {
    if (screenPadding.right == 0 || padding == 0) return 0.0;
    return screenPadding.right + padding;
  }

  // responsive top padding
  double setTopPadding({required double padding}) {
    if (screenPadding.top == 0 || padding == 0) return 0.0;
    return screenPadding.top + padding - 20;
  }

  //  set padding from all sides
  double setPadding({required double padding}) {
    final double bottom = screenPadding.bottom;
    final double top = screenPadding.top;
    final double left = screenPadding.left;
    final double right = screenPadding.right;
    if (bottom == 0 || top == 0 || left == 0 || right == 0 || padding == 0) {
      return 0.0;
    }
    return (bottom + top + left + right) + padding;
  }

  // responsive Bottom Margin
  double setBottomMargin({required double margin}) {
    final double screenHeight = screenSize.height;
    final double screenPaddingBottom = screenPadding.bottom;
    final double marginWithPadding = screenPaddingBottom + margin;
    final double marginWithOutPadding = screenHeight - marginWithPadding;
    if (screenHeight == 0 ||
        screenPaddingBottom == 0 ||
        marginWithPadding == 0 ||
        marginWithOutPadding == 0) return 0.0;
    return marginWithOutPadding;
  }

  // responsive Left Margin
  double setLeftMargin({required double margin}) {
    final double screenWidth = screenSize.width;
    final double screenPaddingLeft = screenPadding.left;
    final double marginWithPadding = screenPaddingLeft + margin;
    final double marginWithOutPadding = screenWidth - marginWithPadding;
    if (screenWidth == 0 ||
        screenPaddingLeft == 0 ||
        marginWithPadding == 0 ||
        marginWithOutPadding == 0) return 0.0;
    return marginWithOutPadding;
  }

  // responsive right Margin
  double setRightMargin({required double margin}) {
    final double screenWidth = screenSize.width;
    final double screenPaddingRight = screenPadding.right;
    final double marginWithPadding = screenPaddingRight + margin;
    final double marginWithOutPadding = screenWidth - marginWithPadding;
    if (screenWidth == 0 ||
        screenPaddingRight == 0 ||
        marginWithPadding == 0 ||
        marginWithOutPadding == 0) return 0.0;
    return marginWithOutPadding;
  }

  // responsive top Margin
  double setTopMargin({required double margin}) {
    final double screenHeight = screenSize.height;
    final double screenPaddingTop = screenPadding.top;
    final double marginWithPadding = screenPaddingTop + margin;
    final double marginWithOutPadding = screenHeight - marginWithPadding;
    if (screenHeight == 0 ||
        screenPaddingTop == 0 ||
        marginWithPadding == 0 ||
        marginWithOutPadding == 0) return 0.0;
    return marginWithOutPadding;
  }

  // set margin from all sides
  double setMargin({required double margin}) {
    final double bottom = screenPadding.bottom;
    final double top = screenPadding.top;
    final double left = screenPadding.left;
    final double right = screenPadding.right;
    if (bottom == 0 || top == 0 || left == 0 || right == 0 || margin == 0) {
      return 0.0;
    }
    return (bottom + top + left + right) + margin;
  }

  // responsive Width space - forExample in SizedBox
  double setWidthSpace({required double width}) {
    final spaceWidth = screenSize.width / (deviceWidth / width);
    if (screenSize.width == 0 || deviceWidth == 0 || width == 0) return 0.0;
    return spaceWidth;
  }

  // responsive height space - forExample in SizedBox
  double setHeightSpace({required double height}) {
    final screenHeight = screenSize.height;
    if (screenHeight == 0 || deviceHeight == 0 || height == 0) return 0.0;
    return screenHeight / (deviceHeight / height);
  }

  // scaling the font size based on scale factor - use for scaling fontSize
  double setFontSize({required double fontSize}) {
    final double sWidth = screenSize.width;
    final double sHeight = screenSize.height;
    // if i divide the deviceHeight / sHeight.. than the font will adjust it's self inside box
    // but in blow case it is working only the font size.

    final double scaleH = sHeight / deviceHeight;
    final double scaleW = sWidth / deviceWidth;

    // final double scaleH = deviceHeight / sHeight;
    // final double scaleW = deviceWidth / sWidth;
    final double scale = _max(scaleW, scaleH);
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);

    if (deviceWidth == 0 || deviceHeight == 0 || sWidth == 0 || sHeight == 0) {
      return 0.0;
    }

    return fontSize * scale * textScaleFactor;
  }

  double setHeightWithoutSafeArea({required double heightWithoutSafeArea}) {
    final EdgeInsets padding = screenPadding;
    final double sHeight = screenSize.height;
    return sHeight -
        (deviceHeight / heightWithoutSafeArea) -
        padding.top -
        padding.bottom;
  }

  double setWidthWithoutSafeArea({required double widthWithoutSafeArea}) {
    final EdgeInsets padding = screenPadding;
    final double width = screenSize.width;
    return width -
        (deviceHeight / widthWithoutSafeArea) -
        padding.top -
        padding.bottom;
  }

  double setHeightWithoutStatusBar({required double heightWithoutStatusbar}) {
    final EdgeInsets padding = screenPadding;
    final double height = screenSize.height;
    return height - (deviceHeight / heightWithoutStatusbar) - padding.top;
  }

  double setHeightWithoutToolbar({required double heightWithoutToolbar}) {
    final EdgeInsets padding = screenPadding;
    final double height = screenSize.height;
    return height -
        (deviceHeight / heightWithoutToolbar) -
        padding.top -
        kToolbarHeight;
  }

  // Use can use this to set Radius from all sides
  // as well as from only one side
  double setRadius({required double radius}) {
    final double sWidth = screenSize.width;
    final double sHeight = screenSize.height;
    final double scaleH = sHeight / deviceHeight;
    final double scaleW = sWidth / deviceWidth;
    final double scale = _min(scaleW, scaleH);
    return radius * scale;
  }

  double _max(double first, double second) {
    return first > second ? first : second;
  }

  double _min(double first, double second) {
    return first < second ? first : second;
  }
}

// Extension
extension ExtensionOnWidth on num {
  // Width
  double sW(BuildContext context) => Responsive.getInstance(
        context: context,
      ).setWidth(
        width: toDouble(),
      );
}

extension ExtensionOnHeight on num {
  // Height
  double sH(BuildContext context) => Responsive.getInstance(
        context: context,
      ).setHeight(
        height: toDouble(),
      );
}

extension ExtensionOnTextScaleFactor on num {
  // Text Scale Factor
  double tSF(BuildContext context) =>
      Responsive.getInstance(context: context).setTextScaleFactor(
        textScaleFactor: toDouble(),
      );
}

extension ExtensionOnDevicePixelRatio on num {
  // Device Pixel Ratio
  double dPRatio(BuildContext context) =>
      Responsive.getInstance(context: context).setDevicePixelRatio;
}

extension ExtensionOnFontSize on num {
  // Font
  double sF(BuildContext context) =>
      Responsive.getInstance(context: context).setFontSize(
        fontSize: toDouble(),
      );
}

// Paddings
extension ExtensionOnPadding on num {
  // All Padding
  double sP(BuildContext context) =>
      Responsive.getInstance(context: context).setPadding(
        padding: toDouble(),
      );
}

extension ExtensionOnLeftPadding on num {
  // Left Padding
  double sLP(BuildContext context) =>
      Responsive.getInstance(context: context).setLeftPadding(
        padding: toDouble(),
      );
}

extension ExtensionOnRightPadding on num {
  // Right padding
  double sRP(BuildContext context) =>
      Responsive.getInstance(context: context).setRightPadding(
        padding: toDouble(),
      );
}

extension ExtensionOnTopPadding on num {
  // Top Padding
  double sTP(BuildContext context) =>
      Responsive.getInstance(context: context).setTopPadding(
        padding: toDouble(),
      );
}

extension ExtensionOnBottomPadding on num {
  // Bottom Padding
  double sBP(BuildContext context) =>
      Responsive.getInstance(context: context).setBottomPadding(
        padding: toDouble(),
      );
}

extension ExtensionOnWidgetPadding on num {
  // Remove All Padding
  rAChildPadding(BuildContext context, {required Widget child}) =>
      Responsive.getInstance(context: context)
          .removeAllPaddingWithWidget(child: child);
}

//------ Margins
extension ExtensionOnMargin on num {
  // All Margin
  double sM(BuildContext context) =>
      Responsive.getInstance(context: context).setMargin(
        margin: toDouble(),
      );
}

extension ExtensionOnLeftMargin on num {
  // Left Margin
  double sLM(BuildContext context) =>
      Responsive.getInstance(context: context).setLeftMargin(
        margin: toDouble(),
      );
}

extension ExtensionOnRightMargin on num {
  // Right Margin
  double sRM(BuildContext context) =>
      Responsive.getInstance(context: context).setRightMargin(
        margin: toDouble(),
      );
}

extension ExtensionOnTopMargin on num {
  // Top Margin
  double sTM(BuildContext context) =>
      Responsive.getInstance(context: context).setTopMargin(
        margin: toDouble(),
      );
}

extension ExtensionOnBottomMargin on num {
  // Bottom Margin
  double sBM(BuildContext context) =>
      Responsive.getInstance(context: context).setBottomMargin(
        margin: toDouble(),
      );
}

//---- Radius
extension ExtensionOnRadius on num {
  // All Radius OR Individual radius
  double sR(BuildContext context) =>
      Responsive.getInstance(context: context).setRadius(
        radius: toDouble(),
      );
}

// Spaces
extension ExtensionOnSpaceWidth on num {
  // Width Spaces -- For Sized Box and other Spaces
  double sSW(BuildContext context) =>
      Responsive.getInstance(context: context).setWidthSpace(
        width: toDouble(),
      );
}

extension ExtensionOnSpaceHeight on num {
  // Height Spaces -- For Sized Box and other Spaces
  double sSH(BuildContext context) =>
      Responsive.getInstance(context: context).setHeightSpace(
        height: toDouble(),
      );
}

//--- SafeArea
extension ExtensionOnHeightWithOutSafeArea on num {
  // Set the height of a widget that should be displayed in the safe area.
  double sHWithOutSafeArea(BuildContext context) =>
      Responsive.getInstance(context: context).setHeightWithoutSafeArea(
        heightWithoutSafeArea: toDouble(),
      );
}

extension ExtensionOnWidthWithOutSafeArea on num {
  // Set the width of a widget that should be displayed in the safe area
  double sWWithOutSafeArea(BuildContext context) =>
      Responsive.getInstance(context: context).setWidthWithoutSafeArea(
        widthWithoutSafeArea: toDouble(),
      );
}

extension ExtensionOnHeightWithOutToolbar on num {
  /*

  Calculates the height of a widget without taking into account the toolbar.
  The toolbar is the area at the top of the screen that contains the app bar.
  This function is useful for calculating the height of a widget that should be
  displayed below the toolbar.

  */
  double sHWithOutToolbar(BuildContext context) =>
      Responsive.getInstance(context: context).setHeightWithoutToolbar(
        heightWithoutToolbar: toDouble(),
      );
}

extension ExtensionOnHeightWithOutStatusbar on num {
  /*
  
  Calculates the height of a widget without taking into account the status bar.
  The status bar is the area at the top of the screen that contains the time, battery, and other status information.
  This function is useful for calculating the height of a widget that should be displayed below the status bar.
  
  */
  double sHWithOutStatusbar(BuildContext context) =>
      Responsive.getInstance(context: context).setHeightWithoutStatusBar(
        heightWithoutStatusbar: toDouble(),
      );
}
