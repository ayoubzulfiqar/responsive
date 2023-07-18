
# Responsive UI in Flutter: Step-by-Step Implementation

In this article, we will explore how to create a responsive UI in Flutter using the provided code. We'll cover the basics of responsive design, introduce the `Responsive` class, and demonstrate how to use it to create responsive widgets in Flutter. By the end of this article, you'll have a clear understanding of how to make your Flutter apps adapt to different screen sizes and orientations.

## What is Responsive Design?

Responsive design is an approach to web and app development that ensures the user interface (UI) adjusts and looks great on various screen sizes and devices. With the increasing number of device types and screen resolutions, responsive design has become essential to provide a seamless user experience.

In Flutter, responsive design involves using flexible and adaptive layouts and widgets that can adjust their size and position based on the available screen real estate.

## The `Responsive` Class

The provided code includes a `Responsive` class, which encapsulates various methods to help create responsive UIs in Flutter. Let's go through the code step-by-step and understand its functionality.

### Step 1: Importing Dependencies

The code starts with importing the required Flutter packages, mainly the `flutter/material.dart` package.

```dart
import 'package:flutter/material.dart';
```

### Step 2: Defining the `Responsive` Class

The `Responsive` class is defined as an immutable class with several properties and methods to handle responsiveness.

```dart
@immutable
class Responsive {
  final BuildContext context;
  final double deviceHeight;
  final double deviceWidth;
  // ...
}
```

The class contains three properties:

- `context`: A required parameter of type `BuildContext` that represents the context in which the widget is built.
- `deviceHeight`: A `double` value representing the height of the device's screen.
- `deviceWidth`: A `double` value representing the width of the device's screen.

### Step 3: Singleton Pattern Implementation

The class includes a static instance variable `_instance` and a private constructor `_()` to implement the Singleton pattern. This ensures that there is only one instance of the `Responsive` class throughout the application.

```dart
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
```

### Why MediaQuery.sizeOf(context) not MediaQuery.of(context).size

| Feature | `MediaQuery.sizeOf(context)` | `MediaQuery.of(context).size` |
|---|---|---|
| When does it rebuild? | Only when the size of the media changes | Whenever the MediaQueryData changes |
| What does it return? | The size of the media at the time of the last rebuild | The size of the media at the time of the call |
| Performance | More performant, as it only rebuilds when necessary | Less performant, as it rebuilds more often |

In general, you should use `MediaQuery.sizeOf(context)` if you only care about the size of the media, and you don't want your widget to rebuild unnecessarily. You should use `MediaQuery.of(context).size` if you need to know the size of the media at all times, even if it doesn't change.

The `getInstance` factory method is used to retrieve the instance of the `Responsive` class. It takes the `BuildContext` as a required parameter and returns the existing instance if it already exists or creates a new one otherwise.

### Step 4: Helper Methods for Responsiveness

The `Responsive` class provides various helper methods to handle responsiveness:

- `screenSize`: Returns a `Size` object representing the size of the screen.
- `screenPadding`: Returns an `EdgeInsets` object representing the padding of the screen.
- `setWidth`: Calculates the width of a widget based on the device's width and the desired width.
- `setHeight`: Calculates the height of a widget based on the device's height and the desired height.
- `setFontSize`: Scales the font size based on the device's screen size and text scale factor.

The class also includes methods to handle padding and margin calculations from all sides, as well as specific sides (left, right, top, bottom).

### Step 5: Extensions for Concise Usage

To make the usage of the `Responsive` class more concise and readable, the code includes several extension methods. These extensions allow you to call the responsiveness methods directly on numerical values (e.g., `double`, `int`).

For example, instead of calling:

```dart
Responsive.getInstance(context: context).setWidth(width: 20);
```

You can use the extension method:

```dart
20.sW(context);
```

The code includes extensions for width, height, text scale factor, device pixel ratio, font size, padding, margin, radius, and more.

### Step 6: Implementing Responsive Widgets

To create a responsive UI using the `Responsive` class, follow these steps:

1. Import the file where the `Responsive` class is defined.

```dart
import 'responsive.dart';
```

1. Use the `responsive` instance to make your widgets responsive by using the helper methods or the provided extensions.

```dart
Container(
  width: 100.sW(context),
  height: 50.sH(context),
  padding: 10.sP(context),
  margin: 20.sM(context),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.sR(context)),
    color: Colors.blue,
  ),
  child: Text(
    'Responsive Container',
    style: TextStyle(fontSize: 20.sF(context)),
  ),
)
```

By utilizing the `Responsive` class and extensions, you can ensure that your widgets adapt to various screen sizes and devices automatically.

## Conclusion

In this article, we learned about responsive design and explored how to implement a responsive UI in Flutter using the provided `Responsive` class. By using this class and the extensions, you can easily make your widgets adapt to different screen sizes and providing a seamless user experience across various devices.

## Declaimer

Orientation Implementation Coming Soon
