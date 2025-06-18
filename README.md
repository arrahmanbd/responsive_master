
<div align="center">
  <img src="https://raw.githubusercontent.com/arrahmanbd/responsive_master/master/images/icon_solid.png" width="100" alt="Responsive Master Logo"/>
</div>

# Responsive Master

**Responsive Master** is a powerful Flutter package designed to simplify responsive UI development. It provides a modular, scalable system with intuitive units and a Bootstrap-style grid for creating layouts that adapt smoothly across screens and devices.

[![pub package](https://img.shields.io/pub/v/flutter_addons.svg)](https://pub.dev/packages/flutter_addons)

---

## Key Features

* `ResponsiveScope`: Core wrapper that handles layout scaling, screen orientation, and error handling
* Design-aware scaling based on Figma or Adobe XD frames
* Responsive units:`h `,`w`,`r`, `ph`, `pw`, `sp`, and more
* Breakpoint extensions: `context.isXs`, `context.isMd`, `context.isLg`, etc.
* Bootstrap-style grid system with rows, columns, nesting, offsets, and visibility controls
* Extension-based API for clean, readable code

---

## Screenshots

<table align="center">
  <tr>
    <td align="center" colspan="2">
      <strong>Desktop View</strong><br/>
      <img src="https://raw.githubusercontent.com/arrahmanbd/responsive_master/master/images/screenshot.png" width="600" alt="Responsive Grid - Desktop View"/>
    </td>
  </tr>
  <tr>
    <td align="center">
      <strong>Mobile View</strong><br/>
      <img src="https://raw.githubusercontent.com/arrahmanbd/responsive_master/master/images/mobile_screen.png" width="300" alt="Responsive Grid - Mobile View"/>
    </td>
    <td align="center">
      <strong>Error Screen</strong><br/>
      <img src="https://raw.githubusercontent.com/arrahmanbd/responsive_master/master/images/error_screen.png" width="300" alt="Responsive Grid - Error View"/>
    </td>
  </tr>
</table>

---

## Getting Started

Wrap your app with `ResponsiveScope` to enable layout scaling and adaptive behavior:

```dart
ResponsiveScope( // 👈  ResponsiveScope — VERY Important: Manages layout scaling, orientation lock, and global error handling
  enableDebugLogging: true, // Enable debug logs for responsive layout changes
  screenLock: AppOrientationLock.none, // No orientation restriction
  errorScreen: ErrorScreen.blueCrash, // Custom error screen for uncaught Flutter errors
  designFrame: const Frame(width: 390, height: 844), // Base design frame for scaling (e.g., iPhone 13)
  scaleMode: ScaleMode.design, // Use design-based scaling for consistent UI
  layoutBuilder: (ui) {
    // Handle layout changes based on screen size/orientation
    if (ui.isLandscape) {
      throw UnimplementedError(
        'Landscape layout is not implemented yet. '
        'Please handle different screen orientations.',
      );
    }
    return const MobileApp();
  },
);
```

> Note: To enable proper scaling, make sure to provide a `ScaleMode`. Default is Percentange.

---

## Recommended Responsive Units

These units are optimized for adaptive layout and automatically adjust based on screen size or design scale mode.

| Unit     | Description                                   | Example                                 |
|----------|-----------------------------------------------|-----------------------------------------|
| `50.ph`  | 50% of screen height                          | `SizedBox(height: 50.ph)`               |
| `25.pw`  | 25% of screen width                           | `SizedBox(width: 25.pw)`                |
| `14.sp`  | Scaled font size based on screen dimensions   | `TextStyle(fontSize: 14.sp)`            |
| `16.h`   | Auto-scaled height based on `ScaleMode`       | `SizedBox(height: 16.h)`                |
| `16.w`   | Auto-scaled width based on `ScaleMode`        | `SizedBox(width: 16.w)`                 |
| `16.s`   | Responsive square box (height = width)        | `SizedBox.square(dimension: 16.s)`      |
| `8.r`    | Scaled radius based on screen width or design | `BorderRadius.circular(8.r)`            |

> ℹ️ Use `.h`, `.w`, `.s`, `.sp`, and `.r` for layouts that scale consistently across all devices and design sizes.

---

## Spacing Extension Reference

The Spacing extension provides quick, expressive syntax for margins, paddings, and spacing widgets based on integer values.

| Syntax | Margin Description              | Margin Example | Padding Description                | Padding Example |
|--------|----------------------------------|----------------|------------------------------------|------------------|
| `.m`   | Margin on all sides              | `10.m`         | Padding on all sides              | `10.p`           |
| `.mt`  | Margin on top                    | `10.mt`        | Padding on top                    | `10.pt`          |
| `.mb`  | Margin on bottom                 | `10.mb`        | Padding on bottom                 | `10.pb`          |
| `.ml`  | Margin on left                   | `10.ml`        | Padding on left                   | `10.pl`          |
| `.mr`  | Margin on right                  | `10.mr`        | Padding on right                  | `10.pr`          |
| `.mx`  | Horizontal margin (left & right) | `10.mx`        | Horizontal padding (left & right) | `10.px`          |
| `.my`  | Vertical margin (top & bottom)   | `10.my`        | Vertical padding (top & bottom)   | `10.py`          |

## Breakpoint Utilities

Use contextual extensions for conditional rendering based on screen width:

```dart
if (context.isXs) {
  print("Extra small screen");
} else if (context.isLg) {
  print("Large screen layout");
}
```

| Breakpoint | Width Range      | Description          |
| ---------- | ---------------- | -------------------- |
| `isXs`     | `< 576px`        | Extra small devices  |
| `isSm`     | `576px - 767px`  | Small phones         |
| `isMd`     | `768px - 991px`  | Medium tablets       |
| `isLg`     | `992px - 1199px` | Large desktops       |
| `isXl`     | `≥ 1200px`       | Extra-large displays |

---

## Grid Layout System [**Experimental**]


> ⚠️ **Note:**
> Some layout features such as `Dflex`, `Grid`, and `Col` are currently **experimental** and may undergo breaking changes in future versions.
> All core features—like responsive units, `ResponsiveScope`, breakpoints, and spacing extensions—are **stable and production-ready**.


A responsive layout system inspired by Bootstrap:

```dart
Row(
  children: [
    Col(xs: 6, child: Container(color: Colors.red)),
    Col(xs: 6, offset: 2, child: Container(color: Colors.blue)),
  ],
)
```

### Grid Features

* Column offsets and nesting
* `GridContainer` for fixed-width centered layouts
* Visibility controls: `HiddenOn`, `VisibleOn`
* Responsive layouts for complex UIs

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  responsive_master: ^1.0.0
```



## Contributing

Contributions are welcome. Feel free to open issues or submit pull requests to help improve the package for the Flutter community.

---

## License

This package is distributed under the MIT License. See the [`LICENSE`](./LICENSE) file for details.


