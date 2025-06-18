part of 'package:responsive_master/responsive_master.dart';

enum FlexDisplayType {
  none("none"),
  block("block");

  const FlexDisplayType(this.className);

  final String className;

  bool get isBlock => this == FlexDisplayType.block;

  static FlexDisplayType fromString(String text) {
    return text == FlexDisplayType.none.className
        ? FlexDisplayType.none
        : FlexDisplayType.block;
  }
}

extension ListExtension<T> on List<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
    for (var index = 0; index < length; index++) {
      yield convert(index, this[index]);
    }
  }
}

enum DflexMediaType {
  xs(576, "xs"), // Mobile
  sm(768, "sm"), // Tablet
  md(1200, "md"), // Laptop
  lg(1400, "lg"), // Desktop
  xl(1800, "xl"), // Large Desktop
  xxl(4000, "xxl"); // Extra Large Desktop

  const DflexMediaType(this.width, this.className);

  final double width;
  final String className;

  bool get isMobile => this == DflexMediaType.xs;
  bool get isTablet => this == DflexMediaType.sm;
  bool get isLaptop => this == DflexMediaType.md;
  bool get isMiniDesktop => this == DflexMediaType.lg;
  bool get isDesktop => this == DflexMediaType.xl;

  static final List<DflexMediaType> list = values;
}

class DflexScreenMedia {
  static int flexColumns = 12;
  static double flexSpacing = 24.0;
  static List<DflexMediaType> customBreakpoints = DflexMediaType.list;

  /// Finds the nearest screen type based on the given width.
  static DflexMediaType getTypeFromWidth(double width) {
    return customBreakpoints.firstWhere(
      (type) => width < type.width,
      orElse: () => DflexMediaType.xxl,
    );
  }

  /// Fills missing screen types in the provided map with default values.
  static Map<DflexMediaType, T> getFilledMedia<T>(
    Map<DflexMediaType, T>? map,
    T defaultValue, [
    bool reversed = false,
  ]) {
    map ??= {};
    List<DflexMediaType> types = reversed
        ? customBreakpoints.reversed.toList()
        : customBreakpoints;

    final Map<DflexMediaType, T> result = {};
    for (var i = 0; i < types.length; i++) {
      result[types[i]] =
          map[types[i]] ?? (i > 0 ? result[types[i - 1]] : defaultValue)!;
    }
    return result;
  }

  /// Parses flex data (e.g., "md-6 sm-12") into a map of screen types to column counts.
  static Map<DflexMediaType, double> getFlexedDataFromString(String? input) {
    input ??= "";
    final Map<DflexMediaType, double> flexData = {};

    for (String item in input.split(" ")) {
      for (var type in customBreakpoints) {
        if (item.startsWith("${type.className}-")) {
          double? flex = double.tryParse(
            item.substring(type.className.length + 1),
          );
          if (flex != null) {
            flexData[type] = flex;
          }
        }
      }
    }

    return getFilledMedia(flexData, flexColumns.toDouble());
  }

  /// Parses display type data (e.g., "md-none sm-block") into a map of screen types to `MyDisplayType`.
  static Map<DflexMediaType, FlexDisplayType> getDisplayDataFromString(
    String? input,
  ) {
    input ??= "";
    final Map<DflexMediaType, FlexDisplayType> displayData = {};

    for (String item in input.split(" ")) {
      for (var type in customBreakpoints) {
        if (item.startsWith("${type.className}-")) {
          FlexDisplayType displayType = FlexDisplayType.fromString(
            item.substring(type.className.length + 1),
          );
          displayData[type] = displayType;
        }
      }
    }

    return getFilledMedia(displayData, FlexDisplayType.block);
  }

  /// Allows setting custom breakpoints dynamically.
  static void setBreakpoints(List<DflexMediaType> breakpoints) {
    customBreakpoints = breakpoints;
  }
}

/// Global getters for flex configurations.
double get flexSpacing => DflexScreenMedia.flexSpacing;
int get flexColumns => DflexScreenMedia.flexColumns;
