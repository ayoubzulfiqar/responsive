# 🎯 Advanced Responsive UI for Flutter

A production‑ready, orientation‑aware responsive system for Flutter that works seamlessly across **mobile**, **tablet**, **desktop** (Windows, Linux, macOS), and **web**. Built with extensibility and performance in mind, it retains backward compatibility with the original legacy API while offering a cleaner, more powerful modern interface.


## ✨ Features

- ✅ **Orientation‑Aware Scaling** – Automatically adapts layout and scaling when the device rotates.
- ✅ **Multi‑Platform Support** – Works on Android, iOS, Web, Windows, Linux, and macOS.
- ✅ **Desktop Optimized** – Optional minimum window constraints to prevent over‑scaling on large/resizable windows.
- ✅ **Multiple Scaling Strategies** – Width, height, uniform, fill, and adaptive orientation.
- ✅ **Device Type Detection** – Mobile, tablet, desktop breakpoints for conditional layouts.
- ✅ **Safe Area Helpers** – Pre‑computed values for status bar, toolbar, and safe insets.
- ✅ **Legacy API Compatibility** – All original extensions (`sW`, `sH`, `sF`, `sP`, etc.) are fully supported.
- ✅ **Modern Clean API** – Use `.w()`, `.h()`, `.sp()`, `.r()` for concise and readable code.
- ✅ **Inherited Configuration** – Provide custom scaling configuration to any subtree.
- ✅ **Performance Optimized** – Uses `MediaQuery.sizeOf()` for efficient rebuilds.


## 📦 Installation

Copy the `responsive.dart` file into your project's `lib/` directory.

```yaml
# No external dependencies required – uses only Flutter SDK.
```

---

## 🚀 Quick Start

Wrap your app with `ResponsiveConfigProvider` (optional) to set a custom configuration, or just start using the responsive extensions anywhere in your widget tree.

```dart
import 'package:flutter/material.dart';
import 'responsive.dart';

void main() {
  runApp(
    ResponsiveConfigProvider(
      config: ResponsiveConfig.desktop(), // Optimized for desktop
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 200.w(context),   // 200 scaled width
            height: 100.h(context),  // 100 scaled height
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.r(context)),
            ),
            child: Text(
              'Responsive',
              style: TextStyle(fontSize: 18.sp(context)),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## ⚙️ Configuration

Customize the responsive behavior by providing a `ResponsiveConfig` to a `ResponsiveConfigProvider`.

```dart
ResponsiveConfigProvider(
  config: ResponsiveConfig(
    designSize: const DesignSize(width: 375, height: 812), // Your Figma canvas
    scalingStrategy: ScalingStrategy.adaptiveOrientation,
    breakpoints: const Breakpoints(mobileMaxWidth: 600, tabletMaxWidth: 1024),
    enableDesktopConstraints: true,
    minWindowSize: const Size(800, 600),
    maxScaleFactor: 2.5,
  ),
  child: MyApp(),
)
```

| Parameter | Description | Default |
|-----------|-------------|---------|
| `designSize` | The base design canvas size (e.g., Figma artboard). | `DesignSize.phone` (375x812) |
| `scalingStrategy` | How dimensions are scaled relative to the design. | `ScalingStrategy.width` |
| `breakpoints` | Width thresholds for mobile/tablet/desktop classification. | `mobileMaxWidth: 600`, `tabletMaxWidth: 1024` |
| `enableDesktopConstraints` | Prevents scaling below a minimum window size on desktop. | `true` |
| `minWindowSize` | Minimum effective window size for scaling calculations. | `null` |
| `maxScaleFactor` | Caps the scaling factor to avoid excessive enlargement. | `2.5` |

### Scaling Strategies

| Strategy | Behavior |
|----------|----------|
| `width` | Scale proportionally to screen width (default). |
| `height` | Scale proportionally to screen height. |
| `uniform` | Scale using the smaller of width/height scale factors – preserves aspect ratio. |
| `fill` | Scale using the larger factor – fills the screen, may crop. |
| `adaptiveOrientation` | Uses width‑based scaling in portrait, height‑based in landscape. |

### Predefined Configurations

```dart
// Mobile‑first default
ResponsiveConfig()

// Desktop‑optimized (larger design size, adaptive orientation, min window constraints)
ResponsiveConfig.desktop()
```

---

## 📖 API Reference

### Obtaining the Responsive Instance

```dart
// Recommended: via BuildContext extension
final r = context.responsive;

// Alternative: static method
final r = Responsive.of(context);
```

### Core Scaling Methods

| Method | Description |
|--------|-------------|
| `w(double)` | Scales a width value. |
| `h(double)` | Scales a height value. |
| `sp(double)` | Scales a font size (respects text scaling). |
| `r(double)` | Scales a radius value. |

### Responsive Edge Insets

```dart
EdgeInsets padding = r.edgeInsetsAll(16);
EdgeInsets margin = r.edgeInsetsSymmetric(horizontal: 20, vertical: 10);
EdgeInsets custom = r.edgeInsets(left: 8, top: 12, right: 8, bottom: 12);
```

### Responsive SizedBox

```dart
r.sizedBox(width: 100, height: 50, child: myWidget);
```

### Safe Area Adjusted Values

| Method | Description |
|--------|-------------|
| `hWithoutStatusBar(double)` | Height minus status bar. |
| `hWithoutToolbar(double)` | Height minus status bar + `kToolbarHeight`. |
| `hWithoutSafeArea(double)` | Height minus top & bottom safe insets. |
| `wWithoutSafeArea(double)` | Width minus left & right safe insets. |

**Shorthand extensions (safe area adjusted):**

```dart
60.hns(context)   // Height without status bar
60.hnt(context)   // Height without toolbar
200.wns(context)  // Width without safe area horizontal insets
```

### Device & Orientation Helpers

```dart
// Device type
if (context.isMobile) { ... }
if (context.isTablet) { ... }
if (context.isDesktop) { ... }

// Orientation
if (context.isPortrait) { ... }
if (context.isLandscape) { ... }

// Platform info
if (context.platformInfo.isWindows) { ... }
```

### Conditional Value Selection

```dart
// Different value per device type
final columns = r.valueForDevice(
  mobile: 2,
  tablet: 3,
  desktop: 4,
);

// Orientation‑based
final crossAxisCount = r.valueForOrientation(
  portrait: 2,
  landscape: 3,
);

// Complex condition (device + orientation)
final layout = r.valueWhen(
  mobilePortrait: mobilePortraitLayout,
  tabletLandscape: tabletLandscapeLayout,
  fallback: defaultLayout,
);
```

### Legacy API (Fully Supported)

All original extensions are still available and work correctly with the new system:

| Extension | Description |
|-----------|-------------|
| `num.sW(context)` | Responsive width |
| `num.sH(context)` | Responsive height |
| `num.sF(context)` | Responsive font size |
| `num.sP(context)` | All‑sides padding |
| `num.sM(context)` | All‑sides margin |
| `num.sR(context)` | Responsive radius |
| `num.sSW(context)` | Width space (same as `sW`) |
| `num.sSH(context)` | Height space (same as `sH`) |
| `num.sLP(context)` | Left padding |
| `num.sRP(context)` | Right padding |
| `num.sTP(context)` | Top padding |
| `num.sBP(context)` | Bottom padding |
| `num.sLM(context)` | Left margin |
| `num.sRM(context)` | Right margin |
| `num.sTM(context)` | Top margin |
| `num.sBM(context)` | Bottom margin |
| `num.tSF(context)` | Text scale factor |
| `num.dPRatio(context)` | Device pixel ratio |
| `num.sHWithOutSafeArea(context)` | Height without safe area |
| `num.sWWithOutSafeArea(context)` | Width without safe area |
| `num.sHWithOutToolbar(context)` | Height without toolbar |
| `num.sHWithOutStatusbar(context)` | Height without status bar |

---

## 🧪 Example Application

A complete showcase example is included in `example.dart`. It demonstrates:

- Device info and scaling factor display
- Side‑by‑side comparison of modern, legacy, and fixed sizing
- Orientation‑aware layout switching
- Device‑type conditional rendering
- Responsive spacing, radius, and safe‑area adjusted containers

Run the example on multiple devices/emulators or desktop to see the responsive behavior in action.

---

## 🔧 Advanced Usage

### Providing a Custom Configuration to a Subtree

Wrap any part of your widget tree with `ResponsiveConfigProvider` to override the configuration locally.

```dart
ResponsiveConfigProvider(
  config: ResponsiveConfig(
    designSize: const DesignSize(width: 1440, height: 900),
    scalingStrategy: ScalingStrategy.uniform,
  ),
  child: DashboardScreen(),
)
```

### Using `MediaQuery.removePadding` Helper

```dart
r.removePadding(child: MyWidget())
```

### Accessing Raw Scaling Factors

```dart
final r = context.responsive;
print('Scale Width: ${r.scaleWidth}');
print('Scale Height: ${r.scaleHeight}');
print('Uniform Scale: ${r.scaleUniform}');
```

---

## ❓ IMPROVEMENTS?

| Original Issue | Fixed in This Version |
|----------------|------------------------|
| Cached `BuildContext` in singleton caused stale dimensions after navigation/orientation change. | Fresh context every call, no singleton. |
| Incorrect margin calculations (returned coordinates, not lengths). | Margins are now properly scaled lengths. |
| Magic number `-20` in top padding. | Removed; correct safe‑area handling. |
| Deprecated `MediaQuery.textScaleFactor` usage. | Uses modern `MediaQuery.textScaler`. |
| No orientation awareness. | Full orientation detection and adaptive scaling. |
| No desktop/window constraints. | Optional minimum window size for desktop apps. |
| Cryptic extension names. | Retained for compatibility; added clean modern aliases. |

---

## 📄 License

MIT (Probably)
