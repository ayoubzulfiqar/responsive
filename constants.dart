import 'package:flutter/widgets.dart';

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

  Size get size => MediaQuery.of(context).size;

  double getWidth({required double width}) {
    return MediaQuery.of(context).size.width / (deviceWidth / width);
  }

  double getHeight({required double height}) {
    return MediaQuery.of(context).size.height / (deviceHeight / height);
  }

  double getFontSize({required double fontSize}) {
    return MediaQuery.of(context).size.width / (deviceWidth / fontSize);
  }

  double getTextScaleFactor({required double textScaleFactor}) {
    return MediaQuery.of(context).textScaleFactor / textScaleFactor;
  }

  MediaQueryData removeAllPadding() => MediaQuery.of(context).removePadding(
      removeLeft: true, removeRight: true, removeBottom: true, removeTop: true);

  double getDevicePixelRatio() => MediaQuery.of(context).devicePixelRatio;

  double getBottomPadding({required double padding}) {
    return MediaQuery.of(context).padding.bottom + padding;
  }

  double getLeftPadding({required double padding}) {
    return MediaQuery.of(context).padding.left + padding;
  }

  double getRightPadding({required double padding}) {
    return MediaQuery.of(context).padding.right + padding;
  }

  double getTopPadding({required double padding}) {
    return MediaQuery.of(context).padding.top + padding - 20;
  }
}



/*


padding
MediaQuery.of(context).size.width / 10


*/