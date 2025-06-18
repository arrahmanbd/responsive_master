part of 'package:responsive_master/responsive_master.dart';

enum ScaleMode { smart, design, percent }

/// Defines the operating platform the app is currently running on.
enum OSType { android, ios, fuchsia, web, windows, mac, linux, unknown }

/// Defines the general screen size category for the current device.
enum ScreenType { mobile, tablet, desktop }

/// unified widget function
typedef ResponsiveBuilderType =
    Widget Function(
      BuildContext context,
      Orientation orientation,
      ScreenType screenType,
    );

/// error page design
enum ErrorScreen {
  pixelArt,
  catHacker,
  frost,
  blueCrash,
  brokenRobot,
  simple,
  codeTerminal,
  sifi,
  theater,
  dessert,
  book,
}

enum ResponsiveTransition { fade, slide, scale, slideScale, rotation, flip }

/// Defines the orientation of the device.
enum ScreenSize { xs, sm, md, lg, xl }

ScreenSize getScreenSize(double width) {
  if (width < 576) return ScreenSize.xs;
  if (width < 768) return ScreenSize.sm;
  if (width < 992) return ScreenSize.md;
  if (width < 1200) return ScreenSize.lg;
  return ScreenSize.xl;
}