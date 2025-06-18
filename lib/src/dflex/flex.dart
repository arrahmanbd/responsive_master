part of 'package:responsive_master/responsive_master.dart';

class ResponsiveFlex extends StatelessWidget {
  final Widget Function(BuildContext, BoxConstraints, DflexMediaType) builder;

  const ResponsiveFlex({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = DflexScreenMedia.getTypeFromWidth(
          MediaQuery.of(context).size.width,
        );
        return builder(context, constraints, screenType);
      },
    );
  }
}

class Dflex extends StatelessWidget {
  final List<DFlexItem> children;
  final WrapAlignment wrapAlignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final WrapAlignment runAlignment;
  final bool contentPadding;
  final double? spacing, runSpacing;

  const Dflex({
    super.key,
    required this.children,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapCrossAlignment = WrapCrossAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.contentPadding = true,
    this.spacing,
    this.runSpacing,
  });

  EdgeInsets getPadding(int index, int length) {
    double space = spacing ?? flexSpacing;
    return contentPadding
        ? EdgeInsets.symmetric(horizontal: space / 2)
        : EdgeInsets.fromLTRB(
            index == 0 ? 0 : space / 2,
            0,
            index == length - 1 ? 0 : space / 2,
            0,
          );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveFlex(
      builder: (context, constraints, screenType) {
        double width = constraints.maxWidth;
        List<Widget> list = [];

        for (List<DFlexItem> rowItems in getGrouped(screenType)) {
          list.addAll(
            rowItems.asMap().entries.map((entry) {
              int index = entry.key;
              DFlexItem col = entry.value;

              return Visibility(
                visible: col.isVisible(screenType),
                child: Container(
                  width: getWidthFromFlex(
                    width,
                    col.flex[screenType] ??
                        DflexScreenMedia.flexColumns.toDouble(),
                    rowItems.length,
                    spacing ?? flexSpacing,
                  ),
                  padding: getPadding(index, rowItems.length),
                  child: col,
                ),
              );
            }),
          );
        }

        return Wrap(
          crossAxisAlignment: wrapCrossAlignment,
          alignment: wrapAlignment,
          runAlignment: runAlignment,
          runSpacing: runSpacing ?? flexSpacing,
          spacing: spacing ?? 0,
          children: list,
        );
      },
    );
  }

  List<List<DFlexItem>> getGrouped(DflexMediaType type) {
    List<List<DFlexItem>> groupedItems = [];
    List<DFlexItem> currentRow = [];
    double flexCount = 0;

    for (DFlexItem item in children) {
      if (item.isVisible(type)) {
        double flex =
            item.flex[type] ?? DflexScreenMedia.flexColumns.toDouble();

        if (flexCount + flex <= DflexScreenMedia.flexColumns) {
          currentRow.add(item);
          flexCount += flex;
        } else {
          groupedItems.add(List.of(currentRow));
          currentRow.clear();
          currentRow.add(item);
          flexCount = flex;
        }
      }
    }

    if (currentRow.isNotEmpty) {
      groupedItems.add(currentRow);
    }
    return groupedItems;
  }

  double getWidthFromFlex(
    double width,
    double flex,
    int items,
    double spacing,
  ) {
    return (width * flex / DflexScreenMedia.flexColumns).floorToDouble();
  }
}

class DFlexItem extends StatelessWidget {
  final Widget child;
  final String? sizes;

  const DFlexItem({super.key, required this.child, this.sizes});

  /// Extracts flex values from sizes string (e.g., `"md-6 sm-none"`)
  Map<DflexMediaType, double> get flex =>
      DflexScreenMedia.getFlexedDataFromString(sizes);

  /// Checks if the item should be visible
  bool isVisible(DflexMediaType type) {
    return flex[type] != 0; // If flex is 0, it means `none`
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
