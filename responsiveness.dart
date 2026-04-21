import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// CONFIGURATION

/// Defines how dimensions are scaled relative to the design size.
enum ScalingStrategy {
  /// Always scale based on width (default).
  width,

  /// Always scale based on height.
  height,

  /// Scale based on the smaller dimension (uniform scaling, preserves aspect ratio).
  uniform,

  /// Scale based on the larger dimension.
  fill,

  /// Width‑based in portrait, height‑based in landscape.
  adaptiveOrientation,
}

/// Platform categories for targeted adjustments.
enum PlatformType { mobile, tablet, desktop, web }

/// Breakpoint configuration for device type detection.
class Breakpoints {
  final double mobileMaxWidth;
  final double tabletMaxWidth;

  const Breakpoints({
    this.mobileMaxWidth = 600,
    this.tabletMaxWidth = 1024,
  });

  static const defaultBreakpoints = Breakpoints();
}

/// Global configuration for the responsive system.
class ResponsiveConfig {
  final DesignSize designSize;
  final ScalingStrategy scalingStrategy;
  final Breakpoints breakpoints;
  final bool enableDesktopConstraints;
  final Size? minWindowSize;
  final double maxScaleFactor;

  const ResponsiveConfig({
    this.designSize = DesignSize.phone,
    this.scalingStrategy = ScalingStrategy.width,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    this.enableDesktopConstraints = true,
    this.minWindowSize,
    this.maxScaleFactor = 2.5,
  });

  /// Creates a configuration optimized for desktop applications.
  factory ResponsiveConfig.desktop({
    DesignSize designSize = const DesignSize(width: 1280, height: 720),
    ScalingStrategy scalingStrategy = ScalingStrategy.adaptiveOrientation,
    Size minWindowSize = const Size(800, 600),
  }) {
    return ResponsiveConfig(
      designSize: designSize,
      scalingStrategy: scalingStrategy,
      enableDesktopConstraints: true,
      minWindowSize: minWindowSize,
      breakpoints: const Breakpoints(mobileMaxWidth: 800, tabletMaxWidth: 1200),
    );
  }
}

/// Base design dimensions (canvas size used by designers).
@immutable
class DesignSize {
  final double width;
  final double height;

  const DesignSize({required this.width, required this.height});

  static const phone = DesignSize(width: 375, height: 812);
  static const tablet = DesignSize(width: 768, height: 1024);
  static const desktop = DesignSize(width: 1440, height: 900);

  double get aspectRatio => width / height;
}

// ---------------------------------------------------------------------
// DEVICE & PLATFORM DETECTION
// ---------------------------------------------------------------------

enum DeviceType { mobile, tablet, desktop }

/// Platform information with desktop specifics.
class PlatformInfo {
  final bool isAndroid;
  final bool isIOS;
  final bool isWindows;
  final bool isLinux;
  final bool isMacOS;
  final bool isFuchsia;
  final bool isWeb;
  final bool isMobile;
  final bool isDesktop;
  final bool isApple;
  final bool isMicrosoft;

  const PlatformInfo({
    required this.isAndroid,
    required this.isIOS,
    required this.isWindows,
    required this.isLinux,
    required this.isMacOS,
    required this.isFuchsia,
    required this.isWeb,
    required this.isMobile,
    required this.isDesktop,
    required this.isApple,
    required this.isMicrosoft,
  });

  factory PlatformInfo.fromEnvironment() {
    final isWeb = kIsWeb;
    final isAndroid = !isWeb && Platform.isAndroid;
    final isIOS = !isWeb && Platform.isIOS;
    final isWindows = !isWeb && Platform.isWindows;
    final isLinux = !isWeb && Platform.isLinux;
    final isMacOS = !isWeb && Platform.isMacOS;
    final isFuchsia = !isWeb && Platform.isFuchsia;
    final isMobile = isAndroid || isIOS;
    final isDesktop = isWindows || isLinux || isMacOS;
    final isApple = isIOS || isMacOS;
    final isMicrosoft = isWindows;

    return PlatformInfo(
      isAndroid: isAndroid,
      isIOS: isIOS,
      isWindows: isWindows,
      isLinux: isLinux,
      isMacOS: isMacOS,
      isFuchsia: isFuchsia,
      isWeb: isWeb,
      isMobile: isMobile,
      isDesktop: isDesktop,
      isApple: isApple,
      isMicrosoft: isMicrosoft,
    );
  }
}

extension DeviceTypeContextExtension on BuildContext {
  DeviceType get deviceType {
    final width = MediaQuery.sizeOf(this).width;
    final config = Responsive._configOf(this) ?? const ResponsiveConfig();
    if (width < config.breakpoints.mobileMaxWidth) return DeviceType.mobile;
    if (width < config.breakpoints.tabletMaxWidth) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  Orientation get orientation => MediaQuery.orientationOf(this);
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  PlatformInfo get platformInfo => _platformInfoCache ??= PlatformInfo.fromEnvironment();
  static PlatformInfo? _platformInfoCache;
}


// RESPONSIVE CORE


/// Main responsive utility class.
/// Use `Responsive.of(context)` or `context.responsive` to obtain an instance.
@immutable
class Responsive {
  final BuildContext context;
  final ResponsiveConfig config;

  Responsive._({required this.context, required this.config});

  /// Retrieves the responsive instance from the current context.
  /// Prefer this over creating new instances to benefit from caching.
  static Responsive of(BuildContext context, {ResponsiveConfig? config}) {
    // Check if we already cached an instance in the widget tree
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_ResponsiveScope>();
    if (inherited != null) {
      return inherited.responsive;
    }
    // Fallback: create a new instance with provided or default config
    final effectiveConfig = config ?? _configOf(context) ?? const ResponsiveConfig();
    return Responsive._(context: context, config: effectiveConfig);
  }

  static ResponsiveConfig? _configOf(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_ResponsiveScope>();
    return scope?.responsive.config;
  }

  // ----- CURRENT DIMENSIONS -----
  Size get screenSize => MediaQuery.sizeOf(context);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => MediaQuery.paddingOf(context);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(context);
  TextScaler get textScaler => MediaQuery.textScalerOf(context);
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(context);
  Orientation get orientation => MediaQuery.orientationOf(context);
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // ----- EFFECTIVE DESIGN SIZE (orientation‑aware) -----
  DesignSize get _effectiveDesignSize {
    if (config.scalingStrategy != ScalingStrategy.adaptiveOrientation) {
      return config.designSize;
    }
    // Swap width/height in landscape if using adaptive orientation
    if (isLandscape) {
      return DesignSize(
        width: config.designSize.height,
        height: config.designSize.width,
      );
    }
    return config.designSize;
  }

  double get _designWidth => _effectiveDesignSize.width;
  double get _designHeight => _effectiveDesignSize.height;

  // ----- DESKTOP CONSTRAINTS -----
  bool get _shouldApplyDesktopConstraints =>
      config.enableDesktopConstraints &&
      (context.isDesktop || context.isWeb);

  double get _constrainedScreenWidth {
    var w = screenWidth;
    if (_shouldApplyDesktopConstraints && config.minWindowSize != null) {
      w = w < config.minWindowSize!.width ? config.minWindowSize!.width : w;
    }
    return w;
  }

  double get _constrainedScreenHeight {
    var h = screenHeight;
    if (_shouldApplyDesktopConstraints && config.minWindowSize != null) {
      h = h < config.minWindowSize!.height ? config.minWindowSize!.height : h;
    }
    return h;
  }

  // ----- SCALING FACTORS -----
  double get scaleWidth {
    final base = _constrainedScreenWidth / _designWidth;
    return _clampScale(base);
  }

  double get scaleHeight {
    final base = _constrainedScreenHeight / _designHeight;
    return _clampScale(base);
  }

  double get scaleUniform {
    final base = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;
    return _clampScale(base);
  }

  double get scaleFill {
    final base = scaleWidth > scaleHeight ? scaleWidth : scaleHeight;
    return _clampScale(base);
  }

  double _clampScale(double scale) {
    if (config.maxScaleFactor > 0) {
      return scale.clamp(0.0, config.maxScaleFactor);
    }
    return scale;
  }

  /// The scaling factor used by the core methods (w, h, sp, r).
  double get _activeScale {
    switch (config.scalingStrategy) {
      case ScalingStrategy.width:
        return scaleWidth;
      case ScalingStrategy.height:
        return scaleHeight;
      case ScalingStrategy.uniform:
        return scaleUniform;
      case ScalingStrategy.fill:
        return scaleFill;
      case ScalingStrategy.adaptiveOrientation:
        return isPortrait ? scaleWidth : scaleHeight;
    }
  }

  // -----------------------------------------------------------------
  // ORIGINAL API (100% COMPATIBLE)
  // -----------------------------------------------------------------

  double setWidth({required double width}) => width * scaleWidth;
  double setHeight({required double height}) => height * scaleHeight;
  double setWidthSpace({required double width}) => setWidth(width: width);
  double setHeightSpace({required double height}) => setHeight(height: height);

  double setFontSize({required double fontSize}) {
    final base = fontSize * scaleUniform;
    return textScaler.scale(base);
  }

  double setTextScaleFactor({required double textScaleFactor}) {
    if (textScaleFactor == 0) return 0.0;
    return textScaler.scale(1.0) / textScaleFactor;
  }

  double setBottomPadding({required double padding}) => padding + this.padding.bottom;
  double setLeftPadding({required double padding}) => padding + this.padding.left;
  double setRightPadding({required double padding}) => padding + this.padding.right;
  double setTopPadding({required double padding}) => padding + this.padding.top;

  double setPadding({required double padding}) {
    return padding + this.padding.top + this.padding.bottom +
        this.padding.left + this.padding.right;
  }

  double setBottomMargin({required double margin}) => margin * scaleHeight;
  double setLeftMargin({required double margin}) => margin * scaleWidth;
  double setRightMargin({required double margin}) => margin * scaleWidth;
  double setTopMargin({required double margin}) => margin * scaleHeight;
  double setMargin({required double margin}) => margin * scaleUniform;

  double setHeightWithoutSafeArea({required double heightWithoutSafeArea}) {
    final scaled = setHeight(height: heightWithoutSafeArea);
    return scaled - padding.top - padding.bottom;
  }

  double setWidthWithoutSafeArea({required double widthWithoutSafeArea}) {
    final scaled = setWidth(width: widthWithoutSafeArea);
    return scaled - padding.left - padding.right;
  }

  double setHeightWithoutStatusBar({required double heightWithoutStatusbar}) {
    final scaled = setHeight(height: heightWithoutStatusbar);
    return scaled - padding.top;
  }

  double setHeightWithoutToolbar({required double heightWithoutToolbar}) {
    final scaled = setHeight(height: heightWithoutToolbar);
    return scaled - padding.top - kToolbarHeight;
  }

  double setRadius({required double radius}) => radius * scaleUniform;

  MediaQueryData removeAllPadding() {
    return MediaQuery.of(context).removePadding(
      removeLeft: true,
      removeRight: true,
      removeBottom: true,
      removeTop: true,
    );
  }

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

  double get setDevicePixelRatio => devicePixelRatio.abs();

  // -----------------------------------------------------------------
  // NEW ADVANCED METHODS
  // -----------------------------------------------------------------

  /// Scales a width using the active scaling strategy.
  double w(double width) => width * _activeScale;

  /// Scales a height using the active scaling strategy.
  double h(double height) => height * _activeScale;

  /// Scales a font size with text scaling.
  double sp(double fontSize) {
    final base = fontSize * scaleUniform;
    return textScaler.scale(base);
  }

  /// Scales a radius.
  double r(double radius) => radius * scaleUniform;

  /// Returns responsive edge insets.
  EdgeInsets edgeInsets({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.fromLTRB(
      w(left),
      h(top),
      w(right),
      h(bottom),
    );
  }

  EdgeInsets edgeInsetsAll(double value) => EdgeInsets.all(w(value));
  EdgeInsets edgeInsetsSymmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: w(horizontal), vertical: h(vertical));

  /// Returns a responsive SizedBox.
  Widget sizedBox({double? width, double? height, Widget? child}) {
    return SizedBox(
      width: width != null ? w(width) : null,
      height: height != null ? h(height) : null,
      child: child,
    );
  }

  /// Conditional value based on device type.
  T valueForDevice<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return switch (context.deviceType) {
      DeviceType.mobile => mobile,
      DeviceType.tablet => tablet ?? mobile,
      DeviceType.desktop => desktop ?? tablet ?? mobile,
    };
  }

  /// Conditional value based on orientation.
  T valueForOrientation<T>({
    required T portrait,
    required T landscape,
  }) {
    return isPortrait ? portrait : landscape;
  }

  /// Complex conditional based on multiple factors.
  T valueWhen<T>({
    T? mobilePortrait,
    T? mobileLandscape,
    T? tabletPortrait,
    T? tabletLandscape,
    T? desktopPortrait,
    T? desktopLandscape,
    required T fallback,
  }) {
    final isPort = isPortrait;
    final device = context.deviceType;
    if (device == DeviceType.mobile) {
      return (isPort ? mobilePortrait : mobileLandscape) ?? fallback;
    }
    if (device == DeviceType.tablet) {
      return (isPort ? tabletPortrait : tabletLandscape) ?? fallback;
    }
    return (isPort ? desktopPortrait : desktopLandscape) ?? fallback;
  }

  /// Returns true if the screen is considered "large" (tablet/desktop).
  bool get isLargeScreen => context.deviceType != DeviceType.mobile;

  /// Whether the current platform is desktop (Windows, Linux, macOS).
  bool get isDesktopPlatform => context.platformInfo.isDesktop;

  /// Gets the current window size constraints (useful for desktop).
  Size get windowSize => screenSize;
}

// -----------------------------------------------------------------
// INHERITED WIDGET FOR CONFIGURATION SCOPE
// -----------------------------------------------------------------

class _ResponsiveScope extends InheritedWidget {
  final Responsive responsive;

  const _ResponsiveScope({
    required this.responsive,
    required super.child,
  });

  @override
  bool updateShouldNotify(_ResponsiveScope oldWidget) {
    return responsive.config != oldWidget.responsive.config;
  }
}

/// Provides a custom [ResponsiveConfig] to a subtree.
class ResponsiveConfigProvider extends StatelessWidget {
  final ResponsiveConfig config;
  final Widget child;

  const ResponsiveConfigProvider({
    super.key,
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _ResponsiveScope(
      responsive: Responsive._(context: context, config: config),
      child: child,
    );
  }
}

// -----------------------------------------------------------------
// EXTENSIONS (ORIGINAL NAMES + NEW CLEAN ONES)
// -----------------------------------------------------------------

extension ResponsiveContextExtension on BuildContext {
  /// Returns the responsive instance for this context.
  Responsive get responsive => Responsive.of(this);
}

// Original extensions (preserved for backward compatibility)
extension ExtensionOnWidth on num {
  double sW(BuildContext context) => Responsive.of(context).setWidth(width: toDouble());
}

extension ExtensionOnHeight on num {
  double sH(BuildContext context) => Responsive.of(context).setHeight(height: toDouble());
}

extension ExtensionOnTextScaleFactor on num {
  double tSF(BuildContext context) => Responsive.of(context).setTextScaleFactor(textScaleFactor: toDouble());
}

extension ExtensionOnDevicePixelRatio on num {
  double dPRatio(BuildContext context) => Responsive.of(context).setDevicePixelRatio;
}

extension ExtensionOnFontSize on num {
  double sF(BuildContext context) => Responsive.of(context).setFontSize(fontSize: toDouble());
}

extension ExtensionOnPadding on num {
  double sP(BuildContext context) => Responsive.of(context).setPadding(padding: toDouble());
}

extension ExtensionOnLeftPadding on num {
  double sLP(BuildContext context) => Responsive.of(context).setLeftPadding(padding: toDouble());
}

extension ExtensionOnRightPadding on num {
  double sRP(BuildContext context) => Responsive.of(context).setRightPadding(padding: toDouble());
}

extension ExtensionOnTopPadding on num {
  double sTP(BuildContext context) => Responsive.of(context).setTopPadding(padding: toDouble());
}

extension ExtensionOnBottomPadding on num {
  double sBP(BuildContext context) => Responsive.of(context).setBottomPadding(padding: toDouble());
}

extension ExtensionOnWidgetPadding on num {
  rAChildPadding(BuildContext context, {required Widget child}) =>
      Responsive.of(context).removeAllPaddingWithWidget(child: child);
}

extension ExtensionOnMargin on num {
  double sM(BuildContext context) => Responsive.of(context).setMargin(margin: toDouble());
}

extension ExtensionOnLeftMargin on num {
  double sLM(BuildContext context) => Responsive.of(context).setLeftMargin(margin: toDouble());
}

extension ExtensionOnRightMargin on num {
  double sRM(BuildContext context) => Responsive.of(context).setRightMargin(margin: toDouble());
}

extension ExtensionOnTopMargin on num {
  double sTM(BuildContext context) => Responsive.of(context).setTopMargin(margin: toDouble());
}

extension ExtensionOnBottomMargin on num {
  double sBM(BuildContext context) => Responsive.of(context).setBottomMargin(margin: toDouble());
}

extension ExtensionOnRadius on num {
  double sR(BuildContext context) => Responsive.of(context).setRadius(radius: toDouble());
}

extension ExtensionOnSpaceWidth on num {
  double sSW(BuildContext context) => Responsive.of(context).setWidthSpace(width: toDouble());
}

extension ExtensionOnSpaceHeight on num {
  double sSH(BuildContext context) => Responsive.of(context).setHeightSpace(height: toDouble());
}

extension ExtensionOnHeightWithOutSafeArea on num {
  double sHWithOutSafeArea(BuildContext context) =>
      Responsive.of(context).setHeightWithoutSafeArea(heightWithoutSafeArea: toDouble());
}

extension ExtensionOnWidthWithOutSafeArea on num {
  double sWWithOutSafeArea(BuildContext context) =>
      Responsive.of(context).setWidthWithoutSafeArea(widthWithoutSafeArea: toDouble());
}

extension ExtensionOnHeightWithOutToolbar on num {
  double sHWithOutToolbar(BuildContext context) =>
      Responsive.of(context).setHeightWithoutToolbar(heightWithoutToolbar: toDouble());
}

extension ExtensionOnHeightWithOutStatusbar on num {
  double sHWithOutStatusbar(BuildContext context) =>
      Responsive.of(context).setHeightWithoutStatusBar(heightWithoutStatusbar: toDouble());
}

// Clean modern extensions (recommended for new code)
extension ResponsiveNumExtension on num {
  double w(BuildContext context) => Responsive.of(context).w(toDouble());
  double h(BuildContext context) => Responsive.of(context).h(toDouble());
  double sp(BuildContext context) => Responsive.of(context).sp(toDouble());
  double r(BuildContext context) => Responsive.of(context).r(toDouble());
}
